lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "robot"

toy = Robot::Toy.new
table = Robot::Table.new
controller = Robot::Controller.new(toy, table)

if ARGV.count > 0
  ARGV.each do|a|
    File.open(a, "r") do |f|
      f.each_line do |command|
        instruction = Robot::CommandParser.new(command)
        output = controller.exec(instruction.command, instruction.arguments)
        puts output unless (output == nil or output == "")
      end
    end
  end
else
  while input = STDIN.gets
    instruction = Robot::CommandParser.new(input)
    output = controller.exec(instruction.command, instruction.arguments)
    puts output unless (output == nil or output == "")
  end
end