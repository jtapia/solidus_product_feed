module Spree
  class ProductCatalog < Spree::Base
    serialize :item_ids, Array

    belongs_to :store
    has_many :images, -> { order(:position) }, as: :viewable, dependent: :destroy, class_name: 'Spree::Image'

    after_create :populate_default_items

    validates :name, presence: true, uniqueness: true

    scope :by_store, ->(store){ where(store: store) }

    def selected?(variant_id)
      item_ids.include?(variant_id.to_s)
    end

    def all_selected?(variants)
      variant_ids = variants.map(&:id).map(&:to_s)
      (variant_ids - item_ids).blank?
    end

    private

    def populate_default_items
      variants = Spree::Product.all.map(&:variants_including_master).flatten
      update_attribute(:item_ids, variants.map(&:id).map(&:to_s))
    end
  end
end
