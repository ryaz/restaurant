require 'spec_helper'

describe Reservation do
  it { should validate_presence_of(:table_id) }
  it { should validate_presence_of(:start_time) }
  it { should validate_presence_of(:end_time) }
  it { should validate_numericality_of(:table_id).is_greater_than_or_equal_to(1) }
  
  subject do
    build(:reservation, start_time: "2010-01-01 18:00:00", end_time: "2010-01-01 19:00:00")
  end

  context 'with reservation ending after current reservation starts' do
    before do
      create(:reservation, start_time: "2010-01-01 17:30:00", end_time: "2010-01-01 18:30:00")
    end
    it { should_not be_valid }
  end

  context 'with reservation ending at the same time the current reservation starts' do
    before do
      create(:reservation, start_time: "2010-01-01 17:30:00", end_time: "2010-01-01 18:00:00")
    end
    it { should_not be_valid }
  end

  context 'with reservation starting before current reservation ends' do
    before do
      create(:reservation, start_time: "2010-01-01 18:30:00", end_time: "2010-01-01 19:30:00")
    end
    it { should_not be_valid }
  end

  context 'with reservation starting at the same time the current reservation ends' do
    before do
      create(:reservation, start_time: "2010-01-01 19:00:00", end_time: "2010-01-01 20:00:00")
    end
    it { should_not be_valid }
  end

  context 'with reservation starting before and ending after the current reservation' do
    before do
      create(:reservation, start_time: "2010-01-01 17:00:00", end_time: "2010-01-01 20:00:00")
    end
    it { should_not be_valid }
  end

  context 'with reservation starting and ending at the same time as the current reservation' do
    before do
      create(:reservation, start_time: "2010-01-01 18:00:00", end_time: "2010-01-01 19:00:00")
    end
    it { should_not be_valid }
  end

  context 'without reservation overlapping' do
    before do
      create(:reservation, start_time: "2010-01-01 15:00:00", end_time: "2010-01-01 17:00:00")
      create(:reservation, start_time: "2010-01-01 20:00:00", end_time: "2010-01-01 21:00:00")
    end
    it { should be_valid }
  end

  it "validates reservation ends after it starts" do
    reservation = build(:reservation, start_time: "2010-01-01 21:00:00", end_time: "2010-01-01 20:00:00")
    reservation.should_not be_valid
  end
end
