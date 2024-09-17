require 'rails_helper'
describe User do
  describe '#create' do
    context 'can save' do
      it "必須項目が存在すれば登録できること" do
        user = build(:user)
        expect(user).to be_valid
      end

      it "パスワード（password）         8文字以上かつ32文字以下で半角英数字両方を含んでいれば登録できること" do
        user = build(:user, password: "abcd1234" * 4 , password_confirmation: "abcd1234" * 4)
        expect(user).to be_valid
      end

      it "メールアドレス（email）        半角英数字で構成されている場合登録できること" do
        user = build(:user, email: "test_1@domain.jp")
        expect(user).to be_valid
      end
    end

    context 'can not save' do
      describe "パーソナル情報バリデーションチェック" do
        it "姓(first_name)         存在しない場合は登録できないこと" do
          user = build(:user, first_name: nil)
          user.valid?
          expect(user.errors[:first_name]).to include("を入力してください")
        end

        it "名(last_name)          存在しない場合は登録できないこと" do
          user = build(:user, last_name: nil)
          user.valid?
          expect(user.errors[:last_name]).to include("を入力してください")
        end

        it "誕生日(birthday)        存在しない場合は登録できないこと" do
          user = build(:user, birthday: nil)
          user.valid?
          expect(user.errors[:birthday]).to include("を入力してください")
        end

      end

      describe "メールアドレスバリデーションチェック" do
        it "メールアドレス（email）      存在しない場合は登録できないこと" do
          user = build(:user, email: nil)
          user.valid?
          expect(user.errors[:email]).to include("を入力してください")
        end

        it "メールアドレス（email）      全角文字を含む場合登録できないこと" do
          user = build(:user, email: "test１あア青ー@domain.jp")
          user.valid?
          expect(user.errors[:email]).to include("は不正な値です")
        end
      end

      describe "パスワードバリデーションチェック" do
        it "パスワード（password）       存在しない場合登録できないこと" do
          user = build(:user, password: nil, password_confirmation: nil)
          user.valid?
          expect(user.errors[:password]).to include("を入力してください")
        end

        it "パスワード（password）       半角英数字両方を含んでいていも8文字未満の場合は登録できないこと" do
          user = build(:user, password: "abc1234", password_confirmation: "abc1234")
          user.valid?
          expect(user.errors[:password]).to include("は8文字以上で入力してください")
        end

        it "パスワード（password）       半角英数字両方を含んでも32文字を超える場合は登録できないこと" do
          user = build(:user, password: "a12" *11 , password_confirmation:  "a12" * 11)
          user.valid?
          expect(user.errors[:password]).to include("は32文字以内で入力してください")
        end

        it "パスワード（password）       半角英数字以外を含む場合は登録できないこと" do
          user = build(:user, password: "１あアーabc1234", password_confirmation: "１あアーabc1234")
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end

        it "パスワード（password）       半角英字のみの場合は登録できないこと" do
          user = build(:user, password: "a" * 8, password_confirmation: "a" * 8)
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end

        it "パスワード（password）       半角数字のみの場合は登録できないこと" do
          user = build(:user, password: "1" * 8, password_confirmation: "1" * 8)
          user.valid?
          expect(user.errors[:password]).to include("は不正な値です")
        end
      end

    end
  end
end 