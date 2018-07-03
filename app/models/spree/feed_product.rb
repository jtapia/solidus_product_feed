module Spree
  class FeedProduct
    attr_reader :product

    def initialize(product)
      @product = product
    end

    def id
      product.id
    end

    def title
      product.name
    end

    def description
      product.description
    end

    # Must be selected from https://support.google.com/merchants/answer/1705911
    def category
    end

    def brand
      product.respond_to?(:brand) && product.brand.to_s
    end

    # Must be "new", "refurbished", or "used".
    def condition
      "new"
    end

    def price
      Spree::Money.new(product.price)
    end

    # Describe the product's availability
    # Values taken from Facebook's feed docs
    # still to do: respect available_on dates on products
    def availability
      @availability ||= case
                        when product.stock_items.any?(&:in_stock?)
                          'in stock'
                        when product.stock_items.any?(&:available?)
                          'available to order'
                        else
                          'out of stock'
                        end
    end

    def image_link
      return unless product.images.any?
      product.images.first.attachment.url(:large)
    end
  end
end
