require 'opal'
require 'opal-jquery'

desc "Build our app to conway.js"
task :build do
  # env = Opal::Environment.new
  # env.append_path "app"

  File.open("conway.js", "w+") do |out|
    js = Opal.compile File.new("app/conway.rb").read
    out.write js
  end
end
