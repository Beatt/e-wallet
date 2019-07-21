require 'rails_helper'

RSpec.describe 'Crypt' do
  context 'encrypt' do
    it 'should encrypt data successfully' do
      data = '302030402'
      data_encrypt = CryptServices.encrypt(data)
      expect(data_encrypt).not_to eq(data)
    end
  end

  context 'decrypt' do
    it 'should decrypt data successfully' do
      data = '302030402'
      data_encrypt = CryptServices.encrypt(data)
      data_decrypt = CryptServices.decrypt(data_encrypt)
      expect(data_decrypt).to eq(data)
    end
  end
end