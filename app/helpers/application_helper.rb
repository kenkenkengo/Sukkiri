module ApplicationHelper
  BASE_TITLE = 'Sukkiri'.freeze

  def full_title(page_title)
    if page_title.blank?
      BASE_TITLE
    else
      "#{page_title} | #{BASE_TITLE}"
    end
  end

  def gravatar_for(user, size: 80)
    return user.profile_photo unless user.profile_photo.nil?
    gravatar_id = Digest::MD5::hexdigest(user.email).downcase
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
