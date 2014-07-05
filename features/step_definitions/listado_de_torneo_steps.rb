Given(/^que tengo un torneo "(.*?)"$/) do |nombre_torneo|
  Torneo.all.destroy
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
  select('IDA', :from => 'tipo_torneo_select')
  click_button('Crear')
end

And(/^otro torneo "(.*?)"$/) do |nombre_torneo|
  visit '/torneos/new'
  fill_in('torneo[name]', :with => nombre_torneo)
  select('IDA', :from => 'tipo_torneo_select')
  click_button('Crear')
end

Then(/^la lista de torneos me muestra "(.*?)"$/) do |nombre_torneo|
  visit '/'
  page.should have_content(nombre_torneo)
end

Then(/^la lista de torneos esta vacia$/) do
#TODO check condition
  @torneos = Torneo.all
  @torneos.count.should == 0
end

