class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :poll_id, null: false
      t.string :text, null: false
      t.timestamps
    end

    add_index(:questions, :poll_id)
    add_index(:questions, :text)
  end
end
