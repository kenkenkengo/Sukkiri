RSpec.describe "静的ページ", type: :system do
  describe "homeページ" do
    let!(:user) { create(:user) }

    before do
      visit root_path
    end

    it "Sukkiriの文字列が存在する" do
      expect(page).to have_content 'Sukkiri'
    end

    context "ログインしていない場合" do
      it "「専用サインイン」が表示される" do
        click_on('専用サインイン')
        expect(current_path).to eq new_user_session_path
      end
    end

    context "ログインしている場合" do
      before do
        login_as(user)
        visit root_path
      end

      it "「専用サインイン」が表示されない" do
        expect(page).not_to have_content '専用サインイン'
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
