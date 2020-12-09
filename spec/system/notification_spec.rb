RSpec.describe "通知機能", type: :system do
  context "自分以外のユーザーの投稿に対して通知を生成する場合" do
    let(:user) { create(:user, :user_with_groups) }

    before do
      login_as(user)
      @group = user.groups.first
      @user2 = create(:user)
      create(:belonging, user: @user2, group: @group)
      @post2 = create(:post, :image, user: @user2, group: @group)
      visit group_posts_path(@group)
    end

    it "like登録によって通知が作成されること", js: true do
      find('.like').click
      visit group_posts_path(@group)
      expect(page).not_to have_css '.n-circle'
      click_link "サインアウト"
      fill_in "user_email", with: @user2.email
      fill_in "user_password", with: @user2.password
      click_button "サインイン"
      expect(page).to have_css '.n-circle'
      visit notifications_path
      expect(page).not_to have_css '.n-circle'
      expect(page).to have_content "あなたの投稿が #{user.username} さんにlike登録されました。"
      expect(page).to have_content @post2.content
    end

    it "コメントによって通知が作成されること", js: true do
      fill_in "コメント ...", with: "hello world"
      click_button "送信"
      visit group_posts_path(@group)
      expect(page).not_to have_css '.n-circle'
      click_link "サインアウト"
      fill_in "user_email", with: @user2.email
      fill_in "user_password", with: @user2.password
      click_button "サインイン"
      expect(page).to have_css '.n-circle'
      visit notifications_path
      expect(page).not_to have_css '.n-circle'
      expect(page).to have_content "あなたの投稿に #{user.username} さんがコメントしました。"
      expect(page).to have_content '「hello world」'
      expect(page).to have_content @post2.content
    end
  end

  context "自分の投稿に対して通知を生成する場合" do
    let(:user) { create(:user, :user_with_groups_and_posts) }

    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
      visit group_posts_path(@group)
    end

    it "like登録によって通知が作成されないこと", js: true do
      find('.like').click
      visit group_posts_path(@group)
      expect(page).not_to have_css '.n-circle'
      visit notifications_path
      expect(page).not_to have_content "あなたの投稿が #{user.username} さんにlike登録されました。"
      expect(page).not_to have_content @post.content
    end

    it "コメントによって通知が作成されないこと", js: true do
      fill_in "コメント ...", with: "hello world"
      click_button "送信"
      visit group_posts_path(@group)
      expect(page).not_to have_css '.n-circle'
      visit notifications_path
      expect(page).not_to have_content "あなたの投稿に #{user.username} さんがコメントしました。"
      expect(page).not_to have_content '「hello world」'
      expect(page).not_to have_content @post.content
    end
  end
end
