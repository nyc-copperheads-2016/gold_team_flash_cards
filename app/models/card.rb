class Card < ActiveRecord::Base
  has_many :guesses
  belongs_to :deck

  def repeat_guess?(round_id)
    self.guesses.last.correct || self.guesses.where(round_id:round_id).pluck(:correct).length > 2
  end
end
