post '/rounds' do
  deck= Deck.find_by(name: params[:deck])
  user = User.find_by(id: session[:user_id])
  deck.rounds.create(user_id: user.id)
  @round=Round.last
  redirect "/rounds/#{@round.id}"
end


get '/rounds/:id' do
  @round=Round.find_by(id:params[:id])
  cards_in_this_deck = @round.cards_in_this_round_deck
  cards_already_played = @round.cards_played_in_this_round
  cards_in_this_deck-=cards_already_played
  @current_card=cards_in_this_deck.sample

  if @current_card.nil?
    redirect "rounds/#{@round.id}/game_over"
  end
  erb :'/guesses/guess_form'
end


get '/rounds/:id/game_over' do
  @round = Round.find_by(id:params[:id])
  erb :'/rounds/game_over'
end
