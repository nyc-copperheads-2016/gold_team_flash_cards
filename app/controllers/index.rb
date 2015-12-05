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
    redirect '/decks'
  end

  erb :guess_form
end


post '/guesses' do
  current_card=Card.find_by(id:params[:card_id])
  if params[:guess]==current_card.answer
    correct=true
  else
    correct=false
  end
  current_card.guesses.create(guess: params[:guess],round_id: params[:round_id],correct:correct)


  guesses_for_card=Guess.where(card_id: current_card.id)

  if current_card.guesses.last.correct == true
    redirect "rounds/#{params[:round_id]}"
  elsif current_card.guesses.where(round_id:params[:round_id]).pluck(:correct).length >2
    redirect "rounds/#{params[:round_id]}"
  else
    @round_id= params[:round_id]
    @current_card=current_card
    erb :guess_form
  end


end






