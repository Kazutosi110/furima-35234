class RecordsController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    @record_purchase = RecordPurchase.new
    redirect_to root_path and return if current_user.id == @item.user_id

    redirect_to root_path if @item.record.present?
  end

  def new
  end

  def create
    @item = Item.find(params[:item_id])
    @record_purchase = RecordPurchase.new(record_params)
    if @record_purchase.valid?
      pay_item
      @record_purchase.save
      redirect_to root_path
    else
      render :index
    end
  end

  private

  def record_params
    params.require(:record_purchase).permit(:delivery_municipality, :delivery_address, :delivery_postcode, :shipping_area_id, :delivery_phone, :delivery_building).merge(
      user_id: current_user.id, item_id: @item.id, token: params[:token]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: record_params[:token],
      currency: 'jpy'
    )
  end
end
