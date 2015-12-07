decks = Deck.create([{name: 'Famous People'},{name:'Movies'},{name:'Super Mario'}])

Card.create(question: "Who starred in Jerry McGuire?", answer: "tom cruise", deck: deck)
# Build off of your associated objects.  There is no guarantee that your ids are starting from 1 or that they are incrementing by 1.
deck[0].cards.create(question: "Who is Luke's father in StarWars?", answer: "darth vader")
Card.create(question: "Who owns Microsoft?", answer: "bill gates", deck_id: 1)
Card.create(question: "Which famous laker is known as the Black Mamba?", answer: "kobe bryant", deck_id: 1)

Card.create(question: "What happens when you collect 100 coins?", answer: "extra life", deck_id: 3)
Card.create(question: "What's Princess Peach's last name?", answer: "toadstool", deck_id: 3)
Card.create(question: "Who is Mario's brother?", answer: "luigi", deck_id: 3)
Card.create(question: "In Paper Mario 64, what gives Bowser his power?", answer: "star rod", deck_id: 3)
Card.create(question: "In Luigi's mansion, what is Mario trapped in?", answer: "picture", deck_id: 3)

