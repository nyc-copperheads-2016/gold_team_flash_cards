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
  #This is where the error is!!! in Card.params, add card id to uesses_from_this_round
  cards_in_this_deck = Deck.find_by(id: Round.find_by(id: params[:id]).deck_id).cards
  # cards_already_played = Guess.where(round_id: params[:id],)
  cards_already_played = []
   cards_in_this_deck.each do |card|
    if card.guesses.length > 0
      cards_already_played << card
    end
  end



  cards_in_this_deck.delete_if{|card| cards_already_played.include?(card)}


  @round_id=params[:id]
  @current_card=cards_held.sample

  erb :guess_form
end

post '/guesses' do
  current_card=params[:card]
  if params{:guess]==current_card.answer
    correct=true
  else
    correct=false
  end
  current_card.guesses.create(guess: params[:guess],round_id: params[:round_id],correct:correct)


  guesses_for_card


end




