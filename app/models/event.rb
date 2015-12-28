class Event < ActiveRecord::Base
  TICKET_TYPES_COUNT_MIN = 1
  belongs_to :user
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types
  
  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.search(search)
    where("name LIKE ?", "%#{search}%")
  end
  
  validate do
    check_ticket_types_number
  end
  private
  def ticket_types_count_valid?
    ticket_types.count >= TICKET_TYPES_COUNT_MIN
  end
  
  def check_ticket_types_number
    unless ticket_types_count_valid?
      errors.add(:base, :ticket_types_too_short, :count => TICKET_TYPES_COUNT_MIN)
    end
  end
end