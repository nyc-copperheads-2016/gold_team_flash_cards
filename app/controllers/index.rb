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
  if Card.params[:id].guesses.all.count >0
    already_guessed=Card.params[:id].guesses.all.count
  end

  cards_held=Card.params[:id].guesses.all

  if already_guessed.is_defined?
    cards_held.delete_if{|card| already_guessed.include?(card)}
  end

  @round_id=params[:id]

  @current_card=cards_held.sample

  erb :guess_form
end




