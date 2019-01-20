# == Schema Information
#
# Table name: boards
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  title      :string(255)
#  body       :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

=begin
# モデルは作成したテーブルのカラムをオブジェクトとして使うことができる
# O/Rマッパーと言う

+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| id         | int(11)      | NO   | PRI | NULL    | auto_increment |
| name       | varchar(255) | YES  |     | NULL    |                |
| title      | varchar(255) | YES  |     | NULL    |                |
| body       | text         | YES  |     | NULL    |                |
| created_at | datetime     | NO   |     | NULL    |                |
| updated_at | datetime     | NO   |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
=end

class Board < ApplicationRecord
  has_many :comments
  validates :name, presence: true, length: { maximum: 10}
  validates :title, presence: true, length: { maximum: 20 }
  validates :body, presence: true, length: { maximum: 300 }
end
