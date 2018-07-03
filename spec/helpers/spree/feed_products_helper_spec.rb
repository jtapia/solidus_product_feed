require 'spec_helper'

describe Spree::FeedProductsHelper do
  let(:helper_class) {
    Class.new {
      include Spree::FeedProductsHelper
    }
  }
  let(:helper) { helper_class.new }
  describe '#brand_name' do
    let(:product) { create(:product) }
    let(:feed_product) { Spree::FeedProduct.new(product) }
    let!(:store) { create(:store) }

    context 'when product has a brand taxon' do
      let(:brand_taxonomy) { create(:taxonomy, name: 'Brand') }
      let(:brand_taxon) { create(:taxon, taxonomy: brand_taxonomy) }

      before do
        brand_taxon.products << product
        allow(product).to receive(:brand) { brand_taxon.name }
      end

      it 'uses the brand name' do
        expect(helper.brand_name(feed_product, store)).to eq(brand_taxon.name)
      end
    end

    context 'when product has no brand taxon' do
      it 'uses the store name' do
        expect(helper.brand_name(feed_product, store)).to eq(store.name)
      end
    end
  end
end
