require_relative '../models/game_board'
require_relative '../models/ship'
require_relative '../models/position'
# return a populated GameBoard or nil
# Return nil on any error (validation error or file opening error)
# If 5 valid ships added, return GameBoard; return nil otherwise
def read_ships_file(path)

	if read_file_lines(path)

		board = GameBoard.new 10, 10
		num_ships = 0

		read_file_lines(path) { |line|

			if line =~ /\(([0-9]+),([0-9]+)\), (Up|Down|Left|Right), (\d{1})/ && num_ships < 5

				if ($1).to_i < 11 && ($1).to_i > 0 && ($2).to_i < 11 &&  ($2).to_i > 0 && ($4).to_i > 0 && ($4).to_i < 6

					new_ship = Ship.new(Position.new(($1).to_i, ($2).to_i), $3, ($4).to_i)

					if board.add_ship(new_ship)

						num_ships += 1

                    end

				end

			end

		}

		if num_ships == 5

			return board

		end

	end

	return nil

end

# return Array of Position or nil
# Returns nil on file open error
def read_attacks_file(path)

	if read_file_lines(path)

		positions = Array.new

		read_file_lines(path) { |line|

			if line =~ /([\d+]),(\d+)/

				positions.push(Position.new(($1).to_i, ($2).to_i))

			end

		}

		return positions

	end

	return nil

end

# ===========================================
# =====DON'T modify the following code=======
# ===========================================
# Use this code for reading files
# Pass a code block that would accept a file line
# and does something with it
# Returns True on successfully opening the file
# Returns False if file doesn't exist
def read_file_lines(path)
    return false unless File.exist? path
    if block_given?
        File.open(path).each do |line|
            yield line
        end
    end

    true
end