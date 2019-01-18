require 'spec_helper'

module Spree
  describe Spree::Admin::ProductFeedImagesController do
    stub_authorization!

    let!(:product) { create(:product) }
    let!(:product_feed) { create(:product_feed) }
    let!(:product_image) do
      product.master.images.create!(attachment: image('thinking-cat.jpg'))
    end

    context '#create' do
      it 'creates an image' do
        post :create, params: {
          product_feed_id: product_feed.id,
          product_feed_image: {
            image: {
              attachment: upload_image('thinking-cat.jpg')
            }
          }
        }

        expect(response.status).to eq(302)
        expect(response).to be_redirect
      end

      it 'creates an image as json' do
        post :create, params: {
          product_feed_id: product_feed.id,
          product_feed_image: {
            image: {
              attachment: upload_image('thinking-cat.jpg')
            }
          }
        }, format: :json

        expect(response.status).to eq(200)
        expect(json_response[0]['name']).to eq('thinking-cat.jpg')
      end
    end

    context '#destroy' do
      it 'destroys an image' do
        delete :destroy, params: {
          product_feed_id: product_feed.id,
          id: product_image.id
        }

        expect(response.status).to eq(302)
        expect(response).to be_redirect
      end

      it 'destroys an image as json' do
        delete :destroy, params: {
          product_feed_id: product_feed.id,
          id: product_image.id
        }, format: :json

        expect(response.status).to eq(200)
      end
    end
  end
end
