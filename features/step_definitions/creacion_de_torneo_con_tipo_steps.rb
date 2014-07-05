Given(/^quiero crear un torneo con nombre "(.*?)"$/) do |nombre_torneo|
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
end

Given(/^agrego al "(.*?)"$/) do |nombre_equipo|
  select(nombre_equipo, :from => 'equipo_select')
  click_button('Agregar Equipo')
end

Given(/^elijo que sea solo con partidos de ida$/) do
  select('IDA', :from => 'tipo_torneo_select')
end

Then(/^el torneo "(.*?)" se crea exitosamente y tiene "(.*?)" fechas\.$/) do |nombre_torneo, numero_fecha_maximo|
  click_button('Crear')
  click_link (nombre_torneo)
  expect(page).to have_content 'Fecha ' + numero_fecha_maximo
end


Given(/^elijo que sea solo con partidos de ida y vuelta$/) do
  select('IDA Y VUELTA', :from => 'tipo_torneo_select')
end




