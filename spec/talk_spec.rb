require 'talk'

RSpec.describe Talk do
  it "creates a new one" do
    desc = "HURRGATAR"
    length = 30
    talk = Talk.new(desc, length)

    expect(talk.desc).to eq(desc)
    expect(talk.length).to eq(length)
  end
  it "creates a new one with parsable string" do
    desc = "HURRGATAR"
    length = 30
    talk = Talk.parse_new("#{desc} #{length}min")

    expect(talk.desc).to eq(desc)
    expect(talk.length).to eq(length)
  end
end
