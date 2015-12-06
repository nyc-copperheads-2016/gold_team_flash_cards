class Card < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck

  def repeat_guess?(round_id)
    self.guesses.last.correct || self.guesses.where(round_id:round_id).pluck(:correct).length > 2
  end

  def last_guess_wrong?(round_id)
    self.guesses.where(round_id: round_id).last.correct==false
  end

  def current_card_has_guesses_from_this_round?(round_id)
    self.guesses.where(round_id: round_id).length > 0
  end
end
