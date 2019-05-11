class CreateCustomweathers < ActiveRecord::Migration[5.2]
  def change
    create_table :customweathers do |t|

      t.timestamps
    end
  end
end
