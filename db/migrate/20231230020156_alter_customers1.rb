class AlterCustomers1 < ActiveRecord::Migration[7.0]
  def change
    add_column :customers, :password_digest,:string
    add_column :owners, :password_digest,:string
    add_column :administrators, :password_digest,:string
  end
end
