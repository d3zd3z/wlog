class WlogController < ApplicationController

  def index
    find_user
    @weeks = Week.find_all_by_user_id(@show_user.id, :order => 'start DESC')
  end

  # Show the weekly summary sheet.
  def weekly
    @weight = 164.3

    @categories = ['S', 'C', 'E', 'B', 'F', 'V', 'PA', 'Total Cals', 'Net Cals',
      'Daily Weight', 'Total Weight']
    @week = Week.find(params[:id])
    @days = []
    @totals = {}
    @formats = {}
    @categories.each do |c|
      @totals[c] = 0.0
      @formats[c] = "%.0f"
    end
    @formats['Daily Weight'] = "%.2f"
    @formats['Total Weight'] = "%.2f"
    @start = @week.days.first.day.strftime('%a %b %d')
    @ending = @week.days.last.day.strftime('%b %d, %Y')
    for day in @week.days
      info = {}
      @days << info
      info[:day] = day.day
      @categories.each { |c| info[c] = 0.0 }
      calories = 0.0
      net_calories = 0.0
      for le in day.line_eats
        category = le.food.category
        info[category] += le.count
        @totals[category] += le.count
        calories += le.food.calories * le.count
        net_calories += le.food.calories * le.count
      end
      for pa in day.line_pas
        net_calories -= pa.calories
      end
      info['Total Cals'] = calories
      info['Net Cals'] = net_calories
      @totals['Total Cals'] += calories
      @totals['Net Cals'] += net_calories

      info['Daily Weight'] = (net_calories - (13.0 * @weight)) / (500.0)
      info['Total Weight'] = (@totals['Net Cals'] - (13.0 * @weight * @days.count)) /
        (500.0 * @days.count)
    end
    @totals['Daily Weight'] = @days.last['Total Weight']
    @totals['Total Weight'] = @days.last['Total Weight']
  end

  # Show the daily journal.
  def journal
    @week = Week.find(params[:id])
  end

  def login
    if request.post?
      user = User.authenticate(params[:name], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to :action => 'index'
      else
        flash.now[:notice] = "Invalid user/password combination"
      end
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to :action => 'index'
  end

  private
  def find_user
    if session[:user_id]
      @user = User.find(session[:user_id])
      @show_user = @user
    else
      @show_user = User.find_by_login('davidb')
    end
  end

end
