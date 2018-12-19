FactoryBot.define do
  factory :product_feed, class: Spree::ProductFeed do
    name 'A100'
    feed_type 'google_feed'
    product_catalog
    store
  end

  factory :product_catalog, class: Spree::ProductCatalog do
    name 'A100'
    item_ids []
    store
  end
end
