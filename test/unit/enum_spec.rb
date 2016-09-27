require_relative '../../lib/enum.rb'

RSpec.describe Enum do
  describe Enum::Color do
    Color = Enum::Color

    it 'defines BLUE' do
      expect(Color::BLUE).to eq('blue')
    end

    it 'defines BROWN' do
      expect(Color::BROWN).to eq('brown')
    end

    it 'defines GREEN' do
      expect(Color::GREEN).to eq('green')
    end

    it 'defines ORANGE' do
      expect(Color::ORANGE).to eq('orange')
    end

    it 'defines PURPLE' do
      expect(Color::PURPLE).to eq('purple')
    end

    it 'defines RED' do
      expect(Color::RED).to eq('red')
    end

    it 'defines TEAL' do
      expect(Color::TEAL).to eq('teal')
    end

    it 'defines WHITE' do
      expect(Color::WHITE).to eq('white')
    end

    it 'defines YELLOW' do
      expect(Color::YELLOW).to eq('yellow')
    end

    it 'defines NONE' do
      expect(Color::NONE).to equal(nil)
    end
  end

  describe Enum::Icon do
    Icon = Enum::Icon

    it 'defines THUMBS_UP' do
      expect(Icon::THUMBS_UP).to eq('thumbs-up')
    end

    it 'defines CALENDAR' do
      expect(Icon::CALENDAR).to eq('calendar')
    end

    it 'defines SERVER' do
      expect(Icon::SERVER).to eq('server')
    end

    it 'defines SIGNAL' do
      expect(Icon::SIGNAL).to eq('wifi')
    end

    it 'defines GIT' do
      expect(Icon::GIT).to eq('git')
    end

    it 'defines CODE' do
      expect(Icon::CODE).to eq('code')
    end

    it 'defines CHECK' do
      expect(Icon::CHECK).to eq('check')
    end

    it 'defines ERROR' do
      expect(Icon::ERROR).to eq('exclamation-triangle')
    end

    it 'defines PENCIL' do
      expect(Icon::PENCIL).to eq('pencil')
    end

    it 'defines CHAIN' do
      expect(Icon::CHAIN).to eq('chain')
    end

    it 'defines CHAIN_BROKEN' do
      expect(Icon::CHAIN_BROKEN).to eq('chain-broken')
    end

    it 'defines NONE' do
      expect(Icon::NONE).to equal(nil)
    end
  end

  describe Enum::Strategy do
    Strategy = Enum::Strategy

    it 'defines FALLBACK' do
      expect(Strategy::FALLBACK).to eq(:fallback)
    end

    it 'defines ID' do
      expect(Strategy::ID).to eq(:id)
    end
  end
end
