# frozen_string_literal: true

RSpec.describe Gamefic::Overlookable do
  let(:plot) {
    klass = Class.new(Gamefic::Plot) do
      include Gamefic::Standard

      seed do
        @room = make Room, name: 'room', description: 'A room with four walls and a ceiling.'
        @room.overlook 'ceiling', ['walls', 'four']
      end

      introduction do |actor|
        actor.parent = @room
      end
    end

    klass.new
  }

  it 'has a version number' do
    expect(Gamefic::Overlookable::VERSION).not_to be nil
  end

  it 'provides a default implementation' do
    actor = plot.introduce
    actor.perform 'look walls'
    expect(actor.messages).to include("There's nothing special about the walls.")
    actor.perform 'look ceiling'
    expect(actor.messages).to include("There's nothing special about the ceiling.")
  end
end
