User.create!(
  [
    {
      username:  "マリア",
      email: "maria@example.com",
      password:              "password",
      password_confirmation: "password"
    },
    {
      username:  "桃太郎",
      email: "momotaro@example.com",
      password:              "password",
      password_confirmation: "password"
    },
    {
      username:  "リクルート",
      email: "recruit@example.com",
      password:              "password",
      password_confirmation: "password",
      notification: "true"
    }
  ]
)

Group.create!(
  [
    { name: "チラシ", admin_user_id: 1 },
    { name: "申込書", admin_user_id: 1 },
    { name: "納品書", admin_user_id: 3 },
    { name: "請求書", admin_user_id: 2 }
  ]
)

Belonging.create!(
  [
    { group_id: 1, user_id: 1 },
    { group_id: 1, user_id: 2 },
    { group_id: 1, user_id: 3 },
    { group_id: 2, user_id: 1 },
    { group_id: 2, user_id: 2 },
    { group_id: 2, user_id: 3 },
    { group_id: 3, user_id: 1 },
    { group_id: 3, user_id: 3 },
    { group_id: 4, user_id: 1 },
    { group_id: 4, user_id: 2 }
  ]
)

Post.create!(
  [
    {
      content: "食品スーパー",
      image: open("#{Rails.root}/public/images/meat1.jpg"),
      group_id: 1,
      user_id: 1,
      deadline: "2020/12/1",
      note: "肉が安い!",
    },
    {
      content: "家電",
      image: open("#{Rails.root}/public/images/washing_machine1.jpg"),
      group_id: 1,
      user_id: 1,
      deadline: "2021/1/19",
      note: "洗濯機が安い!",
    },
    {
      content: "ホームセンター",
      image: open("#{Rails.root}/public/images/bicycle1.jpg"),
      group_id: 1,
      user_id: 1,
      deadline: "2021/1/24",
      note: "自転車が安い!",
    },
    {
      content: "食品スーパー",
      image: open("#{Rails.root}/public/images/vegetable1.png"),
      group_id: 1,
      user_id: 2,
      deadline: "2020/12/1",
      note: "野菜が安い!",
    },
    {
      content: "家電",
      image: open("#{Rails.root}/public/images/pc1.jpg"),
      group_id: 1,
      user_id: 2,
      deadline: "2021/1/19",
      note: "パソコンが安い!",
    },
    {
      content: "ホームセンター",
      image: open("#{Rails.root}/public/images/sofa1.jpg"),
      group_id: 1,
      user_id: 2,
      deadline: "2021/1/24",
      note: "ソファが安い!",
    },
    {
      content: "食品スーパー",
      image: open("#{Rails.root}/public/images/meat2.jpg"),
      group_id: 1,
      user_id: 3,
      deadline: "2020/12/1",
      note: "肉が安い!",
    },
    {
      content: "家電",
      image: open("#{Rails.root}/public/images/tv1.jpg"),
      group_id: 1,
      user_id: 3,
      deadline: "2021/1/19",
      note: "テレビが安い!",
    },
    {
      content: "ホームセンター",
      image: open("#{Rails.root}/public/images/car_goods1.jpg"),
      group_id: 1,
      user_id: 3,
      deadline: "2021/1/19",
      note: "カー用品が安い!",
    },
    {
      content: "賃貸物件入居申込書",
      image: open("#{Rails.root}/public/images/rent1.jpg"),
      group_id: 2,
      user_id: 1,
      deadline: "",
      note: "",
    },
    {
      content: "フルート教室受講申込書",
      image: open("#{Rails.root}/public/images/flute_apply1.png"),
      group_id: 2,
      user_id: 1,
      deadline: "",
      note: "",
    },
    {
      content: "水道使用開始申込書",
      image: open("#{Rails.root}/public/images/water_apply1.jpg"),
      group_id: 2,
      user_id: 1,
      deadline: "",
      note: "",
    },
    {
      content: "イベント参加申込書",
      image: open("#{Rails.root}/public/images/event_apply1.jpg"),
      group_id: 2,
      user_id: 2,
      deadline: "",
      note: "",
    },
    {
      content: "icカード申込書",
      image: open("#{Rails.root}/public/images/ic_apply1.jpg"),
      group_id: 2,
      user_id: 2,
      deadline: "",
      note: "",
    },
    {
      content: "体験入隊申込書",
      image: open("#{Rails.root}/public/images/experience_apply1.jpg"),
      group_id: 2,
      user_id: 2,
      deadline: "",
      note: "",
    },
    {
      content: "研修申込書",
      image: open("#{Rails.root}/public/images/training_apply1.jpg"),
      group_id: 2,
      user_id: 3,
      deadline: "",
      note: "",
    },
    {
      content: "剣道連盟入会申込書",
      image: open("#{Rails.root}/public/images/kendo_apply1.jpg"),
      group_id: 2,
      user_id: 3,
      deadline: "",
      note: "",
    },
    {
      content: "スポーツクラブ入会申込書",
      image: open("#{Rails.root}/public/images/sportsclub_apply1.png"),
      group_id: 2,
      user_id: 3,
      deadline: "",
      note: "",
    },
    {
      content: "服の納品書",
      image: open("#{Rails.root}/public/images/cloth_recipt1.png"),
      group_id: 3,
      user_id: 1,
      deadline: "2020/12/1",
      note: "",
    },
    {
      content: "洗濯機の領収書",
      image: open("#{Rails.root}/public/images/washing_recipt1.jpg"),
      group_id: 3,
      user_id: 1,
      deadline: "2021/1/15",
      note: "",
    },
    {
      content: "家具の領収書",
      image: open("#{Rails.root}/public/images/furniture.recipt1.jpg"),
      group_id: 3,
      user_id: 1,
      deadline: "2021/3/1",
      note: "",
    },
    {
      content: "机の納品書",
      image: open("#{Rails.root}/public/images/desc_recipt1.png"),
      group_id: 3,
      user_id: 3,
      deadline: "2020/12/1",
      note: "",
    },
    {
      content: "パソコンの納品書",
      image: open("#{Rails.root}/public/images/pc_recipt1.png"),
      group_id: 3,
      user_id: 3,
      deadline: "2021/1/15",
      note: "",
    },
    {
      content: "テレビの納品書",
      image: open("#{Rails.root}/public/images/tv_recipt1.png"),
      group_id: 3,
      user_id: 3,
      deadline: "2021/3/1",
      note: "",
    },
    {
      content: "電気料金請求書",
      image: open("#{Rails.root}/public/images/electricity_invoice1.png"),
      group_id: 4,
      user_id: 1,
      deadline: "2021/1/15",
      note: "",
    },
    {
      content: "ガス料金請求書",
      image: open("#{Rails.root}/public/images/gas_invoice1.png"),
      group_id: 4,
      user_id: 1,
      deadline: "2021/1/15",
      note: "",
    },
    {
      content: "インターネット料金請求書",
      image: open("#{Rails.root}/public/images/internet_invoice1.png"),
      group_id: 4,
      user_id: 1,
      deadline: "2021/2/1",
      note: "",
    },
    {
      content: "水道料金請求書",
      image: open("#{Rails.root}/public/images/water_charges_invoice1.png"),
      group_id: 4,
      user_id: 2,
      deadline: "2021/1/15",
      note: "",
    },
    {
      content: "家賃請求書",
      image: open("#{Rails.root}/public/images/rent_invoice1.png"),
      group_id: 4,
      user_id: 2,
      deadline: "2021/2/1",
      note: "",
    },
    {
      content: "携帯料金請求書",
      image: open("#{Rails.root}/public/images/phone_invoice1.png"),
      group_id: 4,
      user_id: 2,
      deadline: "2021/2/28",
      note: "",
    }
  ]
)

