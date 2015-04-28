namespace :gtfs do
  task :generate => 'lib/gtfs-realtime.pb.rb'

  file 'lib/gtfs-realtime.pb.rb' => 'vendor/gtfs-realtime.proto' do |t|
    sh "protoc --beefcake_out #{File.dirname t.name} #{t.prerequisites.join ' '}"
  end
end
