class AddSlugToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :slug, :string
    add_index :movies, :slug, unique: true
  end
end
