module Spree
  module Admin
    class ProductFeedsController < ResourceController
      before_action :load_data, only: [:index, :edit, :new]

      def index
        if @product_feeds.count == 1
          redirect_to edit_admin_product_feed_path(@product_feeds.first)
        else
          redirect_to new_admin_product_feed_path
        end
      end

      def new
        @product_feed = Spree::ProductFeed.new
      end

      private

      def load_data
        @product_feeds = Spree::ProductFeed.where(store: current_store)
        @product_catalogs = Spree::ProductCatalog.where(store: current_store).order(:name)
      end

      def location_after_save
        edit_admin_product_feed_path(@object)
      end

      def model_class
        Spree::ProductFeed
      end
    end
  end
end
