migration 2, :create_equipos do
  up do
    create_table :equipos do
      #column :id, Integer, :serial => true
      column :name, DataMapper::Property::String, :length => 255,:key => true ,:unique => true
    end
  end

  down do
    drop_table :equipos
  end
end
