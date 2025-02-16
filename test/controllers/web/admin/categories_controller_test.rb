# frozen_string_literal: true

require 'test_helper'

module Web
  module Admin
    class CategoriesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one)
        @admin = users(:admin)
        @category = categories(:one)

        @attrs = {
          name: Faker::Coffee.variety
        }
      end

      test 'should not get index when user is not authorized nor is admin' do
        get admin_categories_url
        assert_redirected_to root_url

        sign_in(@user)
        get admin_categories_url
        assert_redirected_to root_url
      end

      test 'should get index when user is admin' do
        sign_in(@admin)
        get admin_categories_url

        assert_response :success
      end

      test 'should not get new when user is not logged in nor is admin' do
        get new_admin_category_url
        assert_redirected_to root_url

        sign_in(@user)
        get new_admin_category_url
        assert_redirected_to root_url
      end

      test 'should get new when user is admin' do
        sign_in(@admin)
        get new_admin_category_url

        assert_response :success
      end

      test 'should not create when user is not admin' do
        sign_in(@user)
        assert_no_difference 'Category.count' do
          post admin_categories_url, params: { category: @attrs }
        end

        assert_redirected_to root_url
      end

      test 'should create when user is admin' do
        sign_in(@admin)
        post admin_categories_url, params: { category: @attrs }

        category = Category.find_by(@attrs)

        assert(category)
        assert_redirected_to admin_categories_url
      end

      test 'should not get edit when user is not logged in nor is admin' do
        get edit_admin_category_url(@category)
        assert_redirected_to root_url

        sign_in(@user)
        get edit_admin_category_url(@category)
        assert_redirected_to root_url
      end

      test 'should get edit when user is admin' do
        sign_in(@admin)
        get edit_admin_category_url(@category)

        assert_response :success
      end

      test 'should not update when user is not admin' do
        sign_in(@user)
        patch admin_category_url(@category), params: { category: @attrs }

        @category.reload

        assert(@category.name != @attrs[:name])
        assert_redirected_to root_url
      end

      test 'should update when user is admin' do
        sign_in(@admin)
        patch admin_category_url(@category), params: { category: @attrs }

        @category.reload

        assert(@category.name == @attrs[:name])
        assert_redirected_to admin_categories_url
      end

      test 'should not destroy category when user is not admin' do
        sign_in(@user)

        assert_no_difference 'Category.count' do
          delete admin_category_url(@category)
        end

        assert_redirected_to root_url
      end

      test 'should destroy idle category when user is admin' do
        category = categories(:two)
        sign_in(@admin)

        delete admin_category_url(category)

        assert_nil Category.find_by(id: category.id)
        assert_redirected_to admin_categories_url
      end

      test 'should not destroy category with bulletins' do
        sign_in(@admin)

        assert_no_difference 'Category.count' do
          delete admin_category_url(@category)
        end

        assert_redirected_to admin_categories_url
      end
    end
  end
end
