require 'opal'
require 'opal-jquery'

desc "Compile Ruby to JS"
task :build do
  env = Sprockets::Environment.new
  env.append_path "app"

  File.open("app.js", "w+") do |out|
    out << env["application"].to_s
  end
end
