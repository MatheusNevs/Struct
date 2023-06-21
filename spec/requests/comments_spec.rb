require 'rails_helper'

RSpec.describe "Comments", type: :request do
  describe "POST /create" do
    let(:post) {create(:post)}
    let(:comment_params) {attributes_for(:comment, post_id: post.id)}
    context " when params are ok" do
      it "http status should be created" do
        post "/api/comments/create", params: {comment: comment_params}
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      comment_params = nil
      it "http status should be bad request" do
        post "/api/comments/create", params: {comment: comment_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    describe "PATCH /update/:id" do
      let(:post) {create(:post)}
      let(:comment) {create(:comment, post_id: post.id)}
      let(:comment_params) {attributes_for(:comment, post_id: post.id)}
      context " when params are ok" do
        it "http status should be ok" do
          patch "/api/comments/update/#{comment.id}", params: {comment: comment_params}
          expect(response).to have_http_status(:ok)
        end
      end

      context " when new content is nil" do
        let(:comment_params) {attributes_for(:comment, content: nil)}
        it "http status should be bad_request" do
          patch "/api/comments/update/#{comment.id}", params: {comment: comment_params}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when not found" do
        it " http status should be not_found" do
          patch "/api/comments/update/-1", params: {comment: comment_params}
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE /delete/:id" do
    let(:post) {create(:post)}
    let(:comment) {create(:comment, post_id: post.id)}
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/comments/delete/#{comment.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing comment should return http status not_found" do
        delete "/api/comments/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    let(:post) {create(:post)}
    COMMENTS_NUMBER = 20
    before do
      for i in 1..COMMENTS_NUMBER
        create(:comment, post_id: post.id)
      end
    end

    context "not paginated" do
      before do
        get '/api/comments'
      end

      it "should return all comments in body" do
        expect(JSON.parse(response.body).size).to eq(COMMENTS_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    let(:post) {create(:post)}
    let(:comment) {create(:comment, post_id: post.id)}
    context "when params are ok" do
      it "http status should be ok" do
        get "/api/comments/#{comment.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing comment should return http status not_found" do
        delete "/api/comments/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end