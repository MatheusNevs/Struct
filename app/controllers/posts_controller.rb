class PostsController < ApplicationController
    # def index
    #     render json: Post.all, status: :ok
    # end
    
    # def show
    #     render json: Post.find(params[:id]), status: :ok
    # rescue ActiveRecord::RecordNotFound => e
    #     render json: { error: e.message }, status: :not_found
    # end
    
    # def create
    #     render json: Post.create!(post_params), status: :ok
    # rescue StandardError => e
    #     render json: { error: e.message }, status: :bad_request
    # end
    
    # def update
    #     render json: Post.update!(params[:id], post_params), status: :ok
    # rescue ActiveRecord::RecordNotFound => e
    #     render json: { error: e.message }, status: :not_found
    # rescue StandardError => e
    #     render json: { error: e.message }, status: :unprocessable_entity
    # end
    
    # def delete
    #     render json: Post.destroy!(params[:id]), status: :ok
    # rescue ActiveRecord::RecordNotFound => e
    #     render json: { error: e.message }, status: :not_found
    # rescue StandardError => e
    #     render json: { error: e.message }, status: :bad_request
    # end
    
    # private
    
    # def post_params
    #     params.require(:post).permit(:title, :content, :id
            
    #     )
    # end
end