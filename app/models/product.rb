class Product < ApplicationRecord
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :title, uniqueness: true, length: { minimum: 10 }
  validates :image_url, allow_blank: true, format: {
    with: %r{\.(gif|jpg|png)\z}i,
    message: 'must be a URL for GIF, JPG or PNG image.'
  }

  has_many :line_items
  before_destroy :ensure_not_referenced_by_any_line_item

  private

  # hook method -> called before rails attempts to destroy a row in the db
  # ensure there are no line items referencing this product
  def ensure_not_referenced_by_any_line_item
    unless line_items.empty?
      errors.add(:base, 'Line Items present')
      
      # if :abort is thrown, the db row is not destroyed
      throw :abort
    end
  end
end
