# frozen_string_literal: true

require 'test_helper'

module Web
  class ProfileControllerTest < ActionDispatch::IntegrationTest
    setup do
      @bulletin = bulletins(:one)
      @user = users(:one)
    end

    test 'should get show' do
      sign_in(@user)

      get profile_url

      assert_response :success
    end
  end
end
