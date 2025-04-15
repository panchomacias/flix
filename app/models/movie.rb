class Movie < ApplicationRecord
  has_rich_text :description

  def self.released
    where("released_on < ?", Time.now).order(released_on: :desc)
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_00
  end
end
