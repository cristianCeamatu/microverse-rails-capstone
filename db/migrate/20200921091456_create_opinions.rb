class CreateOpinions < ActiveRecord::Migration[6.0]
  def change
    create_table :opinions do |t|
      t.integer :author_id
      t.text :text

      t.timestamps
    end
  end
end
