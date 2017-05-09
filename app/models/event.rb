class EventValidator < ActiveModel::Validator
  def validate(record)
    unless record.date >= Date.tomorrow
      record.errors[:date] << 'Event date need to be in the future.'
    end
    unless record.from < record.to
      record.errors[:from] << 'Event start time need to be less than end time.'
      record.errors[:to] << 'Event start time need to be less than end time.'
    end
  end
end

class Event < ApplicationRecord
  belongs_to  :user
  has_many    :books,     :dependent    => :delete_all

  validates   :name,      :presence     => true

  validates   :via,       :presence     => true

  validates   :venue,     :presence     => true

  validates   :desc,      :presence     => true

  validates   :contact,   :presence     => true

  validates   :capacity,  numericality: { greater_than_or_equal_to: 0, allow_nil: false }

  validates   :price,     numericality: { greater_than_or_equal_to: 0, allow_nil: false }

  validates_with EventValidator

  def show_price
    if price == 0
      'Free'
    else
      price.to_s + '$'
    end
  end

  def get_book(user)
    if user
      books.find_by user_id: user.id
    else
      nil
    end
  end

  def book_status
    if capacity > 0
      " (" + books.count.to_s + "/" + capacity.to_s + ")";
    else
      ""
    end
  end

end
