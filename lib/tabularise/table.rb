module Tabularise
  class Table
    def add_line(*args)
      table << args
    end

    def dump
      dims = dimensions
      str = ""
      str << top_line(dims)
      table.each_with_index do |row, index|
        str << pad_line(dims, row, "|", " ")
        str << top_line(dims) if(0 == index)
      end
      str << top_line(dims)
    end

    private

    def top_line(dims)
      pad_line(dims, [], "+", "-")
    end

    def pad_line(dims, row, stopping_char, padding_char)
      str = ""
      dims.each_with_index do |width, index|
        str << stopping_char << padding_char
        item = row[index].to_s
        if(row[index].is_a?(Numeric))
          str << (padding_char * (width - item.length))
          str << item
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
      table.max_by{|row| row[index].to_s.length}[index].to_s.length
    end

    def table
      @table_array ||= []
    end
  end
end
