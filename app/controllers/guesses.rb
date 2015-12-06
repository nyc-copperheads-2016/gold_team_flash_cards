post '/guesses' do
  current_card=Card.find_by(id:params[:card_id])
  if params[:guess].downcase==current_card.answer
    correct=true
  else
    correct=false
  end
  current_card.guesses.create(guess: params[:guess].downcase,round_id: params[:round_id],correct:correct)

  if current_card.repeat_guess?(params[:round_id])
    redirect "rounds/#{params[:round_id]}"
  else
    @round= Round.find_by(id:params[:round_id])
    @current_card=current_card
    erb :'/guesses/guess_form'
  end
end
