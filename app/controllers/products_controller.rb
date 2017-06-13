class ProductsController < ApplicationController

  def index
    @products = Product.order('created_at ASC')
  end

  def synchronize
    @message = "synchronization starts soon."
    @message = "Initial #{@message}" if params[:initial]
    SynchronizationJob.perform_later(initial: params[:initial])
    render json: {msg: @message}
  end
end
