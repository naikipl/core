module Shoppe
  class Image < ActiveRecord::Base
    self.table_name = 'shoppe_images'

    has_attached_file :file

    validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

    delegate :url, to: :file, prefix: false

    def file_name
      file_file_name
    end
  end
end