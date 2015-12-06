get '/decks' do
  @deck=Deck.all
  erb :'/decks/select_deck'
end
