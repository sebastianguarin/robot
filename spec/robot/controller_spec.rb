require "spec_helper"

describe Robot::Controller do
  let!(:table) {Robot::Table.new}
  let!(:toy) {Robot::Toy.new}
  let(:controller) {Robot::Controller.new(toy, table)}

  describe ".exec" do
    valid_commands = ["MOVE", "REPORT", "RIGHT", "LEFT"]
    argument = [1, 2, 'NORTH']

    context "toy is not placed" do
      before(:each) {allow(table).to receive(:item_placed?).and_return(false)}

      valid_commands.each do |command|

        it "should not send #{command}" do
          expect(controller).to_not receive(command.downcase.to_sym)
          controller.exec(command, argument)
        end
      end

      it "should send PLACE with arguments" do
        expect(controller).to receive(:place).with(*argument)
        controller.exec('PLACE', argument)
      end

      it "should not send INVALID command" do
        expect(controller).to_not receive(:invalid).with(*argument)
        controller.exec('INVALID', argument)
      end
    end

    context "toy is placed" do
      before(:each) {allow(table).to receive(:item_placed?).and_return(true)}

      valid_commands.each do |command|

        it "send #{command}" do
          expect(controller).to receive(command.downcase.to_sym)
          controller.exec(command, argument)
        end
      end

      it "should send PLACE with arguments" do
        expect(controller).to receive(:place).with(*argument)
        controller.exec('PLACE', argument)
      end

      it "should not send INVALID command" do
        expect(controller).to_not receive(:invalid).with(*argument)
        controller.exec('INVALID', argument)
      end
    end
  end

  context "toy placed" do

    before(:each) {table.place(toy, 2, 2)}

    describe ".report" do

      it "call table view" do
        allow(controller).to receive(:table).and_return(table)
        expect(table).to receive(:view)
        controller.exec("REPORT")
      end
    end

    describe ".place" do

      before(:each) do
        allow(controller).to receive(:table).and_return(table)
        allow(controller).to receive(:toy).and_return(toy)
      end

      it "send toy to the table" do
        expect(table).to receive(:place).with(toy, any_args)
        controller.exec("PLACE", [0, 1, "north"])
      end

      it "update toy direction" do
        allow(table).to receive(:place).and_return(true)
        expect{controller.exec("PLACE", [0, 1, "south"])}.to change(toy, :direction).to(:south)
      end
    end

    describe ".left" do
      it "call toy turn left" do
        expect(toy).to receive(:turn_left)
        controller.exec("LEFT")
      end
    end

    describe ".right" do
      it "call table view" do
        expect(toy).to receive(:turn_right)
        controller.exec("RIGHT")
      end
    end

    describe ".move" do
      it "toy facing north" do
        expect{
          controller.exec("MOVE")
        }.to change(toy, :y).by(1)
      end

      it "toy facing west" do
        toy.direction = :west
        expect{
          controller.exec("MOVE")
        }.to change(toy, :x).by(-1)
      end

      it "toy facing east" do
        toy.direction = :east
        expect{
          controller.exec("MOVE")
        }.to change(toy, :x).by(1)
      end

      it "toy facing south" do
        toy.direction = :south
        expect{
          controller.exec("MOVE")
        }.to change(toy, :y).by(-1)
      end
    end
  end
end