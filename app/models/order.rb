class Order < ActiveRecord::Base
  has_many :line_items
  has_many :products, through: :line_items
  belongs_to :site, class_name: "Refinery::SItes::Site", foreign_key: :site_id

  attr_accessible :name, :phone, :address, :delivered
  validates :name, :phone, :address, presence: true
  validate :has_items


  def title
    "#{name} ($#{total})"
  end

  private
  def has_items
    errors.add(:base, I18n.t('empty_cart_checkout')) if line_items.blank?
  end
end
