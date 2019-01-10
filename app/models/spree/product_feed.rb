module Spree
  class ProductFeed < ActiveRecord::Base
    belongs_to :store
    belongs_to :product_catalog

    validates :name, presence: true, uniqueness: true

    def self.default
      where("store = ? AND product_catalog_id != null", Spree::Store.default).first
    end
  end
end
