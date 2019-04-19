class CreateWallets < ActiveRecord::Migration[5.2]
  def change
    create_table :wallets do |t|
      t.string :wallet_address

      t.timestamps
    end
  end
end
