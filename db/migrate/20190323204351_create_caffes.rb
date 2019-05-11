class CreateCaffes < ActiveRecord::Migration[5.2]
  def change
    create_table :caffes do |t|

      t.timestamps
    end
  end
end
