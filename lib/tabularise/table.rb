module Tabularise
  class Table
    attr_reader :footer

    def initialize(options={})
      @footer = options[:footer]
    end

    def add_line(*args)
      table << args
    end

    def dump
      dims = dimensions
      str = ""
      str << top_line(dims)
      table.each_with_index do |row, index|
        str << top_line(dims) if footer && (index == (table.length - 1))
        str << pad_line(dims, row, "|", " ")
        str << top_line(dims) if(0 == index)
      end
      str << top_line(dims)
    end

    private

    def top_line(dims)
      pad_line(dims, [], "+", "-")
    end

    def delimited(num)
      num.to_s.reverse.gsub(/...(?=.)/,'\&,').reverse
    end

    def pad_line(dims, row, stopping_char, padding_char)
      str = ""
      dims.each_with_index do |width, index|
        str << stopping_char << padding_char
        item = row[index].to_s
        if(row[index].is_a?(Numeric))
          item_s = delimited(item)
          str << (padding_char * (width - item_s.length))
          str << item_s
          str << padding_char
        else
          str << item
          str << (padding_char * (width - item.length))
          str << padding_char
        end
      end
      str << stopping_char << "\n"
    end

    def dimensions
      (0...column_count).collect{|index| column_width(index)}
    end

    def column_count
      table.max_by(&:length).length
    end

    def column_width(index)
      table.max_by do |row|
        if row[index].is_a?(Numeric)
          delimited(row[index]).length
        else
          row[index].to_s.length
        end
      end[index].to_s.length
    end

    def table
      @table_array ||= []
    end
  end
end
