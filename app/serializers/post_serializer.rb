class PostSerializer < ActiveModel::Serializer
  attributes :id, :caption, :picture, :location, :release_date
end