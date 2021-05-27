class Book < ApplicationRecord
  has_one_attached :cover_image
  belongs_to :author

  def mla_author_name
    "#{author.last_name}, #{author.first_name}"
  end
end
