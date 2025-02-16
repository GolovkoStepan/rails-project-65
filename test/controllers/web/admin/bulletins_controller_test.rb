# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class BulletinsControllerTest < ActionDispatch::IntegrationTest
      setup do
        sign_in users(:admin)
        @bulletin = bulletins(:under_moderation)
      end

      test 'should get index' do
        get admin_bulletins_url

        assert_response :success
      end

      test 'should archive' do
        patch archive_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert_equal('archived', @bulletin.state)
      end

      test 'should publish' do
        patch publish_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert_equal('published', @bulletin.state)
      end

      test 'should reject' do
        patch reject_admin_bulletin_path(@bulletin)

        @bulletin.reload
        assert_equal('rejected', @bulletin.state)
      end
    end
  end
end
