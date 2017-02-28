require 'spec_helper'

describe Tabularise::Table do
  describe '#dump' do
    it 'renders a table' do
      subject.add_line('Object', 'Count')
      subject.add_line('String', 101)
      subject.add_line('Array', 99)

      expected = [
        '+--------+-------+',
        '| Object | Count |',
        '+--------+-------+',
        '| String |   101 |',
        '| Array  |    99 |',
        '+--------+-------+',
        ''
      ].join("\n")

      expect(subject.dump).to eq expected
    end
  end
end
