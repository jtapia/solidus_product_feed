Spree::ProductsController.prepend(Module.new do
  class << self
    def prepended(klass)
      klass.respond_to :rss, :xml, only: :index
    end
  end

  def index
    load_feed_products if request.format.rss? || request.format.xml?
    super
  end

  private

  def load_feed_products
    @feed_products = Spree::Product.all.map(&Spree::FeedProduct.method(:new))
  end
end)
