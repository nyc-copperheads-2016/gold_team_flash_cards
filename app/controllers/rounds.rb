post '/rounds' do
  deck= Deck.find_by(name: params[:deck])
  # You have the current_user helper already: use it.
  # user = User.find_by(id: session[:user_id])
  @round = deck.rounds.create(user: current_user)
  # You can never assume that the object you just made is the last one that was made
  # Always assign to a variable and use that variable
  # @round = Round.last
  redirect "/rounds/#{@round.id}"
end


get '/rounds/:id' do
  @round = Round.find_by(id:params[:id])
  @current_card = @round.next_card

  if @current_card.nil?
    redirect "rounds/#{@round.id}/game_over"
  end
  erb :'/guesses/guess_form'
end


get '/rounds/:id/game_over' do
  @round = Round.find_by(id:params[:id])
  erb :'/rounds/game_over'
end
