class ChangeBelongToInDefinitions < ActiveRecord::Migration[5.0]
  def change
    change_table :definitions do |t|
      t.belongs_to :search_result, index: true
    end
  end
end
