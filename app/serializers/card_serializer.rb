class CardSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :first_three_comments

  def first_three_comments
    object.comments.where(parent_id: nil).limit(3)
  end
end
