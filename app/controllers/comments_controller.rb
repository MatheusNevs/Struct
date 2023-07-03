class CommentsController < ApplicationController
    acts_as_token_authentication_handler_for User
    
    def index
        render json: array_serializer(Comment.all), status: :ok
    end
    
    def show
        render json: serializer(Comment.find(params[:id])), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end
    
    def create
        comment = Comment.new(comment_params)
        comments.save!
        render json: serializer(comment), status: :created
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def update
        comment = Comment.update(params[:id], comment_params)
        comment.save!
        render json: serializer(comment), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def delete
        comment = Comment.find(params[:id])
        comment.destroy!
        render json: serializer(comment), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
    
    private
    
    def comment_params
        params.require(:comment).permit(:post_id, :content)
    end

    def array_serializer(comments)
        Panko::ArraySerializer.new(comments, each_serializer: CommentSerializer).to_json
    end

    def serializer(comment)
        CommentSerializer.new.serialize_to_json(comment)
    end
end
