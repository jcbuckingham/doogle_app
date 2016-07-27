class RemoveAuthorAssociations < ActiveRecord::Migration[5.0]
  change_table :definitions do |t|
    t.remove :author_id
  end
end
