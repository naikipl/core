module Shoppe
  class Image < ActiveRecord::Base
    self.table_name = 'shoppe_images'

    has_attached_file :source, styles: Shoppe.settings.image_styles.symbolize_keys! || {}

    validates_attachment_content_type :source, content_type: /\Aimage\/.*\Z/

    delegate :url, to: :source, prefix: false
    alias_attribute :file_name, :source_file_name
    alias_attribute :file_size, :source_file_size

    before_save :extract_dimensions

    def self.reprocess!
      all.each do |image|
        image.source.reprocess!
      end
    end

    def extract_dimensions
      if tempfile = source.queued_for_write[:original]
        geometry = Paperclip::Geometry.from_file(tempfile)
        self.width = geometry.width.to_i
        self.height = geometry.height.to_i
      end
    end

    def portrait?
      height > width
    end
  end
end