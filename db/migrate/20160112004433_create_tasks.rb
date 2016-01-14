class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string 		:task_name,		:null => false
      t.text		:description,	  :null => false
      t.string		:category,		:null => false
      t.date		:due_date,		  :null => false
      t.boolean :checked,       :default => false
      t.timestamps null: false
    end
  end

end
