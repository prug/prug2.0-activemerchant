require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Product.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Product.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to products_url
  end

  def test_edit
    get :edit, :id => Product.first
    assert_template 'edit'
  end

  def test_update_invalid
    Product.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Product.first
    assert_template 'edit'
  end

  def test_update_valid
    Product.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Product.first
    assert_redirected_to products_url
  end
end
