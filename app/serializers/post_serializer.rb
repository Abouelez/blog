class PostSerializer < ActiveModel::Serializer
  attributes :id, :title, :body, :tags
  belongs_to :user
  has_many :comments

  def tags
    object.tags.split(",")
  end
end
