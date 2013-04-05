class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :product, class_name: "Refinery::Sites::Product", foreign_key: :product_id
end
