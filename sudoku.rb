require "byebug"
class Sudoku

  attr_reader :num_arr
  attr_accessor :field, :sudoku
  @@field = "default"
  @@sudoku = "default"
  @@top_offset = "\n" * 2
  @@left_offset = " " * 6
  @@highlighting = true
  @@characters = [1,2,3,4,5,6,7,8,9]

  def self.load_sudoku(sudokuname: @@sudoku)
    require_relative "sudokus/" + sudokuname
    sudoku
  end

  def self.load_field(fieldname: @@field)
    require_relative "fields/" + fieldname
    field
  end

  def initialize(sudokuname: @@sudoku, fieldname: @@field)
    puts sudokuname
    puts fieldname
    @sudoku_arr = Sudoku.load_sudoku(sudokuname: sudokuname)
    @field_arr = Sudoku.load_field(fieldname: fieldname)
    @@highlighting ? @highlighted = [5,5] : @highlighted = [nil,nil]
  end

  def update
    puts @@field
    @sudoku_arr = Sudoku.load_sudoku
    @field_arr = Sudoku.load_field
  end

  def draw
    puts @@top_offset
    x = 0
    y = 0
    fieldt = []

    @field_arr.each do |line|
      linet = ""
      line.each_char do |char|
        if char == "&"
          linet += @sudoku_arr[x][y]
          y!=8 ? y+=1 : (y=0 and x+=1)
        else
          linet += char
        end
      end
      fieldt.push(linet)
    end

    fieldt.each { |line| puts line }
  end

  def num_in_line?(num,x,y)
    if @sudoku_arr[x].include?(num)
      return true
    end
    false
  end

  def num_in_col?(num,x,y)
    (0..8).each do |i|
      if @sudoku_arr[i][y] == num
        return true
      end
    end
    false
  end

  def num_in_field?(num,x,y)
    l_start = x / 3 * 3
    l_end = l_start + 2
    n_start = y / 3 * 3
    n_end = n_start + 2
    (l_start..l_end).each { |i| return true if @sudoku_arr[i][n_start..n_end].include?(num) }
    false
  end

  def try_num(num, pos=@highlighted)
    x = pos[0] - 1
    y = pos[1] - 1
    num_in_line = num_in_line?(num,x,y)
    num_in_col = num_in_col?(num,x,y)
    num_in_field = num_in_field?(num,x,y)
    puts "num in line:\t" + num_in_line.to_s
    puts "num in column:\t" + num_in_col.to_s
    puts "num in field:\t" + num_in_field.to_s
    if !num_in_line && !num_in_col && !num_in_field
      @sudoku_arr[x][y] = num
      return "number might be correct"
    end
    "number is wrong"
  end

end
