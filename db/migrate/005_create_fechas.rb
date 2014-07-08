migration 5, :create_fechas do
  up do
    create_table :fechas do
      column :id, Integer, :serial => true
      column :numero, DataMapper::Property::Integer
      column :torneo_id, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :fechas
  end
end
