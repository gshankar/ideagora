module UsersHelper
  def get_gravatar(user, size) #you can request an image size between 1px - 512px.
    email_md5 = Digest::MD5.hexdigest(user.email).to_s
    url = "http://www.gravatar.com/avatar/" + email_md5 + "?s=" + size.to_s
  end
end
