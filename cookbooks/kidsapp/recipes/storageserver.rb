include_recipe "mongodb::default"

mongodb_instance "mongodb" do
  port node['application']['port']
end