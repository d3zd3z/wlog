require 'digest/sha1'

class User < ActiveRecord::Base
  has_many :weeks

  def password
    @password
  end

  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end

  def self.authenticate(login, password)
    user = self.find_by_login(login)
    if user
      expected = encrypted_password(password, user.salt)
      if user.hashed_password != expected
        user = nil
      end
    end
    user
  end

  private
  def self.encrypted_password(password, salt)
    txt = password + ":wlog:" + salt
    Digest::SHA1.hexdigest(txt)
  end

  def create_new_salt
    self.salt = ActiveSupport::SecureRandom.base64
  end
end
