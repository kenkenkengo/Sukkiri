RSpec.describe "投稿一覧", type: :system do
  context "投稿作成・編集・表示・検索" do
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
        fill_in "写真名", with: "書類"
        fill_in "メモ", with: "サンプル"
        page.find('#post_deadline').set("2021-02-01")
        attach_file "post[image]", "#{Rails.root}/spec/fixtures/test_image.jpg"
        click_button "登録する"
        expect(page).to have_content "写真を投稿しました"
      end

      it "画像無しで登録すると投稿に失敗する" do
        fill_in "写真名", with: "書類"
        fill_in "メモ", with: "サンプル"
        page.find('#post_deadline').set("2021-02-01")
        click_button "登録する"
        expect(page).to have_content "写真名の入力あるいは写真の選択をしてください"
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
        expect(page).to have_content @post.deadline.strftime("%Y年%m月%d日")
        expect(page).to have_content @post.note
        expect(page).to have_selector("img[src$='test_image.jpg']")
      end

      it "期限まで７日以上開いていれば期限が青文字で表示される" do
        expect(page).to have_selector '.still', text: '2021年02月01日'
      end

      it "期限まで７日以内であれば期限が黄文字で表示される" do
        travel_to Time.new(2021, 1, 26)
        visit group_posts_path(@group)
        expect(page).to have_selector '.approaching', text: '2021年02月01日'
      end

      it "期限を過ぎていれば期限が赤文字で表示される" do
        travel_to Time.new(2021, 2, 2)
        visit group_posts_path(@group)
        expect(page).to have_selector '.expirs', text: '2021年02月01日'
      end

      it "画像をクリックするとモーダルによる画像拡大表示", js: true do
        page.evaluate_script('$(".modal").modal()')
        find("#image-modal").click
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

      it "like登録/解除ができること", js: true do
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

      it "comment投稿/削除ができること", js: true do
        fill_in "コメント ...", with: "hello world"
        click_button "送信"
        within find("#comment-post-#{@post.id}") do
          expect(page).to have_selector 'span', text: user.username
          expect(page).to have_selector 'span', text: 'hello world'
        end
        link = find('.comment_delete')
        expect(link[:href]).to include
        group_post_comment_path(@group, @post, Comment.find_by(user_id: user.id, post_id: @post.id))

        link.click
        expect(page).not_to have_selector 'span', text: 'hello world'
      end

      it "別ユーザーの投稿のコメントには削除リンクが無いこと" do
        user2 = create(:user)
        create(:belonging, user: user2, group: @group)
        post = create(:post, :image, user: user2, group: @group)
        create(:comment, user: user2, post: post)
        visit group_posts_path(@group)
        within find("#comment-post-#{post.id}") do
          expect(page).not_to have_selector 'comment_delete'
        end
      end

      it "ぺージネーションが表示されること" do
        create_list(:post, 6, :image, user: user, group: @group)
        visit group_posts_path(@group)
        expect(page).to have_css "div.pagination"
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
        fill_in "写真名", with: "書類"
        fill_in "メモ", with: "サンプル"
        page.find('#post_deadline').set("2021-02-01")
        attach_file "post[image]", "#{Rails.root}/spec/fixtures/test_image2.jpg"
        click_button "更新する"
        expect(page).to have_content "投稿を更新しました"
      end

      it "パラメータ入力しない場合、パラメータは更新されない" do
        click_button "更新する"
        expect(@post.reload.content).to eq @post.content
        expect(@post.reload.image.url).to include "test_image.jpg"
      end

      it "写真名の入力をしない場合、更新に失敗する" do
        fill_in "写真名", with: ""
        click_button "更新する"
        expect(page).to have_content "写真名の入力をしてください"
      end

      it "「投稿削除」「投稿一覧へ戻る」のリンクが存在する" do
        expect(page).to have_link '投稿削除', href: group_post_path(@group, @post)
        expect(page).to have_link '投稿一覧へ戻る', href: group_posts_path(@group)
      end
    end

    context "検索機能" do
      before do
        login_as(user)
        @group = user.groups.first
        create(:post, :image, content: "食品スーパーチラシ", user: user, group: @group)
        create(:post, :image, content: "家電チラシ", user: user, group: @group)
        create(:post, :image, content: "申込書", user: user, group: @group)
        visit group_posts_path(@group)
      end

      it "検索フォームが表示されていること" do
        expect(page).to have_selector 'form#post_search'
      end

      it "検索ワードに該当する結果が表示されること" do
        fill_in 'q_content_cont', with: 'チラシ'
        click_button '検索'
        expect(page).to have_content "”チラシ”の検索結果：2件"
        within find('.search_results') do
          expect(page).to have_selector 'li', count: 2
        end
        visit group_posts_path(@group)
        fill_in 'q_content_cont', with: '申込書'
        click_button '検索'
        expect(page).to have_content "”申込書”の検索結果：1件"
        within find('.search_results') do
          expect(page).to have_selector 'li', count: 1
        end
      end

      it "検索ワードを入れずに検索ボタンを押した場合、投稿一覧が表示されること" do
        click_button '検索'
        expect(page).to have_content "投稿一覧"
        within find('.search_results') do
          expect(page).to have_selector 'li', count: @group.posts.count
        end
      end

      it "期限まで７日以上開いていれば期限が青文字で表示される" do
        fill_in 'q_content_cont', with: '申込書'
        click_button '検索'
        expect(page).to have_selector '.still', text: '2021年02月01日'
      end

      it "期限まで７日以内であれば期限が黄文字で表示される" do
        travel_to Time.new(2021, 1, 26)
        fill_in 'q_content_cont', with: '申込書'
        click_button '検索'
        expect(page).to have_selector '.approaching', text: '2021年02月01日'
      end

      it "期限を過ぎていれば期限が赤文字で表示される" do
        travel_to Time.new(2021, 2, 2)
        fill_in 'q_content_cont', with: '申込書'
        click_button '検索'
        expect(page).to have_selector '.expirs', text: '2021年02月01日'
      end

      it "検索結果のページネーション" do
        create_list(:post, 5, :image, content: "申込書", user: user, group: @group)
        visit group_posts_path(@group)
        fill_in 'q_content_cont', with: '申込書'
        click_button '検索'
        expect(page).to have_content "”申込書”の検索結果：6件"
        expect(page).to have_selector "div.pagination"
      end
    end
  end
