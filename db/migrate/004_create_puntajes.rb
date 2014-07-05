migration 4, :create_puntajes do
  up do
    create_table :puntajes do
      column :id, Integer, :serial => true
      column :torneo_id, DataMapper::Property::Integer
      column :equipo_id, DataMapper::Property::Integer
      column :puntaje, DataMapper::Property::Integer
    end
  end

  down do
    drop_table :puntajes
  end
end
