migration 1, :create_torneos do
  up do
    create_table :torneos do
      column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255, :unique => true
      column :tipo, DataMapper::Property::String, :length => 255
    end
  end

  down do
    drop_table :torneos
  end
end
