Given(/^no existen equipos$/) do
  Equipo.all.destroy
  visit '/'
end

When(/^voy a crear un equipo$/) do
	visit 'equipos/new'
end

And(/^creo un equipo llamado "(.*?)"$/) do |nombre_equipo|
	fill_in('equipo[name]', :with => nombre_equipo)
	click_button('Crear')
	page.should have_content(nombre_equipo)
end

When (/^vuelvo a crear el mismo nombre "(.*?)"$/) do |nombre_equipo|
  visit 'equipos/new'
  fill_in('equipo[name]', :with => nombre_equipo)
  click_button('Crear')
end

Then(/^se crea exitosamente el equipo "(.*?)"$/) do |nombre_equipo|
  visit '/'
  page.should have_content(nombre_equipo)
end

Then(/^me indica error porque ya existe un equipo$/) do 
  expect(page).to have_content 'Ya existe un mismo equipo'
end
