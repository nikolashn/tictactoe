
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
            "player " print player print " won!\n" print
            exit
        end
    end
end

block check_win do
    0 for dup 3 < do -> i
        board 0 read i read
        board 1 read i read
        board 2 read i read
        check_x_y_z
        i inc
    end drop
    
    0 for dup 3 < do -> i
        board i read 0 read
        board i read 1 read
        board i read 2 read
        check_x_y_z
        i inc
    end drop

    board 0 read -> row1
    board 1 read -> row2
    board 2 read -> row3
    row1 0 read
    row2 1 read
    row3 2 read
    check_x_y_z

    row1 2 read
    row2 1 read
    row3 0 read
    check_x_y_z
end

block print_board do
    "-------------\n" print
    0 for dup board_length < do -> i
        board i read -> board_2
        board_2 len -> board_2_length
        "| " print
        0 for dup board_2_length < do -> n
            board_2 n read
            if dup 0 == do
                " " print
            elif dup 1 == do
                "X" print
            elif dup 2 == do
                "O" print
            end drop
            " | " print
            n inc
        end drop
        "\n" print
        "-------------\n" print
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
    init_board
    for true do
        if count 2 % 0 == do
            1 -> player
        else
            2 -> player
        end

        print_board

        check_win

        input -> input_value
        "\033[2K\033[1A\033[2K\n" print
        for true do
            if input_value "quit" == do
                exit
            end
            
            if input_value { "A" "B" "C" } in do
                0 -> row
            elif input_value { "D" "E" "F" } in do
                1 -> row
            elif input_value { "G" "H" "I" } in do
                2 -> row
            else
                "unreachable\r\033[1A" print
                input -> input_value
                "\033[2K\033[1A\033[2K\n" print
                break
            end

            if input_value { "A" "D" "G" } in do
                0 -> index
            elif input_value { "B" "E" "H" } in do
                1 -> index
            elif input_value { "C" "F" "I" } in do
                2 -> index
            end

            board row read -> replaced_board
            if index row invalid do
                "invalid board index" print
                break
            end

            replaced_board player index replace
            count inc -> count
            break
        end
        "\r\033[8A" print
    end
end

main

