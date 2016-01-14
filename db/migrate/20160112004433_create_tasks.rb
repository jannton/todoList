class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string 		:task_name,		:null => false
      t.boolean :checked,       :default => false
      t.timestamps null: false
    end
  end

end
