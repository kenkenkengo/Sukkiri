RSpec.describe "投稿一覧", type: :system do
  let(:user) { create(:user, :user_with_groups_and_posts) }
  let(:other_user) { create(:user, :other_user_with_groups_and_posts) }

  context "新規投稿フォーム" do
    before do
      login_as(user)
      @group = user.groups.first
      visit group_posts_path(@group)
    end

    it "グループ名が存在する" do
      expect(page).to have_content @group.name
    end

    it "有効な情報であれば投稿に成功する" do
      fill_in "写真名を入力", with: "書類"
      attach_file "post[image]", "#{Rails.root}/spec/fixtures/test_image.jpg"
      click_button "登録する"
      expect(page).to have_content "写真を投稿しました"
    end

    it "写真名無しの場合でも投稿に成功する" do
      attach_file "post[image]", "#{Rails.root}/spec/fixtures/test_image.jpg"
      click_button "登録する"
      expect(page).to have_content "写真を投稿しました"
    end

    it "画像無しで登録すると投稿に失敗する" do
      fill_in "写真名を入力", with: "書類"
      click_button "登録する"
      expect(page).to have_content "写真の選択をしてください"
    end
  end

  context "投稿一覧" do
    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
      visit group_posts_path(@group)
    end

    it "投稿者名、写真名、画像が存在する" do
      expect(page).to have_content @post.user.username
      expect(page).to have_content @post.content
      expect(page).to have_selector("img[src$='test_image.jpg']")
    end

    it "異なるグループの投稿は表示されない" do
      other_post = other_user.posts.first
      expect(page).not_to have_content other_user.username
      expect(page).not_to have_content other_post.content
      expect(page).not_to have_selector("img[src$='test_image2.jpg']")
    end

    it "自分の投稿であれば「投稿編集」リンクが存在する" do
      expect(page).to have_link '投稿編集', href: edit_group_post_path(@group, @post)
    end

    it "自分以外の投稿であれば「投稿編集」リンクが存在しない" do
      other_post = other_user.posts.first
      expect(page).not_to have_link '投稿編集', href: edit_group_post_path(@group, other_post)
    end

    it "keep登録/解除ができること", js: true do
      link = find('.like')
      expect(link[:href]).to include group_post_likes_path(@group, @post)
      link.click
      link = find('.unlike')
      expect(link[:href]).to include
      group_post_like_path(@group, @post, Like.find_by(user_id: user.id, post_id: @post.id))

      link.click
      link = find('.like')
      expect(link[:href]).to include group_post_likes_path(@group, @post)
    end
  end

  context "投稿編集ページ" do
    before do
      login_as(user)
      @group = user.groups.first
      @post = user.posts.first
      visit edit_group_post_path(@group, @post)
    end

    it "パラメータ入力すれば更新成功する" do
      fill_in "写真名を入力", with: "書類"
      attach_file "post[image]", "#{Rails.root}/spec/fixtures/test_image2.jpg"
      click_button "更新する"
      expect(page).to have_content "投稿を更新しました"
    end

    it "パラメータ入力しない場合、パラメータは更新されない" do
      click_button "更新する"
      expect(@post.reload.content).to eq @post.content
      expect(@post.reload.image.url).to include "test_image.jpg"
    end

    it "「投稿削除」「投稿一覧へ戻る」のリンクが存在する" do
      expect(page).to have_link '投稿削除', href: group_post_path(@group, @post)
      expect(page).to have_link '投稿一覧へ戻る', href: group_posts_path(@group)
    end
  end
end
