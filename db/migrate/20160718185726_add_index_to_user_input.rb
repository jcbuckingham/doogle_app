class AddIndexToUserInput < ActiveRecord::Migration[5.0]
  def change
    add_index :search_results, :user_input, {:unique => true, :presence => true}
  end
end
