Rails.application.routes.draw do
  root 'main#setup'
  # get 'import_baseball' => 'interfaces#create_baseball_players'
  get 'single_player' => 'main#single_player'
  get 'players_of_sport' => 'main#players_of_sport'
end
