class ProductsController < ApplicationController

  def index
    @products = Product.all
  end

  def synchronize
    @message = "synchronization starts soon."
    @message = "Initial #{@message}" if params[:initial]
    SynchronizationJob.perform_later(initial: params[:initial])
    render json: {msg: @message}
  end
end
