require 'rails_helper'

RSpec.describe '申請投稿', type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
  end
  context '申請投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      visit new_user_session_path
      fill_in 'ユーザーID', with: @user.uid
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規申請ページへのボタンがあることを確認
      expect(page).to have_content("購入申請ページへ")
      # 投稿ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in "メーカー", with: @item.maker
      fill_in "商品名", with: @item.name
      fill_in "商品番号", with: @item.number
      fill_in "商品コード", with: @item.code
      fill_in "数量", with: @item.quantity
      fill_in "価格", with: @item.price
      fill_in "合計金額", with: @item.total_price
      fill_in "商社", with: @item.trading_company
      fill_in "検索方法", with: @item.retrieval
      # 送信するとItemモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{Item.count}.by(1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには先ほど投稿した内容が存在することを確認する
      expect(page).to have_content(@item.name)
    end
  end
  context 'ツイート投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのボタンがないことを確認する
      expect(page).to have_no_content("新規投稿ページへ")
    end

    it '誤った内容では新規投稿できない' do
      # トップページに移動する
      visit root_path
      # ログインする
      visit new_user_session_path
      fill_in 'ユーザーID', with: @user.uid
      fill_in 'password', with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 新規投稿ページへの遷移ボタンがあることを確認する
      expect(page).to have_content("購入申請ページへ")
      # 投稿ページに移動する
      visit new_item_path
      # フォームに情報を入力する
      fill_in "メーカー", with: ""
      fill_in "商品名", with: ""
      fill_in "商品番号", with: ""
      fill_in "商品コード", with: ""
      fill_in "数量", with: ""
      fill_in "価格", with: ""
      fill_in "合計金額", with: ""
      fill_in "商社", with: ""
      fill_in "検索方法", with: ""
      # 投稿ボタンを押してもItemモデルのカウントが増えないことを確認
      expect {
        find('input[name="commit"]').click
      }.to change{Item.count}.by(0)
      # 投稿ページに帰ってくることを確認
      expect(current_path).to eq(items_path)
    end
  end
end

RSpec.describe '投稿編集', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '投稿編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿した申請の編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "ユーザーID", with: @item1.user.uid
      fill_in "パスワード", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 投稿1に詳細ページへのリンクがあることを確認する
      expect(page).to have_content(@item1.name)
      visit item_path(@item1.id)
      # 編集ページへ遷移する
      expect(page).to have_content("申請を変更する")
      visit edit_item_path(@item1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(
        find('#maker').value
      ).to eq(@item1.maker)
      expect(
        find('#itemname').value
      ).to eq(@item1.name)
      expect(
        find('#number').value.to_i
      ).to eq(@item1.number)
      expect(
        find('#code').value.to_i
      ).to eq(@item1.code)
      expect(
        find('#quantity').value.to_i
      ).to eq(@item1.quantity)
      expect(
        find('#price').value.to_i
      ).to eq(@item1.price)
      expect(
        find('#total_price').value.to_i
      ).to eq(@item1.total_price)
      expect(
        find('#trading_company').value
      ).to eq(@item1.trading_company)
      expect(
        find('#retrieval').value
      ).to eq(@item1.retrieval)
      # 投稿内容を編集する
      fill_in "メーカー", with: "#{@item1.maker}あ"
      fill_in "商品名", with: "#{@item1.name}あ"
      fill_in "商品番号", with: @item1.number + 1
      fill_in "商品コード", with: @item1.code + 1
      fill_in "数量", with: @item1.quantity + 1
      fill_in "価格", with: @item1.price + 1
      fill_in "合計金額", with: @item1.total_price + 1 
      fill_in "商社", with: "#{@item1.trading_company}あ"
      fill_in "検索方法", with: "#{@item1.retrieval}あ"
      # 編集してもItemモデルのカウントは変わらないことを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{Item.count}.by(0)
      # 詳細ページに遷移することを確認
      expect(current_path).to eq(item_path(@item1.id))
      # トップページには先ほど変更した内容が存在することを確認する
      visit root_path
      expect(page).to have_content("#{@item1.name}あ")
    end
  end
  context '投稿編集ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿の編集画面には遷移できない' do
      # ツイート1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "ユーザーID", with: @item1.user.uid
      fill_in "パスワード", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 投稿2に「編集」へのリンクがないことを確認する
      expect(page).to have_content(@item2.name)
      visit item_path(@item2.id)
      expect(page).to have_no_content("申請を変更する")
    end
  end
end

RSpec.describe '申請削除', type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end
  context '投稿削除ができるとき' do
    it 'ログインしたユーザーは自らが投稿した申請の削除ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "ユーザーID", with: @item1.user.uid
      fill_in "パスワード", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 投稿1に「削除」へのリンクがあることを確認する
      expect(page).to have_content(@item1.name)
      visit item_path(@item1.id)
      expect(page).to have_content("申請を取り消す")
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('申請を取り消す', href: item_path(@item1)).click
      }.to change{Item.count}.by(-1)
      # トップページに遷移する
      expect(current_path).to eq(root_path)
      # トップページには投稿1の内容が存在しないことを確認する
      expect(page).to have_no_content(@item1.name)
    end
  end
  context 'ツイート削除ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿したツイートの削除ができない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in "ユーザーID", with: @item1.user.uid
      fill_in "パスワード", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq(root_path)
      # 投稿2に「削除」へのリンクがないことを確認する
      expect(page).to have_content(@item2.name)
      visit item_path(@item2)
      expect(page).to have_no_content("申請を取り消す")
    end
  end
end