class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      redirect_to products_url, :notice => "Successfully created product."
    else
      render :action => 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      redirect_to products_url, :notice  => "Successfully updated product."
    else
      render :action => 'edit'
    end
  end

  def buy
    product = Product.find(params[:id])
    payment = Payment.create
    response = PAYPAL_GATEWAY.setup_purchase(product.price * 100, {:return_url => check_out_products_url, :cancel_return_url => root_url})
    payment.update_attributes({:price => product.price, :token => response.params['token']})
    redirect_to PAYPAL_GATEWAY.redirect_url_for(response.params['token'], :review => false)
  end

  def check_out
    payment = Payment.find_by_token!(params[:token])
    details = PAYPAL_GATEWAY.details_for(params[:token])
    purchase = PAYPAL_GATEWAY.purchase(payment.price * 100 + 10000, {:payer_id => params[:PayerID], :token => params[:token]})
    if details.success? && purchase.success?

      flash[:notice] = "PAYMENT OK"
    else
      flash[:notice] = "PAYMENT NO OK"
    end

    redirect_to root_url
  end

end
