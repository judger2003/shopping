class AddAddedToFavoritesAtToFavorites < ActiveRecord::Migration[7.0]
  def change
    add_column :favorites, :added_to_favorites_at, :datetime
  end
end
