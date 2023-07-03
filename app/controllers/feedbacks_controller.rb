class FeedbacksController < ApplicationController
    acts_as_token_authentication_handler_for User
    
    def index
        render json: array_serializer(Feedback.all), status: :ok
    end
    
    def show
        render json: serializer(Feedback.find(params[:id])), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    end
    
    def create
        feedback = Feedback.new(feedback_params)
        feedback.save!
        render json: serializer(feedback), status: :created
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def update
        render json: serializer(Feedback.update!(params[:id], feedback_params)), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :bad_request
    end
    
    def delete
        feedback = Feedback.find(params[:id])
        feedback.destroy!
        render json: serializer(feedback), status: :ok
    rescue ActiveRecord::RecordNotFound => e
        render json: { error: e.message }, status: :not_found
    rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
    end
    
    private
    
    def feedback_params
        params.require(:feedback).permit(:post_id, :like)
    end

    def array_serializer(feedbacks)
        Panko::ArraySerializer.new(feedbacks, each_serializer: FeedbackSerializer).to_json
    end

    def serializer(feedback)
        FeedbackSerializer.new.serialize_to_json(feedback)
    end
end
