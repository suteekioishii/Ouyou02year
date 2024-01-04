class CreateCourses < ActiveRecord::Migration[7.0]
  def change
    create_table :courses do |t|
      t.references :salon, null:false
      t.string :name, null:false    #コース名前
      t.integer :price,null:false    #値段
      t.integer :required_time    #かかる時間
      t.timestamps
    end
  end
end
