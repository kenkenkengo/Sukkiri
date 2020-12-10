RSpec.describe "タイトル表示", type: :system do
  let(:user) { create(:user, :user_with_groups_and_posts) }

  context "サインインしていない時" do
    it "トップページ" do
      visit root_path
      expect(page).to have_title 'Sukkiri'
    end

    it "Sukkiriについてページ" do
      visit about_path
      expect(page).to have_title 'Sukkiriについて | Sukkiri'
    end

    it "利用規約ページ" do
      visit terms_path
      expect(page).to have_title '利用規約 | Sukkiri'
    end

    it "新規登録ページ" do
      visit new_user_registration_path
      expect(page).to have_title '新規登録 | Sukkiri'
    end

    it "サインインページ" do
      visit new_user_session_path
      expect(page).to have_title 'サインイン | Sukkiri'
    end
  end

  context "サインインしている時" do
    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
    end

    it "トップページ" do
      visit root_path
      expect(page).to have_title 'Sukkiri'
    end

    it "ユーザープロフィールページ" do
      visit user_path(user)
      expect(page).to have_title "#{user.username} | Sukkiri"
    end

    it "ユーザー編集ページ" do
      visit edit_user_registration_path
      expect(page).to have_title 'プロフィール編集 | Sukkiri'
    end

    it "ユーザー一覧ページ" do
      visit users_path
      expect(page).to have_title 'ユーザー一覧 | Sukkiri'
    end

    it "パスワード編集ページ" do
      visit edit_password_path(user)
      expect(page).to have_title 'パスワード編集 | Sukkiri'
    end

    it "投稿一覧ページ" do
      visit group_posts_path(@group)
      expect(page).to have_title "#{@group.name} | Sukkiri"
    end

    it "投稿編集ページ" do
      visit edit_group_post_path(@group, @post)
      expect(page).to have_title "投稿編集 | Sukkiri"
    end

    it "グループ新規作成ページ" do
      visit new_group_path
      expect(page).to have_title "新規グループ登録 | Sukkiri"
    end

    it "グループ編集ページ" do
      visit edit_group_path(@group)
      expect(page).to have_title "グループ編集 | Sukkiri"
    end

    it "like一覧ページ" do
      visit likes_path
      expect(page).to have_title "like一覧 | Sukkiri"
    end

    it "通知一覧ページ" do
      visit notifications_path
      expect(page).to have_title "通知一覧 | Sukkiri"
    end

    it "グループ一覧ページ" do
      visit groups_path
      expect(page).to have_title "グループ一覧 | Sukkiri"
    end

    it "検索結果ページ" do
      visit search_group_posts_path(@group)
      expect(page).to have_title "検索結果 | Sukkiri"
    end
  end
end
