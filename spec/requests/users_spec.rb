require 'rails_helper'
include RequestMacros

RSpec.describe 'Users', type: :request do
  let(:user_params) do
    { user: { email: 'username+1@basicinc.jp', password: 'password' } }
  end

  describe 'JWT' do
    context 'POST /users' do
      it 'should be valid' do
        post '/users', user_params
        expect(response.status).to eq(302)
        expect(response).to redirect_to '/'
      end
    end

    context 'POST /users/sign_in' do
      before { create(:user) }
      it 'should be valid' do
        post '/users/sign_in', user_params.deep_merge(user: { remember_me: 0 })
        expect(response.status).to eq(302)
        expect(response).to redirect_to '/'
      end
    end

    context 'ClassMethods' do
      user_login
    end

    # TODO: edit password
    # context 'POST /users/password' do
    #   user_login
    #   it 'should be valid' do
    #     post '/users/password', user: { email: 'new_address@basicinc.jp', password: 'password' }
    #     expect(response.body).to eq(200)
    #   end
    # end
  end
end
