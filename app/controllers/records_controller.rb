class RecordsController < ApplicationController
  before_action :authenticate_user!, except: :index

  def index
    @record_purchase = RecordPurchase.new
  end

  def new
  end

  def create
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
    params.require(:record_purchase).permit(:delivery_municipality, :delivery_address, :postal_code, :shipping_area_id, :delivery_phone, :delivery_building, :items_id).merge(user_id: current_user.id)
  end

end
