Given(/^no existen torneos$/) do
  Puntaje.destroy
  Torneo.destroy
  visit '/'
end

When(/^creo un torneo llamado "(.*?)"$/) do |nombre_torneo|
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
  select('IDA', :from => 'tipo_torneo_select')
  click_button('Crear')
 end

Then(/^se crea exitosamente el torneo "(.*?)"$/) do |nombre_torneo|
  visit '/'
  page.should have_content(nombre_torneo)
end

Then(/^me indica error porque ya existe un torneo$/) do 
  expect(page).to have_content 'NO SE PUDO CREAR EL TORNEO'
end

