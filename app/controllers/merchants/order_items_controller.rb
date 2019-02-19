class Merchants::OrderItemsController < Merchants::BaseController

  def update
    order_item = OrderItem.find(params[:id])
    order_item.fulfill_order_item
    flash[:success] = "Your item has been fulfilled."
    redirect_to dashboard_order_path(order_item.order)
  end
end