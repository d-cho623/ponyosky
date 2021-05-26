require 'rails_helper'

RSpec.describe 'ユーザー新規登録', type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context 'ユーザー新規登録ができるとき' do 
    it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ユーザーID', with: @user.uid
      fill_in '名前', with: @user.name
      fill_in 'メールアドレス', with: @user.email
      fill_in 'password', with: @user.password
      fill_in 'password-confirmation', with: @user.password_confirmation
      select '社員', from: 'user[occupation_id]'
      select '職場1', from: 'user[workplace_id]'
      select '1組', from: 'user[group_id]'
      # サインアップボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect {
        find('input[name="commit"]').click
      }.to change{User.count}.by(1)
      # トップページへ遷移したことを確認する
      expect(current_path).to eq(root_path)
      # トップページにログアウトボタンがあることを確認する
      expect(page).to have_content("ログアウト")
      # サインアップページへ遷移するボタンや、ログインページへ遷移するボタンが表示されていないことを確認する
      expect(page).to have_no_content('新規登録')
      expect(page).to have_no_content('ログイン')
    end
  end
  context 'ユーザー新規登録ができないとき' do
    it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページへ遷移するボタンがあることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページへ移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in 'ユーザーID', with: ''
      fill_in '名前', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'password', with: ''
      fill_in 'password-confirmation', with: ''
      select '--', from: 'user[occupation_id]'
      select '--', from: 'user[workplace_id]'
      select '--', from: 'user[group_id]'
      # サインアップボタンを押してもユーザーモデルのカウントは上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 新規登録ページへ戻されることを確認する
      expect(current_path).to eq(user_registration_path)
    end
  end
end