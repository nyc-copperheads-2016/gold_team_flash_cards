post '/guesses' do
  current_card = Card.find_by(id:params[:card_id])
  # I think that this logic would be better encapsulated in the Card model...
  current_card.guesses.create(
    guess:    params[:guess].downcase,
    round_id: params[:round_id],
    correct:  current_card.is_correct?(params[:guess])
  )

  if current_card.repeat_guess?(params[:round_id])
    redirect "rounds/#{params[:round_id]}"
  else
    @round= Round.find_by(id:params[:round_id])
    @current_card=current_card
    erb :'/guesses/guess_form'
  end
end
