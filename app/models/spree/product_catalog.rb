module Spree
  class ProductCatalog < Spree::Base
    serialize :item_ids, Array

    belongs_to :store

    validates :name, presence: true, uniqueness: true

    def selected?(variant_id)
      item_ids.include?(variant_id.to_s)
    end

    def all_selected?(variants)
      variant_ids = variants.map(&:id).map(&:to_s)
      (variant_ids - item_ids).blank?
    end
  end
end
