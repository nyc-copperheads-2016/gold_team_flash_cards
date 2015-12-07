# this is the index route
get '/decks' do
  @deck=Deck.all
  erb :'/decks/select_deck' # Call the file for this action: index
end
