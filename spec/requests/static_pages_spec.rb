RSpec.describe "静的ページ", type: :request do
  describe "GET #home" do
    it "httpリクエストは成功する" do
      get root_path
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #about" do
    it "httpリクエストは成功する" do
      get about_path
      expect(response).to have_http_status "200"
    end
  end

  describe "GET #terms" do
    it "httpリクエストは成功する" do
      get terms_path
      expect(response).to have_http_status "200"
    end
  end
end
