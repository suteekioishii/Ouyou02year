class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :customer, null:false  
      t.references :salon, null:false      
      t.timestamps
    end
  end
end
