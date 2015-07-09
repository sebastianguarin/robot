require "spec_helper"

describe Robot::Table do
  let(:table) {Robot::Table.new}

  describe ".item_placed?" do

    let(:toy) {Robot::Toy.new}

    it "true if toy is placed" do
      table.place(toy)
      expect(table.item_placed?(toy)).to be_truthy
    end

    it "false if toy is not placed" do
      expect(table.item_placed?(toy)).to be_falsey
    end
  end

  describe ".place" do

    let(:toy) {Robot::Toy.new}

    it "with valid coordinates and toy is not placed" do
      allow(toy).to receive(:valid_coordinates?).and_return(true)
      expect(table.items).to receive(:push).with(toy)
      expect(toy).to receive(:add_coordinates).with(0,1)
      table.place(toy, 0, 1)
    end

    it "with valid coordinates and toy is placed" do
      allow(toy).to receive(:valid_coordinates?).and_return(true)
      allow(table).to receive(:item_placed?).and_return(true)
      expect(table.items).to_not receive(:push).with(toy)
      expect(toy).to receive(:add_coordinates).with(0,1)
      table.place(toy, 0, 1)
    end

    it "with invalid coordinates" do
      allow(table).to receive(:valid_coordinates?).and_return(false)
      expect{table.place(toy)}.to raise_error(Robot::BoundError)
    end
  end

  describe ".valid coordinates" do

    it "true if both coordinates are valid" do
      allow(table).to receive(:valid_x_position?).and_return(true)
      allow(table).to receive(:valid_y_position?).and_return(true)
      expect(table.valid_coordinates?(0,0)).to be_truthy
    end

    it "if x coordinates is invalid" do
      allow(table).to receive(:valid_x_position?).and_return(false)
      expect(table.valid_coordinates?(0,0)).to be_falsey
    end

    it "if y coordinates is invalid" do
      allow(table).to receive(:valid_y_position?).and_return(false)
      expect(table.valid_coordinates?(0,0)).to be_falsey
    end

  end

  describe ".valid_y_position" do
    it "position greather than height" do
      expect(table.valid_y_position?(table.height + 1)).to be_falsey
    end

    it "position in height bound" do
      expect(table.valid_y_position?(table.height)).to be_truthy
    end

    it " invalid position" do
      expect(table.valid_y_position?(-1)).to be_falsey
    end
  end

  describe ".valid_x_position" do
    it "position greather than width" do
      expect(table.valid_x_position?(table.width + 1)).to be_falsey
    end

    it "position in width bound" do
      expect(table.valid_x_position?(table.width)).to be_truthy
    end

    it "invalid position" do
      expect(table.valid_x_position?(-1)).to be_falsey
    end
  end

  describe ".find_item" do

    let(:toy) {Robot::Toy.new}

    it "should return toy if it is placed" do
      allow(table).to receive(:items).and_return([toy])
      expect(table.find_item(toy)).to eq(toy)
    end

    it "should return nil if it is placed" do
      allow(table).to receive(:items).and_return([])
      expect(table.find_item(toy)).to be_nil
    end
  end

  describe ".take" do

    let(:toy) {Robot::Toy.new}

    it "remove item from table" do
      table.place(toy)
      expect{
        table.take(toy)
      }.to change(table, :items).from([toy]).to([])
      expect(toy.coordinates).to eq([nil, nil])
    end

    it "don't change change toy if is not placed" do
      expect(toy).to_not receive(:remove_coordinates)
      table.take(toy)
    end
  end
end