get '/' do
  redirect '/decks'
end

get '/decks' do
  @deck=Deck.all
  erb :select_deck
end

post '/rounds' do
  deck= Deck.find_by(name: params[:deck])
  # user = User.find_by(id: session[:user_id])
  deck.rounds.create(user_id: 1)
  @round_id=Round.last.id
  redirect "/rounds/#{@round_id}"
end

get '/rounds/:id' do
  #This is where the error is!!! in Card.params
  guesses_from_this_round = Guess.where(round_id: params[:id])
  cards_in_this_deck = Deck.find_by(id: Round.find_by(id: params[:id]).deck_id).cards

  if guesses_from_this_round.length > 0
    already_guessed = []
    guesses_from_this_round.each {|guess| already_guessed << Card.find_by(id: guess.card_id)}
  end

  cards_held=cards_in_this_deck

  if already_guessed
    cards_held.delete_if{|card| already_guessed.include?(card)}
  end

  @round_id=params[:id]
  @current_card=cards_held.sample

  erb :guess_form
end




