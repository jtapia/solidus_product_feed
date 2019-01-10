# frozen_string_literal: true

json.call(image, *image_attributes)
json.call(image, :viewable_type, :viewable_id)
SolidusProductFeed::Config.formats.each do |k, _v|
  json.set! "#{k}_url", image.attachment.url(k)
end
