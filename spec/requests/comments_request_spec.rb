RSpec.describe "コメント機能", type: :request do
  let(:user) { create(:user, :user_with_groups_and_posts) }
  let(:commented_user) { create(:user, :user_with_groups_and_posts_and_comments) }

  context "サインインしていない場合" do
    before do
      @group = user.groups.first
      @post = user.posts.first
      @comment = commented_user.comments.first
      @commented_group = commented_user.groups.first
      @commented_post = commented_user.posts.first
    end

    it "コメントは実行できず、サインインページへリダイレクトすること" do
      expect do
        post group_post_likes_path(@group, @post)
      end.not_to change(Comment, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "コメント削除は実行できず、サインインページへリダイレクトすること" do
      expect do
        delete group_post_like_path(@commented_group, @commented_post, @comment)
      end.not_to change(Comment, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end

  context "サインインはしているが、異なるグループの投稿にコメントする場合" do
    let(:other_user) { create(:user, :other_user_with_groups_and_posts) }

    before do
      login_as(user)
      @other_group = other_user.groups.first
      @other_post = other_user.posts.first
      @comment = commented_user.comments.first
      @commented_group = commented_user.groups.first
      @commented_post = commented_user.posts.first
    end

    it "コメントは実行できず、サインインページへリダイレクトすること" do
      expect do
        post group_post_likes_path(@other_group, @other_post)
      end.not_to change(Comment, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end

    it "コメント削除は実行できず、サインインページへリダイレクトすること" do
      expect do
        delete group_post_like_path(@other_group, @other_post, @comment)
      end.not_to change(Comment, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to new_user_session_path
    end
  end
end
