class AddRoomToMessages < ActiveRecord::Migration[6.1]
  def change
    add_column :messages, :room, :integer
  end
end
