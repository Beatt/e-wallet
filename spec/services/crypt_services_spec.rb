require 'rails_helper'

RSpec.describe 'Crypt services' do
  context 'when encrypt data successfully' do
    it 'should response with data encrypt' do
      data = '302030402'
      data_encrypt = CryptServices.encrypt(data)
      expect(data_encrypt).not_to eq(data)
    end
  end

  context 'when decrypt data successfully' do
    it 'should response with data decrypy' do
      data = '302030402'
      data_encrypt = CryptServices.encrypt(data)
      data_decrypt = CryptServices.decrypt(data_encrypt)
      expect(data_decrypt).to eq(data)
    end
  end
end