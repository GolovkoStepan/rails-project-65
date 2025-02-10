class CreateBulletins < ActiveRecord::Migration[7.2]
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :description
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
