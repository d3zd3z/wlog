# Read the journal for a single day.
#
# TODO: Figure out proper interaction of Rails and SQLite times.
# Sqlite doesn't store a timezone, so it is probably assumed to be
# UTC.

class Reader
  def initialize
    @day = nil
    @user = User.find_by_login('davidb')
    raise "No 'davidb' user" unless @user
  end

  def scan(file)
    file.each do |line|
      line.chomp!
      next if line =~ /^\s*$/
      next if line =~ /^\s*#/
      if line =~ /^weight\s*=\s*([\d\.]+)$/
        next
      end

      if line =~ /^(\d{4}-\d\d-\d\d):$/
        setup_day($1)
        @day = Day.find_or_create_by_day_and_week_id($1, @week.id)
        next
      end

      # MR entries, with a kind, but no count field.
      if line =~ /^\s+(\d\d:\d\d) (S|E|B) (.*)/
        add_eat($1, $2, $3, 1.0)
        next
      end

      # Counted things.
      if line =~ /^\s+(\d\d:\d\d) (F|V|P) ([\d\.]+) (.*)/
        add_eat($1, $2, $4, $3)
        next
      end

      # Cereal, a special case.
      if line =~ /^\s+(\d\d:\d\d) C/
        add_eat($1, 'C', 'cereal', 1.0)
        next
      end

      # PA.
      if line =~ /\s+(\d\d:\d\d) PA (\d+) (.*)/
        need_day
        LinePa.create(:day => @day, :calories => $2,
                      :kind => $3, :time => $1)
        next
      end

      raise "Unsupported line: #{line}"
    end

    @week.save
  end

  private

  def need_day
    raise "Entry before date given" unless @day
  end

  def setup_day(day)
    unless @week
      @week = Week.find_or_create_by_start_and_user_id(day, @user.id)
      @week.days.clear
    end
    @day = Day.find_or_create_by_day_and_week_id(day, @week.id)
  end

  def add_eat(time, category, name, count)
    need_day
    food = Food.find_by_category_and_name(category, name)
    raise "Unknown food type: #{category}, #{name}" unless food
    LineEat.create(:day_id => @day.id, :food => food,
                   :count => count, :time => time)
  end
end

for name in ARGV
  User.transaction do
    File.open(name) { |fd| Reader.new.scan(fd) }
  end
end
