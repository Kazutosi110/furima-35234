class RecordsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @item = Item.find(params[:item_id])
    @record_purchase = RecordPurchase.new
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @record_purchase = RecordPurchase.new(record_params)
    if @record_purchase.valid?
      @record_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record_purchase).permit(:delivery_municipality, :delivery_address, :delivery_postcode, :shipping_area_id, :delivery_phone, :delivery_building).merge(user_id: current_user.id, item_id: @item.id)
  end

end
