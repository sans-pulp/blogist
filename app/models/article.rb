class Article < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true, length: { minimum: 50 }
  validates :slug, uniqueness: true
  # Override articlepath url --> pass slugh in url rather than id...
  def to_param
    slug
  end
end
