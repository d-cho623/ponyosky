require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end

    describe 'ユーザー新規登録' do
      context 'ユーザー登録ができる場合' do
        it '全ての項目が入力されていれば、ユーザー登録できる' do
          expect(@user).to be_valid
        end

        it '職場は空でも登録できる' do
          @user.workplace_id = "1"
          expect(@user).to be_valid
        end
        
        it '組は空でも登録できる' do
          @user.group_id = "1"
          expect(@user).to be_valid
        end
      end

      context 'ユーザー登録できない場合' do
        it 'nameが空では登録できない' do
          @user.name = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("名前を入力してください")
        end

        it "nameは全角(漢字、平仮名、カタカナ以外では登録できない" do
          @user.name = "aaabbb"
          @user.valid?
          expect(@user.errors.full_messages).to include("名前はスペースを空けず、全角(漢字、ひらがな、カタカナ)のみで入力してください")
        end

        it "uidが空では登録できない" do
          @user.uid = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("ユーザーIDを入力してください")
        end

        it "uidは半角以外では入力できない" do
          @user.uid = "あaaaa"
          @user.valid?
          expect(@user.errors.full_messages).to include("ユーザーIDは3〜15文字の半角英数字で入力してください")
        end

        it "uidは2文字以下では登録できない" do
          @user.uid = "aa"
          @user.valid?
          expect(@user.errors.full_messages).to include("ユーザーIDは3〜15文字の半角英数字で入力してください")
        end

        it "uidは15文字以上では登録できない" do
          @user.uid = "abcdefghijklmnop"
          @user.valid?
          expect(@user.errors.full_messages).to include("ユーザーIDは3〜15文字の半角英数字で入力してください")
        end

        it "既に存在するuidでは登録できない" do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.uid = @user.uid
          another_user.valid?
          expect(another_user.errors.full_messages).to include("ユーザーIDはすでに存在します")
        end

        it "emailは空では登録できない" do
          @user.email = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("メールアドレスを入力してください")
        end

        it "emailが既に存在する場合は登録できない" do
          @user.save
          another_user = FactoryBot.build(:user)
          another_user.email = @user.email
          another_user.valid?
          expect(another_user.errors.full_messages).to include("メールアドレスはすでに存在します")
        end

        it "passwordが空では登録できない" do
          @user.password = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワードを入力してください")
        end

        it "password_confirmationが空では登録できない" do
          @user.password_confirmation = ""
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end

        it "password_confirmationがpasswordと異なる場合は登録できない" do
          @user.password_confirmation = "000001"
          @user.valid?
          expect(@user.errors.full_messages).to include("パスワード（確認用）とパスワードの入力が一致しません")
        end

        it 'occupationが空では登録できない' do
          @user.occupation_id = 1
          @user.valid?
          expect(@user.errors.full_messages).to include("役職が選択されていません")
        end
      end
    end
  end
end
