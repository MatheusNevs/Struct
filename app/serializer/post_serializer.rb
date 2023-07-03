class PostSerializer < Panko::Serializer
    attributes :title, :content, :user

    def user
        return UserSerializer.new.serialize_to_json(object.user)
    end
end
