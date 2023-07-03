class CommentSerializer < Panko::Serializer
    attributes :content, :post, :user
    
    def post
        return PostSerializer.new.serialize_to_json(object.post)
    end

    def user
        return UserSerializer.new.serialize_to_json(object.user)
    end
end

