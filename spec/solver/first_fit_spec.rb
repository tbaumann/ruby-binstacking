require 'solver/first_fit'
require 'session'

RSpec.describe Solver::FirstFit do
  it 'creates a new one' do
    expect(described_class.new()).to be_a described_class
  end
  it 'can solve' do
    input = []
    sessions = []
    10.times do |i|
      input.push(double("Talk #{i}", desc: "talk no #{i}", length: 30))
    end
    input.push(double("Biggest Talk", desc: "Biggest talk", length: 60))
    4.times do
      sessions.push(Session.new(60*3))
    end

    solver = Solver::FirstFit.new
    solver.input = input
    solver.sessions = sessions

    # Define sorting algorythm
    solver.sort_by do |a, b|
      b.length <=> a.length
    end

    # Finally try to solve it
    solver.solve

    #pretty trivial test if all talks are accounted for
    expect(solver.sessions.reduce(0){|sum, session| sum += session.minutes}).to eq(360)
  end

  it 'can recognise unsolvable' do
    input = []
    sessions = []
    10.times do |i|
      input.push(double("Talk #{i}", desc: "talk no #{i}", length: 30))
    end
    input.push(double("Biggest Talk", desc: "Biggest talk", length: 61))
    2.times do
      sessions.push(Session.new(60*3))
    end

    solver = Solver::FirstFit.new
    solver.input = input
    solver.sessions = sessions

    # Define sorting algorythm
    solver.sort_by do |a, b|
      b.length <=> a.length
    end

    # Finally try to solve it
    expect{solver.solve}.to raise_error(NotEnoughTimeInSessionError)
  end
end
