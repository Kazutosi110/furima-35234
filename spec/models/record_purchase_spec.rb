require 'rails_helper'

RSpec.describe RecordPurchase, type: :model do
  describe '商品購入機能' do
    before do
      user = FactoryBot.create(:user)
      item = FactoryBot.create(:item)
      @record_purchase = FactoryBot.build(:record_purchase, user_id: user.id, item_id: item.id)
      sleep(1)
    end

    context '商品購入できる時' do
      it 'すべての値が正しく入力されていれば購入できる' do
        expect(@record_purchase).to be_valid
      end

      it 'delivery_buildingは空でも購入できる' do
        @record_purchase.delivery_building = ''
        expect(@record_purchase).to be_valid
      end

      it 'delivery_phoneが11桁以内の数値のみ購入できる' do
        @record_purchase.delivery_phone = '09012345678'
        expect(@record_purchase).to be_valid
      end
    end

    context '商品購入できない時' do
      it 'delivery_postcodeが空だと購入できない' do
        @record_purchase.delivery_postcode = ''
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Delivery postcode can't be blank")
      end

      it 'delivery_postcodeが半角のハイフンを含んだ正しい形式でないと購入できない' do
        @record_purchase.delivery_postcode = '1234567'
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include('Delivery postcode is invalid. Include hyphen(-)')
      end

      it 'shipping_area_idがないと購入できない' do
        @record_purchase.shipping_area_id = 1
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Shipping area can't be blank")
      end

      it 'delivery_municipalityが空だと購入できない' do
        @record_purchase.delivery_municipality = nil
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Delivery municipality can't be blank")
      end

      it 'delivery_addressが空だと購入できない' do
        @record_purchase.delivery_address = nil
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Delivery address can't be blank")
      end

      it 'delivery_phoneが空だと購入できない' do
        @record_purchase.delivery_phone = nil
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Delivery phone can't be blank")
      end

      it 'delivery_phoneが全角数字だと購入できない' do
        @record_purchase.delivery_phone = '２０００'
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include('Delivery phone is invalid.')
      end

      it 'userが紐付いていないと購入できない' do
        @record_purchase.user_id = nil
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("User can't be blank")
      end

      it 'tokenが空では登録できない' do
        @record_purchase.token = nil
        @record_purchase.valid?
        expect(@record_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
