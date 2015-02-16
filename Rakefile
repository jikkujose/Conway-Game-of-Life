require 'opal'
require 'opal/browser'

desc "Compile Ruby to JS"
task :build do
  builder = Opal::Builder.new
  builder.processed.map { |asset| [asset.filename, asset.to_s] }

  Opal.append_path "app"

  File.open("app.js", "w") do |js_file|
    js_file.write Opal::Builder.build("application").to_s
  end
end

task :default => :build
