class Baseball < ApplicationRecord
  include Player
# class Baseball < Player
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

  # def name_brief
  #   "#{first_name[0].upcase}. #{last_name[0].upcase}."
  # end

  def self.brief_command
    'upper(substr(first_name, 1, 1)) || ". "' +
      ' || upper(substr(last_name, 1, 1)) || ". " '
  end
end
