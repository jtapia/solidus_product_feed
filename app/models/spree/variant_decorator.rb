Spree::Variant.class_eval do
  def product_feed_image
    images.where(viewable_type: 'Spree::ProductCatalog').first
  end

  def display_option_text
    options_text.present? && options_text || 'Master Variant'
  end
end
