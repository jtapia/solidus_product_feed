module Spree
  module Admin
    class ProductCatalogsController < ResourceController
      before_action :load_data, except: [:index]
      before_action :load_variants, only: [:edit]

      include Spree::Admin::ProductCatalogsHelper

      private

      def collection
        params[:q] ||= {}
        params[:q][:s] ||= 'name asc'
        @search = super.ransack(params[:q])
        @product_catalogs = @search.result.
                            page(params[:page]).
                            per(params[:per_page])
      end

      def load_data
        @product_catalogs = Spree::ProductCatalog.where(store: current_store).order(:name)
      end

      def load_variants
        @variants ||= Spree::Variant.all
      end

      def location_after_save
        edit_admin_product_catalog_path(@object)
      end

      def permitted_resource_params
        params[:product_catalog][:item_ids] &&
          params[:product_catalog][:item_ids].delete_if(&:blank?)
        super
      end

      def model_class
        Spree::ProductCatalog
      end
    end
  end
end
