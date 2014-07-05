Given(/^que tengo ya creado el equipo "(.*?)"$/) do |nombre_equipo|
  visit '/equipos/new'
  fill_in('equipo[name]', :with => nombre_equipo)
  click_button('Crear')
end

Given(/^^un torneo "(.*?)" con los equipos "(.*?)" y "(.*?)"$/) do |nombre_torneo, nombre_equipo1, nombre_equipo2|
  Torneo.destroy
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
  select(nombre_equipo1, :from => 'equipo_select')
  select('IDA', :from => 'tipo_torneo_select')
  click_button('Agregar Equipo')
  select(nombre_equipo2, :from => 'equipo_select')
  click_button('Agregar Equipo')
  click_button('Crear')
end

Given(/^que no existan partidos$/) do
  Partido.destroy
end

When(/^creo un partido para el "(.*?)" con fecha "(.*?)"$/) do |nombre_torneo, fecha|
  visit '/'
  click_link (nombre_torneo)
  click_link ('Agregar Partido') #ID del Button
  fill_in('partido[fecha]', :with => fecha)
end

And(/^defino equipo local "(.*?)"$/) do |equipoLocal|
  select(equipoLocal, :from => 'equipo_local_select')
end

When(/^defino equipo visitante "(.*?)"$/) do |equipoVisitante|
  select(equipoVisitante, :from => 'equipo_visitante_select')
end

When(/^creo el partido$/) do
  click_button('Crear')
end

Then(/^se visualiza el partido en el fixture$/) do  
  expect(page).to have_content 'PARTIDO AGREGADO EXITOSAMENTE'
end

Then(/^muestra un error que el partido ya existe$/) do
  expect(page).to have_content 'EL PARTIDO YA EXISTE'
end
