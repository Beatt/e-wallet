class CryptServices

  def initialize(secret_key)
    key = ActiveSupport::KeyGenerator.new('password').generate_key(secret_key, 32)
    @crypt = ActiveSupport::MessageEncryptor.new(key)
  end

  def encrypt(data)
    @crypt.encrypt_and_sign(data)
  end

  def decrypt(data)
    @crypt.decrypt_and_verify(data)
  rescue StandardError => e
    :key_invalidate
  end
end