class Position
    attr_reader :x_coordinate
    attr_reader :y_coordinate

    def initialize(x, y, x_step, y_step)
        @x_coordinate = x
        @y_coordinate = y
        @x_step = x_step
        @y_step = y_step
    end
    def make_step()
        @x_coordinate += @x_step
        @y_coordinate += @y_step
    end
end

def test_slope(x, y, x_step, y_step)

    tree_counter = 0

    # origin of system (0,0) is in top left corner
    position = Position.new(x, y, x_step, y_step)

    line_array = File.readlines('input').map{|line| line.strip}
    line_length = line_array[0].length

    max_y = line_array.length() - 1

    while position.y_coordinate < max_y do
        position.make_step()

        line = line_array[position.y_coordinate]

        normalized_x_coordinate = position.x_coordinate % line_length

        if line[normalized_x_coordinate] == "#"
            tree_counter += 1
        end    

    end

    puts "Slope with parameters x=#{x}, y=#{y}, x_step=#{x_step}, and y_step=#{y_step} contains #{tree_counter} trees."
    return tree_counter

end

tree_counter_1_1 = test_slope(0, 0, 1, 1)
tree_counter_3_1 = test_slope(0, 0, 3, 1)
tree_counter_5_1 = test_slope(0, 0, 5, 1)
tree_counter_7_1 = test_slope(0, 0, 7, 1)
tree_counter_1_2 = test_slope(0, 0, 1, 2)

puts "Multiplied result: #{tree_counter_1_1*tree_counter_3_1*tree_counter_5_1*tree_counter_7_1*tree_counter_1_2}"
