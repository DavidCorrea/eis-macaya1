Given(/^que tengo ya creado el equipo "(.*?)"$/) do |nombre_equipo|
  visit '/equipos/new'
  fill_in('equipo[name]', :with => nombre_equipo)
  click_button('Crear')
end

Given(/^^un torneo "(.*?)" con los equipos "(.*?)" y "(.*?)"$/) do |nombre_torneo, nombre_equipo1, nombre_equipo2|
  Torneo.all.destroy
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
  select(nombre_equipo1, :from => 'equipo_select')
  click_button('Agregar Equipo')
  select(nombre_equipo2, :from => 'equipo_select')
  click_button('Agregar Equipo')
  click_button('Crear')
end

Given(/^que no existan partidos$/) do
  Partido.all.destroy
end

When(/^creo un partido para el "(.*?)" con fecha "(.*?)"$/) do |nombre_torneo, fecha|
  visit '/'
  click_link (nombre_torneo)
  click_link ('Agregar Partido') #ID del Button
  # fill_in('partido[torneo]', :with => nombre_torneo)
  fill_in('partido[fecha]', :with => fecha)
end

When(/^defino equipo local "(.*?)"$/) do |equipoLocal|
  # fill_in('partido[equipo_local]', :with => equipoLocal)  
  select(equipoLocal, :from => 'equipo_local_select')
end

When(/^defino equipo visitante "(.*?)"$/) do |equipoVisitante|
  # fill_in('partido[equipo_visitante]', :with => equipoVisitante)  
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
