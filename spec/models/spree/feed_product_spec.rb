require "spec_helper"

RSpec.describe Spree::FeedProduct do
  let(:feed_product) { described_class.new(product) }
  let(:product) do
    create :product,
      name: "2 Hams 20 Dollars",
      description: "As seen on TV!"
  end

  describe "#id" do
    subject { feed_product.id }

    it "delegates to the product's SKU" do
      expect(subject).to eq product.id
    end
  end

  describe "#category" do
    subject { feed_product.category }
    it { is_expected.to be_nil }
  end

  describe "#condition" do
    subject { feed_product.condition }
    it { is_expected.to eq "new" }
  end

  describe "#price" do
    subject { feed_product.price }
    it { is_expected.to eq Spree::Money.new(19.99, currency: 'USD') }
  end

  describe "#image_link" do
    subject { feed_product.image_link }
    context "when the product has images" do
      before { Spree::Image.create! viewable: product.master, attachment_file_name: 'hams.png' }
      it { is_expected.to eq '/spree/products/1/original/hams.png' }
    end

    context "when the product doesn't have images" do
      it { is_expected.to be_nil }
    end
  end

  describe "#description" do
    subject { feed_product.description }
    it { is_expected.to eq "As seen on TV!" }
  end

  describe "#title" do
    subject { feed_product.title }
    it { is_expected.to eq "2 Hams 20 Dollars" }
  end

  describe "#availability" do
    subject { feed_product.availability }
    context "when product has in stock variants" do
      before do
        product.master.stock_items.first.set_count_on_hand(1)
      end

      it { is_expected.to eq 'in stock' }
    end

    context "when product is out of stock but backorderable" do
      before do
        product.master.stock_items.each { |si| si.set_count_on_hand(0) }
      end

      it { is_expected.to eq 'available to order' }
    end

    context "when product is out of stock and not backorderable" do
      before do
        product.master.stock_items.each { |si|
          si.set_count_on_hand(0)
        }
        product.master.stock_items.each { |si|
          si.update_attributes(backorderable: false)
        }
      end

      it { is_expected.to eq 'out of stock' }
    end
  end
end
