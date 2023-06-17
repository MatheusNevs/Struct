require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "POST /create" do
    let(:post_params) do
      attributes_for(:post)
    end
    context " when params are ok" do
      it "http status should be created" do
        post "/api/posts/create", params: {post: post_params}
        expect(response).to have_http_status(:created)
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

    describe "PATCH /update/:id" do
      let(:post) {create(:post, title: 'teste')}
      context " when params are ok" do
        let(:post_params) do
          attributes_for(:post)
        end
        it "http status should be ok" do
          patch "/api/posts/update/#{post.id}", params: {post: post_params}
          expect(response).to have_http_status(:ok)
        end
      end

      context " when new title is nil" do
        let(:post_params) do
          attributes_for(:post, title: nil)
        end
        it "http status should be bad_request" do
          patch "/api/posts/update/#{post.id}", params: {post: post_params}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when new title already exists" do
        let(:post_params) do
          attributes_for(:post, title: 'teste')
        end
        it "http status should be bad_request" do
          post1 = create(:post, title: 'teste1')
          patch "/api/posts/update/#{post1.id}", params: {title:'teste'}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when not found" do
        let(:post_params) {attributes_for(:post)}
        it " http status should be not_found" do
          patch "/api/posts/update/-1", params: {post: post_params}
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE /delete/:id" do
    let(:post) {create(:post)}
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/posts/delete/#{post.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing post should return http status not_found" do
        delete "/api/posts/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    POSTS_NUMBER = 20
    before do
      for i in 1..POSTS_NUMBER
        create(:post, title: "teste #{i}")
      end
    end

    context "not paginated" do
      before do
        get '/api/posts'
      end

      it "should return all categories in body" do
        expect(JSON.parse(response.body).size).to eq(POSTS_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    context "when params are ok" do
      let(:post) {create(:post)}
      it "http status should be ok" do
        get "/api/posts/#{post.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing post should return http status not_found" do
        delete "/api/posts/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end