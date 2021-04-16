require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it "nickname、email、password、password_confirmation、last_name、first_name、kana_last、kana_first、birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end

      it "passwordが6文字以上で、半角英数字の組み合わせであれば登録できる" do
        @user.password = "abcd123"
        @user.password_confirmation = "abcd123"
        @user.valid?
        expect(@user).to be_valid
      end

      it "last_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.last_name = "漢ひらカタ"
        @user.valid?
        expect(@user).to be_valid
      end

      it "first_nameが全角（漢字・ひらがな・カタカナ）であれば登録できる" do
        @user.first_name = "字がなカナ"
        @user.valid?
        expect(@user).to be_valid
      end

      it "kana_lastが全角カナ文字であれば登録できる" do
        @user.kana_last = "ゼンカクカナ"
        @user.valid?
        expect(@user).to be_valid
      end
    
      it "kana_firstが全角カナ文字であれば登録できる" do
        @user.kana_first = "ゼンカクカナ"
        @user.valid?
        expect(@user).to be_valid
      end
    end
    
    context '新規登録できないとき' do
      it 'nicknameが空では登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end

      it 'emailが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it "emailに@がない場合は登録できない " do
        @user.email = "aaaaaa"
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end

      it '重複したemailが存在する場合登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end

      it 'passwordが空では登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end

      it 'passwordが存在してもpassword_confirmationが空では登録できない' do
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = '00000'
        @user.password_confirmation = '00000'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end

      it "passwordとpassword_confirmationが一致していない場合は登録できない" do
        @user.password = "abcd123" 
        @user.password_confirmation = "1234abc"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      
      it "passwordが数字のみの場合は登録できない" do
        @user.password =  "1234567" 
        @user.password_confirmation = "1234567"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end
    
      it "passwordが英文字のみの場合は登録できない" do
        @user.password = "abcdefg" 
        @user.password_confirmation = "abcdefg"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "passwordが全角では登録できない" do
        @user.password = "ｅｅｅ２２２" 
        @user.password_confirmation = "ｅｅｅ２２２"
        @user.valid?
        expect(@user.errors.full_messages).to include("Password には英字と数字の両方を含めて設定してください")
      end

      it "last_nameが空では登録できない" do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name can't be blank","Last name Full-width characters")
      end

      it "last_nameが漢字・平仮名・カタカナ以外では登録できない" do
        @user.last_name = "bb22bb"
        @user.valid?
        expect(@user.errors.full_messages).to include("Last name Full-width characters")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("First name can't be blank", "First name Full-width characters")
      end
    
      it "first_nameが漢字・平仮名・カタカナ以外では登録できない" do
        @user.first_name = "cc33yy"
        @user.valid?
        expect(@user.errors.full_messages).to include("First name Full-width characters")
      end

      it "kana_lastが空では登録できない" do
        @user.kana_last = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last can't be blank", "Kana last Full-width katakana characters")
      end

      it "kana_lastが全角カタカナ以外では登録できない" do
        @user.kana_last = "a1かAｶ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana last Full-width katakana characters")
      end
    
      it "kana_firstが空では登録できない" do
        @user.kana_first = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first can't be blank", "Kana first Full-width katakana characters")
      end
    
      it "kana_firstが全角カタカナ以外では登録できない" do
        @user.kana_first = "a1かAｶ"
        @user.valid?
        expect(@user.errors.full_messages).to include("Kana first Full-width katakana characters")
      end

      it "birthdayが空では登録できない" do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end

end