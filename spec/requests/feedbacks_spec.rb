require 'rails_helper'

RSpec.describe "Feedbacks", type: :request do
  describe "POST /create" do
    let(:post) {create(:post)}
    let(:feedback_params) {attributes_for(:feedback, post_id: post.id)}
    context " when params are ok" do
      it "http status should be created" do
        post "/api/feedbacks/create", params: {feedback: feedback_params}
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      feedback_params = nil
      it "http status should be bad request" do
        post "/api/feedbacks/create", params: {feedback: feedback_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    describe "PATCH /update/:id" do
      let(:post) {create(:post)}
      let(:feedback) {create(:feedback, post_id: post.id)}
      let(:feedback_params) {attributes_for(:feedback, post_id: post.id)}
      context " when params are ok" do
        it "http status should be ok" do
          patch "/api/feedbacks/update/#{feedback.id}", params: {feedback: feedback_params}
          expect(response).to have_http_status(:ok)
        end
      end

      context " when new like is nil" do
        let(:feedback_params) {attributes_for(:feedback, like: nil)}
        it "http status should be bad_request" do
          patch "/api/feedbacks/update/#{feedback.id}", params: {feedback: feedback_params}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when not found" do
        it " http status should be not_found" do
          patch "/api/feedbacks/update/-1", params: {feedback: feedback_params}
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE /delete/:id" do
    let(:post) {create(:post)}
    let(:feedback) {create(:feedback, post_id: post.id)}
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/feedbacks/delete/#{feedback.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing feedback should return http status not_found" do
        delete "/api/feedbacks/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    let(:post) {create(:post)}
    FEEDBACKS_NUMBER = 20
    before do
      for i in 1..FEEDBACKS_NUMBER
        create(:feedback, post_id: post.id)
      end
    end

    context "not paginated" do
      before do
        get '/api/feedbacks'
      end

      it "should return all feedbacks in body" do
        expect(JSON.parse(response.body).size).to eq(FEEDBACKS_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    let(:post) {create(:post)}
    let(:feedback) {create(:feedback, post_id: post.id)}
    context "when params are ok" do
      it "http status should be ok" do
        get "/api/feedbacks/#{feedback.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing feedback should return http status not_found" do
        delete "/api/feedbacks/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end