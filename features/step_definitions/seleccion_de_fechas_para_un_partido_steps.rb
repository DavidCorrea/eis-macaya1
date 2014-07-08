Given(/^defino fecha "(.*?)"$/) do |fecha|
  select(fecha, :from => 'fecha_select')
end

