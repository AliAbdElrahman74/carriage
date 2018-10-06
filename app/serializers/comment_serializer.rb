class CommentSerializer < ActiveModel::Serializer
  attributes :id, :content, :replies

  def replies
    Comment.by_comment(object.id)
  end
end
