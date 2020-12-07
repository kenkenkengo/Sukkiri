RSpec.describe "like機能", type: :request do
  let(:user) { create(:user, :user_with_groups_and_posts) }
  let(:liked_user) { create(:user, :user_with_groups_and_posts_and_likes) }

  context "サインインしていない場合" do
    before do
      @group = user.groups.first
      @post = user.posts.first
      @like = liked_user.likes.first
      @liked_group = liked_user.groups.first
      @liked_post = liked_user.posts.first
    end

    it "like登録は実行できず、サインインページへリダイレクトすること" do
      expect do
        post group_post_likes_path(@group, @post)
      end.not_to change(Like, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "like解除は実行できず、サインインページへリダイレクトすること" do
      expect do
        delete group_post_like_path(@liked_group, @liked_post, @like)
      end.not_to change(Like, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "サインインはしているが、異なるグループの投稿をlikeする場合" do
    let(:other_user) { create(:user, :other_user_with_groups_and_posts) }

    before do
      login_as(user)
      @other_group = other_user.groups.first
      @other_post = other_user.posts.first
      @like = liked_user.likes.first
      @liked_group = liked_user.groups.first
      @liked_post = liked_user.posts.first
    end

    it "like登録は実行できず、サインインページへリダイレクトすること" do
      expect do
        post group_post_likes_path(@other_group, @other_post)
      end.not_to change(Like, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "like解除は実行できず、サインインページへリダイレクトすること" do
      expect do
        delete group_post_like_path(@other_group, @other_post, @like)
      end.not_to change(Like, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "like一覧ページ" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_as(user)
        get likes_path
        expect(response).to have_http_status "200"
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get likes_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to new_user_session_path
      end
    end
  end
end
