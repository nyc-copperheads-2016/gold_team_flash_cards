class Round < ActiveRecord::Base
  belongs_to :user
  belongs_to :deck
  has_many :guesses

  def round_date
    "#{self.created_at.month}/#{self.created_at.day}/#{self.created_at.year}"
  end

  def questions_correct
    self.guesses.pluck(:correct).count(true)
  end

  def questions_incorrect
    Deck.find_by(id: self.deck_id).cards.length - self.questions_correct
  end

  def cards_in_this_round_deck
    Card.where(deck_id: self.deck_id)
  end

  def cards_played_in_this_round
    cards_already_played = []
    self.cards_in_this_round_deck.each do |card|
      if card.guesses.where(round_id: self.id).length > 0
        cards_already_played << card
      end
    end
    cards_already_played
  end
end
