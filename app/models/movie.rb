class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

  RATINGS = [ "G", "PG", "PG-13", "R", "NC-17" ]

  has_rich_text :description

  validates :title, :released_on, :duration, presence: true

  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }

  validate :description_length

  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "must be a JPG or PNG image"
  }

  validates :rating, inclusion: { in: RATINGS }

  def self.released
    where("released_on < ?", Time.now).order(released_on: :desc)
  end

  def flop?
    total_gross.blank? || total_gross < 225_000_00
  end

  def description_length
    return unless description.present?
    text_content = description.to_plain_text.strip
    if text_content.length < 25
      errors.add(:description, "is too short (minimum is 25 characters)")
    end
  end
end
