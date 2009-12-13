# Load foods.

foods = File.open('../foods.yaml') { |yf| YAML::load yf }
Food.transaction do
  for category, fs in foods
    for name, cals in fs
      food = Food.find_or_create_by_category_and_name(category, name)
      food.calories = cals
      food.save
    end
  end
end
