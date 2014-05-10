class Post < ActiveRecord::Base

  before_create :associate_tags


  has_many :comments
  belongs_to :user

  attr_accessor :tag_names

  validates :title, :presence => true
  validates :content, :presence => true

  has_and_belongs_to_many :tags

  mount_uploader :asset, AssetUploader

  private

  def associate_tags
    if tag_names
      tag_names.split(" ").each do |name|
        self.tags << Tag.find_or_create_by(name: name)
      end
    end
  end

end
