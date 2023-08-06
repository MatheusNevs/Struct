class UserSerializer < Panko::Serializer
    attributes :name, :email, :admin, :authentication_token, :profile_pictures_url

    def admin
        return 'O usuário é um adiministrador' if object.is_admin 
        return 'O usuário não é um administrador'
    end

    def name
        if object.name == nil
            return 'O usuário ainda não possui um nome'
        end
        return object.name
    end

    def profile_pictures_url
        array = []
        if object.profile_pictures.attached?
            object.profile_pictures.each do |profile_picture|
                array.append Rails.application.routes.url_helpers.rails_blob_path(profile_picture, only_path: true)
            end
        end
        array
    end

end
