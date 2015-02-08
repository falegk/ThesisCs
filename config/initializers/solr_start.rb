begin
  Sunspot::Rails::Server.new.start
rescue
  # solr is already running
end