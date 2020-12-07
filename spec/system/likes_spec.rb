RSpec.describe "like一覧", type: :system do
  let(:liked_user) { create(:user, :user_with_groups_and_posts_and_likes) }

  before do
    @group = liked_user.groups.first
    @post = liked_user.posts.first
    login_as(liked_user)
    visit likes_path
  end

  it "like一覧ページが期待通り表示されること" do
    expect(page).to have_link @group.name, href: group_posts_path(@group)
    expect(page).to have_content @post.content
    expect(page).to have_selector("img[src$='test_image.jpg']")
  end

  it "画像をクリックするとモーダルによる画像拡大表示", js: true do
    page.evaluate_script('$(".modal").modal()')
    find("#image-modal").click
    expect(page).to have_selector("img[src$='test_image.jpg']")
  end
end
