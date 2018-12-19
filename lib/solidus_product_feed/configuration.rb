module SolidusProductFeed
  class Configuration < Spree::Preferences::Configuration
    preference :types, :string, default: [['Google Feed', 'google_feed'],
                                          ['Google Merchant Center', 'google_merchant_center'],
                                          ['Facebook Feed', 'facebook_feed']]
  end
end
