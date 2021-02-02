class AddIpIndex < ActiveRecord::Migration[6.1]
  disable_ddl_transaction!

  def change
    add_index :dns_records, :ip, unique: true
  end
end
