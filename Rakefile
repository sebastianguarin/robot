require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << "specs"
  t.pattern = 'specs/**/*_spec.rb'
  t.verbose = true
end


namespace :robot do

  desc "Run specific file"
  task :run_file, [:path] do |task, args|
    ruby("main.rb", args.path)
  end

  desc "Run Robot examples"
  task :run_examples do |task, args|
    examples = Dir.entries("./examples")

    examples.sort.each do |example|
      next if ["..", "."].include?(example)
      puts "              File: #{example}          \n"
      ruby("main.rb", "./examples/#{example}")
      puts "\n"
    end
  end
end