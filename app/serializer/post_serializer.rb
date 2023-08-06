class PostSerializer < Panko::Serializer
    attributes :title, :content, :user, :post_image_url

    def user
        return UserSerializer.new.serialize_to_json(object.user)
    end

    def post_image_url
        if object.post_image.attached?
            return Rails.application.routes.url_helpers.rails_blob_path(object.post_image, only_path: true)
        end
    end
end
