migration 3, :create_partidos do
  up do
    create_table :partidos do
      column :id, Integer, :serial => true
      column :fecha_id, DataMapper::Property::Integer
      column :id_equipo_local, DataMapper::Property::Integer
      column :resultado_local, DataMapper::Property::Integer
      column :id_equipo_visitante, DataMapper::Property::Integer
      column :resultado_visitante, DataMapper::Property::Integer
      column :dia, DataMapper::Property::Date
    end
  end

  down do
    drop_table :partidos
  end
end
