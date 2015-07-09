require "spec_helper"
describe Robot::Toy do
  let(:toy) {Robot::Toy.new}

  context ".turn_right" do

    it "facing north" do
      toy.direction = :north
      expect{
        toy.turn_right
      }.to change(toy, :direction).from(:north).to(:east)
    end

    it "facing east" do
      toy.direction = :east
      expect{
        toy.turn_right
      }.to change(toy, :direction).from(:east).to(:south)
    end

    it "facing south" do
      toy.direction = :south
      expect{
        toy.turn_right
      }.to change(toy, :direction).from(:south).to(:west)
    end

    it "facing west" do
      toy.direction = :west
      expect{
        toy.turn_right
      }.to change(toy, :direction).from(:west).to(:north)
    end
  end


  context ".turn_left" do

    it "facing north" do
      toy.direction = :north
      expect{
        toy.turn_left
      }.to change(toy, :direction).from(:north).to(:west)
    end

    it "facing east" do
      toy.direction = :east
      expect{
        toy.turn_left
      }.to change(toy, :direction).from(:east).to(:north)
    end

    it "facing south" do
      toy.direction = :south
      expect{
        toy.turn_left
      }.to change(toy, :direction).from(:south).to(:east)
    end

    it "facing west" do
      toy.direction = :west
      expect{
        toy.turn_left
      }.to change(toy, :direction).from(:west).to(:south)
    end
  end

  context ".order_directions" do
    [:north, :east, :south, :west].each do |direction|
      it "facing #{direction.to_s}" do
        toy.direction = direction
        expect(toy.order_directions.first).to be(direction)
      end
    end
  end

  context ".remove_coordinates" do
    it "clear toy coordinates" do
      toy.add_coordinates(1,0)
      expect{
        toy.remove_coordinates
      }.to change(toy, :coordinates).from([1,0]).to([nil, nil])
    end
  end

  context ".coordinates" do
    it "return positions" do
      toy.add_coordinates(0,1)
      expect(toy.coordinates).to eq([0,1])
    end
  end
end