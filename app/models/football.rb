class Football < ApplicationRecord
  include Player

  @@average_ages = {}

  def average_position_age_diff
    age - @@average_ages[position]
  end

  def self.update_average_ages
    @@average_ages.clear
    self.select("position, AVG(age) as v").group("position").each do |record|
      @@average_ages[record.position] = record.v
    end
  end

  def self.brief_command
    'upper(substr(first_name, 1, 1)) || ". " || last_name'
  end
end
