require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "POST /create" do
    let(:category_params) do
      attributes_for(:category)
    end
    context " when params are ok" do
      it "http status should be created" do
        post "/api/categories/create", params: {category: category_params}
        expect(response).to have_http_status(:created)
      end
    end

    context " when params aren't ok" do
      category_params = nil
      it "http status should be bad request" do
        post "/api/categories/create", params: {category: category_params}
        expect(response).to have_http_status(:bad_request)
      end
    end

    context " when given params already exists" do
      it "http status should be bad request" do
        post "/api/categories/create", params: {category: category_params}
        post "/api/categories/create", params: {category: category_params}  
        expect(response).to have_http_status(:bad_request)
      end
    end

    describe "PATCH /update/:id" do
      let(:category) {create(:category, title: 'teste')}
      context " when params are ok" do
        let(:category_params) do
          attributes_for(:category)
        end
        it "http status should be ok" do
          patch "/api/categories/update/#{category.id}", params: {category: category_params}
          expect(response).to have_http_status(:ok)
        end
      end

      context " when new title is nil" do
        let(:category_params) do
          attributes_for(:category, title: nil)
        end
        it "http status should be bad_request" do
          patch "/api/categories/update/#{category.id}", params: {category: category_params}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when new title already exists" do
        let(:category_params) do
          attributes_for(:category, title: 'teste')
        end
        it "http status should be bad_request" do
          category1 = create(:category, title: 'teste1')
          patch "/api/categories/update/#{category1.id}", params: {title:'teste'}
          expect(response).to have_http_status(:bad_request)
        end
      end

      context " when not found" do
        let(:category_params) {attributes_for(:category)}
        it " http status should be not_found" do
          patch "/api/categories/update/-1", params: {category: category_params}
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end

  describe "DELETE /delete/:id" do
    let(:category) {create(:category)}
    context "when params are ok " do
      it "http status should be ok" do
        delete "/api/categories/delete/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to delete non existing category should return http status not_found" do
        delete "/api/categories/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "GET /index" do
    CATEGORIES_NUMBER = 20
    before do
      for i in 1..CATEGORIES_NUMBER
        create(:category, title: "teste #{i}")
      end
    end

    context "not paginated" do
      before do
        get '/api/categories'
      end

      it "should return all categories in body" do
        expect(JSON.parse(response.body).size).to eq(CATEGORIES_NUMBER)
      end

      it "should return http status ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
  
  describe "GET /show/:id" do
    context "when params are ok" do
      let(:category) {create(:category)}
      it "http status should be ok" do
        get "/api/categories/#{category.id}"
        expect(response).to have_http_status(:ok)
      end
    end

    context "when params aren't ok" do
      it " try to show non existing category should return http status not_found" do
        delete "/api/categories/delete/-1"
        expect(response).to have_http_status(:not_found)
      end
    end
  end


end