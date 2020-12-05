class FixYearName < ActiveRecord::Migration[6.0]
  def change
    rename_column :people, :year, :vehicle_year
  end
end
