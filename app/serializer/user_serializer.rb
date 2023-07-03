class UserSerializer < Panko::Serializer
    attributes :name, :email, :admin, :authentication_token

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
end
