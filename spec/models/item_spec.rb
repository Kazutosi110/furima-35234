require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品出品機能' do
    context '商品出品できるとき' do
      it "image, name, information, category_id, items_condition_id, delivery_charge_id, shipping_date_id, shipping_date_id, priceがあれば出品できる" do
        expect(@item).to be_valid
      end

      it "priceが300円なら出品できる" do
        @item.price = 300
        expect(@item).to be_valid
      end

      it "priceが9,999,999円なら出品できる" do
        @item.price = 9_999_999
        expect(@item).to be_valid
      end

      it "priceが半角数字なら出品できる" do
        @item.price = 300
        expect(@item).to be_valid
      end
    end

    context '商品出品できないとき' do
      it "imageがないと出品できない" do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end

      it 'nameがないと出品できない' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end

      it 'informationがないと出品できない' do
        @item.information = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Information can't be blank")
      end

      it 'category_idがないと出品できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Category must be other than 1")
      end

      it 'items_condition_idがないと出品できない' do
        @item.items_condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Items condition must be other than 1")
      end

      it 'delivery_charge_idがないと出品できない' do
        @item.delivery_charge_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery charge must be other than 1")
      end

      it 'shipping_area_idがないと出品できない' do
        @item.shipping_area_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping area must be other than 1")
      end

      it 'shipping_date_idがないと出品できない' do
        @item.shipping_date_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include("Shipping date must be other than 1")
      end

      it 'priceがないと出品できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end

      it 'priceが299円以下だと出品できない' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it 'priceが10,000,000円以上だと出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it "priceが全角数字では出品できない" do
        @item.price = '３００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price is not included in the list')
      end

      it "priceが半角英数混合では登録できない" do
        @item.price = "300dollars"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not a number")
      end

      it "priceが半角英語だけでは登録できない" do
        @item.price = "threemillion"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is not included in the list")
      end

      it "userが紐付いていないと保存できない" do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('User must exist')
      end

    end
  end
end