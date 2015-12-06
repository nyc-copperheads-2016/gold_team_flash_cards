class Guess < ActiveRecord::Base
  belongs_to :card
  belongs_to :round

  def self.round_has_guesses?(round_id)
    self.where(round_id:round_id).length >0
  end

  def self.last_guess_was_correct?(round_id)
    self.where(round_id:round_id).last.correct==true
  end
end
