
# global variables
{ { 0 0 0 } { 0 0 0 } { 0 0 0 } } dup
len -> board_length
-> board
1 -> count

block init_board do
    { { 0 0 0 } { 0 0 0 } { 0 0 0 } } dup
    len -> board_length
    -> board
end

block check_x_y_z do
    -> Z -> Y -> X
    if X 0 != do
        if X Y == X Z == && do
            if X 2 == do
                "O" -> player
            else
                "X" -> player
            end
            "player " puts player puts " won!" print
            exit
        end
    end
end

block check_win do
    0 for dup 3 < do -> i
        board 0 read i read
        board 1 read i read
        board 2 read i read
        call check_x_y_z
        i inc
    end drop
    
    0 for dup 3 < do -> i
        board i read 0 read
        board i read 1 read
        board i read 2 read
        call check_x_y_z
        i inc
    end drop

    board 0 read -> row1
    board 1 read -> row2
    board 2 read -> row3
    row1 0 read
    row2 1 read
    row3 2 read
    call check_x_y_z

    row1 2 read
    row2 1 read
    row3 0 read
    call check_x_y_z
end

block print_board do
    "-------------" print
    0 for dup board_length < do -> i
        board i read -> board_2
        board_2 len -> board_2_length
        "| " puts
        0 for dup board_2_length < do -> n
            board_2 n read
            if dup 0 == do
                " " puts
            elif dup 1 == do
                "X" puts
            elif dup 2 == do
                "O" puts
            end drop
            " | " puts
            n inc
        end drop
        "" print
        "-------------" print
        i inc
    end drop
end

block invalid do
    -> row
    -> index
    board row read -> board_2
    board_2 index read 0 !=
end

block main do
    call init_board
    for true do
        if count 2 % 0 == do
            1 -> player
        else
            2 -> player
        end

        call print_board

        call check_win

        input -> input_value
        if input_value "quit" == do
            break
        elif input_value { "A" "B" "C" } in do
            board 0 read -> replaced_board
            if input_value "A" == do
                if 0 0 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 0 replace
            elif input_value "B" == do
                if 1 0 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 1 replace
            elif input_value "C" == do
                if 2 0 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 2 replace
            end
            board replaced_board 0 replace -> board
        elif input_value { "D" "E" "F" } in do
            board 1 read -> replaced_board
            if input_value "D" == do
                if 0 1 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 0 replace
            elif input_value "E" == do
                if 1 1 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 1 replace
            elif input_value "F" == do
                if 2 1 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 2 replace
            end
            board replaced_board 1 replace -> board
        elif input_value { "G" "H" "I" } in do
            board 2 read -> replaced_board
            if input_value "G" == do
                if 0 2 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 0 replace
            elif input_value "H" == do
                if 1 2 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 1 replace
            elif input_value "I" == do
                if 2 2 call invalid do
                    "invalid board index" print exit
                end
                replaced_board player 2 replace
            end
            board replaced_board 2 replace -> board
        else
            false assert "unreachable"
        end

        count inc -> count
    end
end

call main

