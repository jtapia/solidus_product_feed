Spree::ProductsController.class_eval do
  before_action(only: :index) do |controller|
    if controller.request.format.rss?
      load_feed_products
    end
  end

  def index
    respond_to do |format|
      if product_feed
        format.rss { render inline: build_service }
      else
        format.rss { redirect_to action: 'index' }
      end

      format.html
    end
  end

  private

  def load_feed_products
    items = []
    product_catalog = product_feed.product_catalog

    Spree::Variant.where(id: product_catalog.item_ids).each do |variant|
      items << Spree::ProductFeedService.new(variant)
    end

    @feed_products = items
  end

  def build_service
    case product_feed.feed_type
    when 'google_feed'
      xml.generate
    when 'google_merchant_center'
      xml.generate
    when 'facebook_feed'
      csv.generate
    end
  end

  def product_feed
    @product_feed ||= Spree::ProductFeed.default
  end

  def csv
    @csv ||= Spree::Feeds::CSV.new(@feed_products, current_store)
  end

  def xml
    @xml ||= Spree::Feeds::XML.new(@feed_products, current_store)
  end
end
