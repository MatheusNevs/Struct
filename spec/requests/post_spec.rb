require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /index" do
    POSTS_NUMBER = 20
    before do
      for i in 1..Posts_NUMBER
        create(:post)
      end
    end

    context "not paginated" do
      before do
        get 'posts'
      end

      it "should return all posts in body" do
        expect(JSON.parse(response.body).size).to eq(POSTS_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
    
    context "paginated, page 1, Posts_NUMBER/2+1 per page" do
      before do
        get 'posts', params: {
          per_page: (POSTS_NUMBER)/2+1,
          page: 1
        }
      end

      it "should return half+1 Posts in body" do
        expect(JSON.parse(response.body).size).to eq(POSTS_NUMBER/2 + 1)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "paginated, page 2, Posts_NUMBER/2+1 per page" do
      before do
        get 'Posts', params: {
          per_page: (POSTS_NUMBER)/2+1,
          page: 2
        }
      end

      it "should return half-1 Posts in body" do
        expect(JSON.parse(response.body).size).to eq(POSTS_NUMBER/2 - 1)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "paginated, page 3, Posts_NUMBER/2+1 per page" do
      before do
        get 'Posts', params: {
          per_page: (POSTS_NUMBER)/2+1,
          page: 3
        }
      end

      it "should return half-1 Posts in body" do
        expect(JSON.parse(response.body).size).to eq(0)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  let(:post) { create(:post) }
  describe "GET /show/:id" do
    context "when id exists" do
      before do
        get "posts/#{post.id}"
      end

      it "should return post in body" do
        expect(JSON.parse(response.body)["id"]).to eq(post.id)
      end

      it "should have all attributes" do
        expect(JSON.parse(response.body).keys).to contain_exactly("id", "name", "description", "created_at", "updated_at")
      end

      it "should return status ok" do
        expect(response).to have_http_status(:ok)
      end
    end

    context "when id does not exist" do
      before do
        get "posts/-1"
      end

      it "should return status not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe 'POST /create'
    context 'when params are ok' do
      let (:post_params) do
        {title: 'Teste', content:'Teste'}
      end

      it 'should create a post' do
        post 'posts/create', params: {post: post_params}
        expect(response).to have_http_status(:created)
      end
    end

    context "when params aren't ok" do
      it 'should not create a post' do
        post_params = {title: ''}
        post 'posts/create', params: {post: post_params}
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
  
  describe 'PATCH /update/:id'
    context 'when id exists' do
      let(:post) {create(:post)}

      it 'should update post info' do
        updated = {title: 'Titulo novo', content: 'Conteúdo novo'}
        patch "posts/update/#{post.id}", params: {post: updated}
        expect(post.title).to eq(updated[:title])
      end
    end

  describe 'DELETE /delete/:id' do
    context 'when id exists' do 
      let(:post) {create(:post)}

      it 'should delete the post' do
        delete "posts/delete/(#{post.id})"
        expect(Post.find_by(id:estudante.id)).to be_nill
      end
    end
  end