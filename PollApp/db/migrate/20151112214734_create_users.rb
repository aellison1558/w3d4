class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      # t.data_type :column_name, :constraints
      t.string :name, null: false
      t.timestamps
    end
  end
end
