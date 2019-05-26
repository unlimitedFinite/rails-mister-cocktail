class AddSlugNameToCocktails < ActiveRecord::Migration[5.2]
  def change
    add_column :cocktails, :slug_name, :string
  end
end
