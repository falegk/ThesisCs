begin
  Sunspot::Rails::Server.new.start
rescue
  # solr is already
end

# if defined?(Sunspot::Rails::Server)
#   Sunspot::Rails::Server.new.start
# else
#   Sunspot::Solr::Server.new.start
# end