end

context "投稿並べ替え" do
  let(:user) { create(:user, :user_with_groups) }

  before do
    login_as(user)
    @group = user.groups.first
    @post1 = create(:post, :image, content: "申込書", user: user, group: @group,
                                   deadline: "2021/1/1",
                                   created_at: "2021/1/1",
                                   updated_at: "2021/1/3")
    @post2 = create(:post, :image, content: "家電", user: user, group: @group,
                                   deadline: "2021/1/2",
                                   created_at: "2021/1/2",
                                   updated_at: "2021/1/2")
    @post3 = create(:post, :image, content: "食品", user: user, group: @group,
                                   deadline: "2021/1/3",
                                   created_at: "2021/1/3",
                                   updated_at: "2021/1/1")
    visit group_posts_path(@group)
  end

  context "投稿一覧ページ" do
    it "始めは投稿日時降順に並んでいること" do
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end

    it "「投稿日時」リンクをクリックすると投稿日の昇順と降順に並び替えられること" do
      click_link "投稿日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
      click_link "投稿日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end

    it "「更新日時」リンクをクリックすると投稿日の昇順と降順に並び替えられること" do
      click_link "更新日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
      click_link "更新日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
    end

    it "「期限」リンクをクリックすると期限の昇順と降順に並び替えられること" do
      click_link "期限"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
      click_link "期限"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end
  end

  context "検索結果ページ" do
    before do
      click_button '検索'
    end

    it "始めは投稿日時降順に並んでいること" do
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end

    it "「投稿日時」リンクをクリックすると投稿日の昇順と降順に並び替えられること" do
      click_link "投稿日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
      click_link "投稿日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end

    it "「更新日時」リンクをクリックすると投稿日の昇順と降順に並び替えられること" do
      click_link "更新日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
      click_link "更新日時"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
    end

    it "「期限」リンクをクリックすると期限の昇順と降順に並び替えられること" do
      click_link "期限"
      expect(page).to have_selector("li:nth-child(1)", text: @post1.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post3.content)
      click_link "期限"
      expect(page).to have_selector("li:nth-child(1)", text: @post3.content)
      expect(page).to have_selector("li:nth-child(2)", text: @post2.content)
      expect(page).to have_selector("li:nth-child(3)", text: @post1.content)
    end
  end
end
