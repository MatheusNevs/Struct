require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /create" do
    let(:post_params) do
      attributes_for(:post)
    end
    context " when params are ok" do
      it "http status should be created" do
        post "/api/posts/create", params: {post: post_params}
        expect(response).to have_http_status(:ok)
      end
    end

    context " when params aren't ok" do
      post_params = nil
      it "http status should be bad request" do
        post "/api/posts/create", params: {post: post_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context " when given params already exists" do
      it "http status should be bad request" do
        post "/api/posts/create", params: {post: post_params}
        post "/api/posts/create", params: {post: post_params}  
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end