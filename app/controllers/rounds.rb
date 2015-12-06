post '/rounds' do
  deck= Deck.find_by(name: params[:deck])


  user = User.find_by(id: session[:user_id])
  deck.rounds.create(user_id: user)
  @round_id=Round.last.id

  redirect "/rounds/#{@round_id}"
end


get '/rounds/:id' do
  deck_id=Round.find_by(id:params[:id]).deck_id
  #This is where the error is!!! in Card.params, add card id to uesses_from_this_round
  cards_in_this_deck = Card.where(deck_id:deck_id)
  # cards_already_played = Guess.where(round_id: params[:id],)
  cards_already_played = []
  cards_in_this_deck.each do |card|
    if card.guesses.where(round_id:params[:id]).length > 0
      cards_already_played << card
    end
  end



  cards_in_this_deck-=cards_already_played

  @round_id=params[:id]
  @current_card=cards_in_this_deck.sample
  if @current_card.nil?
    redirect "rounds/#{@round_id}/game_over"
  end

  erb :guess_form
end


get '/rounds/:id/game_over' do
  @round_id=params[:id]
  erb :game_over
end
