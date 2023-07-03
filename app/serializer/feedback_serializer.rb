class FeedbackSerializer < Panko::Serializer
    attributes :like, :post, :user

    def like
        return 'Like' if object.like
        return 'Deslike'
    end


    def user
        return UserSerializer.new.serialize_to_json(object.user)
    end

    def post
        return PostSerializer.new.serialize_to_json(object.post)
    end

end

