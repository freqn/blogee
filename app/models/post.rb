class Post < ActiveRecord::Base
  has_many :comments
  belongs_to :user

  validates :title, :presence => true
  validates :content, :presence => true

  mount_uploader :asset, AssetUploader
  
end
