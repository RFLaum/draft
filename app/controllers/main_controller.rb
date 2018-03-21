require 'net/http'
require 'json'

class MainController < ApplicationController
  #imports data to database
  def setup
    types = [Baseball, Football, Basketball]
    types.each do |type|
      url = "http://api.cbssports.com/fantasy/players/list?version=3.0&SPORT=#{type.to_s.downcase}&response_format=JSON"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      # response = HTTParty.get(url)
      # create_players(type, response.body["body"]["players"])
      # create_players(type, HTTParty::Parser.call(response.body, :json).body.players)
      # create_players(type, JSON.parse(response)[:body][:players])
      create_players(type, JSON.parse(response)["body"]["players"])
    end
  end

  #gets data for single player; parameters are sport (name of sport) and id
  #(the id given by cbs for that player)
  def single_player
    # answer = {}
    klass = params[:sport].titleize.constantize
    record = klass.find_by_cbs_id(params[:id].to_i)
    # answer[:id] = record.cbs_id
    # %i[name_brief first_name last_name position age average_position_age_diff].each do |field|
    #   answer[field] = record[field]
    # end
    render json: convert_to_json(record)
  end

  #gets list of all players of a given sport. Parameter is sport (name of that sport)
  def players_of_sport
    klass = params[:sport].titleize.constantize
    render json: klass.all.map { |record| convert_to_json(record) }
  end

  private

  def convert_to_json(record)
    answer = {}
    answer[:id] = record.cbs_id
    %i[name_brief first_name last_name position age average_position_age_diff].each do |field|
      answer[field] = record[field]
    end
    answer
  end

  def create_players(klass, data)
    klass.delete_all
    ActiveRecord::Base.transaction do
      data.each do |player|
        klass.create(
          cbs_id: player["id"],
          first_name: player["firstname"],
          last_name: player["lastname"],
          position: player["position"],
          age: player["age"].to_i
        )
      end
    end
    klass.after_added
  end
end
