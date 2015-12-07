class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses
  has_many :cards, through: :deck

  def round_date
    # "#{self.created_at.month}/#{self.created_at.day}/#{self.created_at.year}"
    "#{created_at.month}/#{created_at.day}/#{created_at.year}"
  end

  def questions_correct
    # Self can be omitted when using getter methods
    # For setters, you still need self
    self.guesses.pluck(:correct).count(true)
  end

  def questions_incorrect
    # You should use the association methods to access the associated objects:
    #
    # deck.cards.length - questions_correct
    Deck.find_by(id: self.deck_id).cards.length - self.questions_correct
  end

  def cards_in_this_round_deck
    # If you have the association to cards on the Round class, you can remove this method
    Card.where(deck_id: self.deck_id)
  end

  def cards_played_in_this_round
    # cards_already_played = []
    # self.cards_in_this_round_deck.each do |card|
    #   if card.guesses.where(round_id: self.id).length > 0
    #     cards_already_played << card
    #   end
    # end
    # cards_already_played

    # Look for places to refactor where possible:
    cards.select { |card| card.guesses.where(round_id: id).length > 0 }
  end

  def next_card
    ( cards_in_this_round_deck - cards_played_in_this_round ).sample
  end

  def has_guesses?
    guesses.length > 0
  end

  def last_guess_correct?
    has_guesses && guesses.last.correct
  end
end
