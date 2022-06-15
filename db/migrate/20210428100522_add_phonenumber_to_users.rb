class AddPhonenumberToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :phonenumber, :string
  end
end
