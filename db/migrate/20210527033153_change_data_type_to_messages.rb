class ChangeDataTypeToMessages < ActiveRecord::Migration[6.1]
  def change
    change_column :messages, :text, :text
  end
end
