require 'rails_helper'

RSpec.describe 'Crypt' do
  context 'encrypt' do
    it 'should encrypt data successfully' do
      data = '302030402'
      crypt_services = CryptServices.new('Hola1234')
      data_encrypt = crypt_services.encrypt(data)
      expect(data_encrypt).not_to eq(data)
    end
  end

  context 'decrypt' do
    it 'should decrypt data successfully' do
      data = '302030402'
      crypt_services = CryptServices.new('Hola1234')
      data_encrypt = crypt_services.encrypt(data)
      data_decrypt = crypt_services.decrypt(data_encrypt)
      expect(data_decrypt).to eq(data)
    end
    it 'shouldn´t decrypt data successfully without different key' do
      data = '302030402'
      crypt_services = CryptServices.new('Hola1234')
      data_encrypt = crypt_services.encrypt(data)

      _crypt_services = CryptServices.new('Hola12')
      data_decrypt = _crypt_services.decrypt(data_encrypt)
      expect(data_decrypt).to eq(:key_invalidate)
    end
  end
end