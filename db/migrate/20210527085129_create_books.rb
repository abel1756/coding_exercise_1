class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.references :author, null: false, foreign_key: true
      t.string :isbn, unique: true, null: false
      t.string :title
      t.string :publisher
      t.integer :publication_year
      t.string :publication_country_code

      t.timestamps
    end

    add_index :books, :isbn, unique: true
  end
end
