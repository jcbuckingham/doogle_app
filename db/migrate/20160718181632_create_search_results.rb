class CreateSearchResults < ActiveRecord::Migration[5.0]
  def change
    create_table :search_results do |t|
      t.string :user_input

      t.timestamps
    end
  end
end
