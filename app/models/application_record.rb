class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  ALLOWED_CONTENT_TYPES = %q{
    image/jpeg
    image/png
    image/gif
    image/bmp
  }
end
