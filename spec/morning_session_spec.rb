require 'session'
require 'morning_session'

RSpec.describe MorningSession do
  it 'creates a new one' do
    expect(described_class.new(120)).to be_a described_class
  end
  it 'can fit exactly the right length of talks' do
    session = described_class.new(120)
    3.times do |i|
      session.push(double("Talk #{i}", desc: "talk no #{i}", length: 30))
    end
    expect(session.minutes).to eq(90)
    expect(session.can_fit?(double("Final Talk", desc: "Final talk", length: 30))).to be true
    expect(session.can_fit?(double("Final Talk", desc: "Final talk", length: 31))).to be false
    expect(session.talks.length).to eq(3)
  end
end
