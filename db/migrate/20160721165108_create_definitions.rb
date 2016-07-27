class CreateDefinitions < ActiveRecord::Migration[5.0]
  def change
    create_table :definitions do |t|
      t.text :content
      t.belongs_to :author, index: true
      t.timestamps
    end
  end

end
