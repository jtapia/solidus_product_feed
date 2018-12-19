module Spree
  class ProductFeed < Spree::Base
    belongs_to :store
    belongs_to :product_catalog

    validates :name, :feed_type, presence: true

    def self.default
      where(store: Spree::Store.default).first
    end
  end
end
