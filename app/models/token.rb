class Token < ActiveRecord::Base
  belongs_to :login
  validates :token_text, :length => {:is => 22}

  def self.generate
    ret = Token.new
    ret.token_text = SecureRandom.urlsafe_base64(nil, false)
    ret
  end

  def expires_at
    created_at + 1.hour
  end

  def expired?
    DateTime.now >= expires_at
  end
end
