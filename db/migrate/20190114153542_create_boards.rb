class CreateBoards < ActiveRecord::Migration[5.0]
  def change
    create_table :boards do |t|
      t.string :name
      t.string :title
      t.text :body

      t.timestamps # created_at, updated_atの作成
    end
  end
end
