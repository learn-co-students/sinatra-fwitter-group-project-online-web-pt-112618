class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    self.username.gsub("\s","-")
  end

  def self.find_by_slug(slug)
    slug = slug.gsub("-","\s")
    self.find_by(username: slug)
  end

end
