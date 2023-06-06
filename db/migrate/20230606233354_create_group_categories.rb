class CreateGroupCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :group_categories do |t|
      t.integer :group_id
      t.integer :category_id

      t.timestamps
    end
  end
end
