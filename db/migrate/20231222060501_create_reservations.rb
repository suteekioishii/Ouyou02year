class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.references :coustomer, null:false  #外部キー
      t.date :reserved_date, null:false     #予約日付 
      t.integer :reserved_time, null:false     #予約日時
      t.integer :sum_price, null:false      #合計金額
      t.integer :cource_id                   #コース
      t.timestamps
    end
  end
end
