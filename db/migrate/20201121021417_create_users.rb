class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, limit: 100
      t.string :email, limit: 100
      t.string :password, limit: 255
      t.timestamps
    end
  end
end