Like.create!(
  [
    { user_id: 1, post_id: 4 },
    { user_id: 1, post_id: 7 },
    { user_id: 1, post_id: 13 },
    { user_id: 1, post_id: 16 },
    { user_id: 1, post_id: 22 },
    { user_id: 1, post_id: 28 },
    { user_id: 2, post_id: 1 },
    { user_id: 2, post_id: 7 },
    { user_id: 2, post_id: 10 },
    { user_id: 2, post_id: 16 },
    { user_id: 2, post_id: 25 },
    { user_id: 3, post_id: 1 },
    { user_id: 3, post_id: 2 },
    { user_id: 3, post_id: 3 },
    { user_id: 3, post_id: 4 },
    { user_id: 3, post_id: 5 },
    { user_id: 3, post_id: 6 },
    { user_id: 3, post_id: 10 },
    { user_id: 3, post_id: 11 },
    { user_id: 3, post_id: 13 },
    { user_id: 3, post_id: 14 },
    { user_id: 3, post_id: 19 },
    { user_id: 3, post_id: 20 },
  ]
)

Comment.create!(
  [
    { user_id: 1, post_id: 4, comment: "野菜食べたい!" },
    { user_id: 1, post_id: 7, comment: "肉食べたい!" },
    { user_id: 1, post_id: 13, comment: "頑張れ!" },
    { user_id: 1, post_id: 16, comment: "頑張れ!" },
    { user_id: 1, post_id: 22, comment: "ありがとう!" },
    { user_id: 1, post_id: 28, comment: "ありがとう!" },
    { user_id: 2, post_id: 1, comment: "お腹すいた" },
    { user_id: 2, post_id: 7, comment: "お腹すいた" },
    { user_id: 2, post_id: 10, comment: "ありがとう!" },
    { user_id: 2, post_id: 16, comment: "ありがとう!" },
    { user_id: 2, post_id: 25, comment: "ありがとう!" },
    { user_id: 3, post_id: 1, comment: "お腹すいた" },
    { user_id: 3, post_id: 4, comment: "お腹すいた" },
    { user_id: 3, post_id: 10, comment: "了解" },
    { user_id: 3, post_id: 13, comment: "了解" },
    { user_id: 3, post_id: 19, comment: "了解" }
  ]
)

Notification.create!(
  [
    { user_id: 3, post_id: 7, from_user_id: 1,
       action_type: "liked_to_post" },
    { user_id: 3, post_id: 7, from_user_id: 2,
       action_type: "liked_to_post" },
    { user_id: 3, post_id: 16, from_user_id: 1,
       action_type: "commented_to_post", comment: "頑張れ!" },
    { user_id: 3, post_id: 16, from_user_id: 2,
       action_type: "commented_to_post", comment: "ありがとう!" }
  ]
)