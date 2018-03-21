# class InterfacesController < ApplicationController
#   def create_baseball_players
#     create_players(Baseball, params[:data][:body][:players])
#   end
#
#   private
#
#   def create_players(klass, data)
#     klass.delete_all
#     ActiveRecord::Base.transaction do
#       data.each do |player|
#         klass.create(
#           cbs_id: player.id,
#           first_name: player.firstname,
#           last_name: player.lastname,
#           position: player.position,
#           age: player.age.to_i
#         )
#       end
#     end
#     klass.after_added
#   end
# end
