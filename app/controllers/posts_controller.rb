class PostsController < ApplicationController
    acts_as_token_authentication_handler_for User
    before_action :is_admin_authentication, only: [:create, :update, :delete]


    def index
        render json: array_serializer(Post.all), status: :ok
    rescue StandardError => e
        render json: {error:e.message}, status: :bad_request
    end
    
    def show
        render json: serializer(Post.find(params[:id])), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end
    
    def create
        post = Post.new(post_params)
        post.save!
        render json: serializer(post), status: :created
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def update
        post = Post.find(params[:id])
        post.update!(post_params)
        render json: serializer(post), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def delete
        post = Post.find(params[:id])
        post.destroy!
        render json: serializer(post), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    private
    
    def post_params
        params.require(:post).permit(:title, :content, :id
            
        )
    end

    def array_serializer(posts)
        Panko::ArraySerializer.new(posts, each_serializer: PostSerializer).to_json
    end

    def serializer(post)
        PostSerializer.new.serialize_to_json(post)
    end

end