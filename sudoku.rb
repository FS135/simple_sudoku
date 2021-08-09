require "byebug"
class Sudoku

  attr_reader :num_arr

  DEMO_SUDOKU = "530070000600195000098000060800060003400803001700020006060000280000419005000080079"
  TOP_OFFSET = "\n" * 2
  LEFT_OFFSET = " " * 6

  def self.load_sudoku(str=DEMO_SUDOKU)
    arr = [[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]],[[],[],[]]]
    (0..8).each do |x|
      (0..2).each do |y|
        (0..2).each do |z|
          if str[ x * 9 + y * 3 + z ] == "0"
            arr[x][y][z] = " "
          else
            arr[x][y][z] = str[ x * 9 + y * 3 + z ].to_i
          end
        end
      end
    end
    arr
  end

  def initialize
    @num_arr = Sudoku.load_sudoku
  end

  def draw
    puts TOP_OFFSET
    @num_arr.each_with_index do |ele,idx|
      puts LEFT_OFFSET+" #{ele[0][0]} | #{ele[0][1]} | #{ele[0][2]} || #{ele[1][0]} | #{ele[1][1]} | #{ele[1][2]} || #{ele[2][0]} | #{ele[2][1]} | #{ele[2][2]} "
      if (idx + 1) % 3 != 0
        puts LEFT_OFFSET + "---+---+---||---+---+---||---+---+---"
      elsif idx == 2
        puts LEFT_OFFSET + "========================||==========="
      elsif idx == 5
        puts LEFT_OFFSET + "===========||========================"
      end
    end
  end

  def num_in_line?(num, pos)
    if @num_arr[pos[0]].flatten.include?(num)
      return true
    end
    false
  end

  def num_in_col?(num, pos)
    (0..8).each do |x|
      if @num_arr[x].flatten[pos[1]] == num
        return true
      end
    end
    false
  end

  def num_in_field?(num, pos)
    f_start = pos[0] / 3 * 3
    f_end = f_start + 2
    (f_start..f_end).each { |i| return true if @num_arr[i][pos[1]/3].include?(num) }
    false
  end

  def try_num(num, pos)
    pos_i = [pos[0] - 1, pos[1] - 1]
    return "num in line!" if num_in_line?(num,pos_i)
    return "num in column!" if num_in_col?(num,pos_i)
    return "num in field!" if num_in_field?(num,pos_i)
    @num_arr[pos_i[0]][pos_i[1]/3][pos_i[1]%3] = num
    true
  end

end
