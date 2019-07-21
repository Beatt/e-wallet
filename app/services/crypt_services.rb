class CryptServices

  secret_key_credit_cards = Rails.application.credentials[:secret_key_credit_cards]
  key = ActiveSupport::KeyGenerator.new('password').generate_key(secret_key_credit_cards, 32)
  @crypt = ActiveSupport::MessageEncryptor.new(key)

  class << self

    def encrypt(data)
      @crypt.encrypt_and_sign(data)
    end

    def decrypt(data)
      @crypt.decrypt_and_verify(data)
    rescue StandardError => e
      :key_invalidate
    end
  end
end
