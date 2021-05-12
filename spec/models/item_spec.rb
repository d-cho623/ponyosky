require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品新規登録' do
    context '商品が登録できる場合' do
      it '全ての項目が入力されていれば登録できる' do
        expect(@item).to be_valid
      end
      it '商品番号が空でも商品コードが入力されていれば登録できる' do
        @item.number = nil
        expect(@item).to be_valid
      end
      it '商品コードが空でも商品番号が入力されていれば登録できる' do
        @item.code = nil
        expect(@item).to be_valid
      end
      it '商社が空でも検索方法が入力されていれば登録できる' do
        @item.trading_company = ""
        expect(@item).to be_valid
      end
      it '検索方法が空でも商社が入力されていれば登録できる' do
        @item.retrieval = ""
        expect(@item).to be_valid
      end
    end
    
    context '商品が登録できない場合' do
      it '商品名が空では登録できない' do
        @item.name = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'メーカーが空では登録できない' do
        @item.maker = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("メーカーを入力してください")
      end
      it '商品番号と商品コードが両方空では登録できない' do
        @item.number = nil
        @item.code = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("商品番号か商品コードを入力してください")
      end
      it '数量が空では登録できない' do
        @item.quantity = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("数量を入力してください")
      end
      it '数量は数値以外では登録できない' do
        @item.quantity = "abcd"
        @item.valid?
        expect(@item.errors.full_messages).to include("数量は数値で入力してください")
      end
      it '価格が空では登録できない' do
        @item.price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("価格を入力してください")
      end
      it '価格は数値以外では登録できない' do
        @item.price = "あああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("価格は数値で入力してください")
      end
      it '合計価格が空では登録できない' do
        @item.total_price = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("合計金額を入力してください")
      end
      it '合計価格は数値以外では登録できない' do
        @item.total_price = "あああ"
        @item.valid?
        expect(@item.errors.full_messages).to include("合計金額は数値で入力してください")
      end
      it '商社と検索方法の両方が空では登録できない' do
        @item.trading_company = ""
        @item.retrieval = ""
        @item.valid?
        expect(@item.errors.full_messages).to include("商社か検索方法を入力してください")
      end
    end
  end
end
