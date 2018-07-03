module Spree
  module FeedProductsHelper

    def brand_name(feed_product, store)
      if feed_product.brand.present?
        feed_product.brand
      elsif store.name.present?
        store.name
      end
    end

  end
end
