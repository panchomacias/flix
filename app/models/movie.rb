class Movie < ApplicationRecord
  def flop?
    total_gross.blank? || total_gross < 225_000_00
  end
end
