module Player
  extend ActiveSupport::Concern

  # def average_position_age_diff
  #   age - @@average_ages[position]
  # end

  # def id=(new_id)
  #   cbs_id = new_id
  # end
  #
  # def firstname=(new_first)
  #   first_name = new_first
  # end
  #
  # def lastname=(new_last)
  #   last_name = new_last
  # end

  module ClassMethods
    #don't do this with a callback, because we don't wan't to call this after
    #each player insert; we only want to call it after all players are added
    def after_added
      update_average_ages
      set_name_brief
    end

    # def update_average_ages
    #   @@average_ages.clear
    #   self.select("position, AVG(age) as v").group("position").each do |record|
    #     @@average_ages[record.position] = record.v
    #   end
    # end

    def set_name_brief
      command = "UPDATE #{table_name} "
      command += "SET name_brief = #{brief_command} "
      ActiveRecord::Base.connection.execute(command)
    end

  end

end
