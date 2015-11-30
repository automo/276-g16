require "paperclip"
Paperclip::Attachment.default_options[:url] = 'shoppuapp-image-assets.s3.amazonaws.com'
Paperclip::Attachment.default_options[:path] = ':attachment/:id/:style.:extension'
