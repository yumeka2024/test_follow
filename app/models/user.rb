class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # アソシエーション
  has_many :follows

  # フォローユーザーの検索
  #   フォロー済みの場合、ユーザーデータを返す
  #   フォローしていない場合は、nilを返す
  def following?(current_user, follow_id)
    # Followから自分と対象のユーザーがANDになっているレコードを検索
    Follow.find_by(user_id: follow_id, follow_id: current_user.id)
  end

  # フォローしている一覧取得
  def followed(user)
    Follow.where(follow_id: user.id)
  end

  # フォローされている一覧取得
  def follower(current_user)
    Follow.where(user_id: current_user.id)
  end


end
