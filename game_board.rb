class GameBoard
    # @max_row is an `Integer`
    # @max_column is an `Integer`
    attr_reader :max_row, :max_column

    def initialize(max_row, max_column)
        @max_row = max_row
        @max_column = max_column
        @num_successful_attacks_var = 0
        @the_game_board = Array.new(max_row) {Array.new(max_column, 0)}
    end

    # adds a Ship object to the GameBoard
    # returns Boolean
    # Returns true on successfully added the ship, false otherwise
    # Note that Position pair starts from 1 to max_row/max_column
    def add_ship(ship)

        new_positions = Array.new
        counter = 0

        while counter != ship.size

            new_pos = nil

            if ship.orientation == "Up"

                new_pos = Position.new(ship.start_position.row - counter - 1, ship.start_position.column - 1)

            elsif ship.orientation == "Down"

                new_pos = Position.new(ship.start_position.row + counter - 1, ship.start_position.column - 1)

            elsif ship.orientation == "Left"

                new_pos = Position.new(ship.start_position.row - 1, ship.start_position.column - counter - 1)

            elsif ship.orientation == "Right"

                new_pos = Position.new(ship.start_position.row - 1, ship.start_position.column + counter - 1)

            end

            if new_pos.row < max_row && new_pos.column < max_column && new_pos.row >= 0 && new_pos.column >= 0

                new_positions.push new_pos

            else

                return false

            end

            counter += 1

        end

        new_positions.each { |pos|

            if @the_game_board[pos.row][pos.column] != 0

                return false

            end

        }

        new_positions.each { |pause|

            @the_game_board[pause.row][pause.column] = 1

        }

        true

    end

    # return Boolean on whether attack was successful or not (hit a ship?)
    # return nil if Position is invalid (out of the boundary defined)
    def attack_pos(position)
        # check position

        # update your grid

        # return whether the attack was successful or not
        
        if position.row > max_row || position.column > max_column || position.row < 1 || position.column < 1

            return nil

        end

        if @the_game_board[position.row - 1][position.column - 1] == 1 || @the_game_board[position.row - 1][position.column - 1] == 2

            @the_game_board[position.row - 1][position.column - 1] = 2
            true

        elsif @the_game_board[position.row - 1][position.column - 1] == 0

            @the_game_board[position.row - 1][position.column - 1] = -1
            false

        else

            false

        end

    end

    # Number of successful attacks made by the "opponent" on this player GameBoard
    def num_successful_attacks

        count = 0

        @the_game_board.each { |rows|
        
            rows.each { |cols|
            
                if cols == 2

                    count += 1

                end
            
            }
        
        }

        return count

    end

    # returns Boolean
    # returns True if all the ships are sunk.
    # Return false if at least one ship hasn't sunk.
    def all_sunk?
        
        @the_game_board.each { |rows|
        
            rows.each { |cols|
            
                if cols == 1

                    return false

                end
            
            }
        
        }

        true

    end


    # String representation of GameBoard (optional but recommended)
    def to_s

        @the_game_board.each { |rows|

            rows.each { |cols|
            
                puts " "
            
            }
        
        }

    end

end