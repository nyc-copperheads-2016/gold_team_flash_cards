get '/decks' do
  @deck=Deck.all
  erb :select_deck
end
