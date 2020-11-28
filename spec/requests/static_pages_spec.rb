RSpec.describe "静的ページ", type: :request do
  describe "homeページ" do
    it "httpリクエストは成功する" do
      get root_path
      expect(response).to have_http_status "200"
    end
  end

  describe "Sukkiriについてページ" do
    it "httpリクエストは成功する" do
      get about_path
      expect(response).to have_http_status "200"
    end
  end

  describe "利用規約ページ" do
    it "httpリクエストは成功する" do
      get terms_path
      expect(response).to have_http_status "200"
    end
  end
end
