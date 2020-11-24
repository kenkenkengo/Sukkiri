RSpec.describe "静的ページ", type: :system do
  describe "homeページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "Sukkiriの文字列が存在する" do
        expect(page).to have_content 'Sukkiri'
      end
    end
  end

  describe "aboutページ" do
    before do
      visit about_path
    end

    it "Sukkiriについての文字列が存在する" do
      expect(page).to have_content 'Sukkiriについて'
    end
  end

  describe "termsページ" do
    before do
      visit terms_path
    end

    it "利用規約の文字列が存在する" do
      expect(page).to have_content '利用規約'
    end
  end
end
