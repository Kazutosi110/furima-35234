class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :group_item, only: [:index, :create]

  def index
    @record_purchase = RecordPurchase.new
    move_to_root
  end

  def create
    @record_purchase = RecordPurchase.new(record_params)
    move_to_root
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

  def move_to_root
    redirect_to root_path and return if current_user.id == @item.user_id

    redirect_to root_path if @item.record.present?
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: record_params[:token],
      currency: 'jpy'
    )
  end

  def group_item
    @item = Item.find(params[:item_id])
  end
end
