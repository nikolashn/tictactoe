
{ { 0 0 0 } { 0 0 0 } { 0 0 0 } } dup
len -> length
-> board

1 -> user
1 -> count

"type `quit` to quit." print

for true do
    if count 2 % 0 == do
        1 -> user
    else
        2 -> user
    end

    # print tic tac toe board
    "-------------" print
    0 for dup length < do -> i
        board i read -> board_2
        board_2 len -> board_2_length
        "| " puts
        0 for dup board_2_length < do
            -> n
            board_2 n read
            if dup 0 == do
                " " puts
            elif dup 1 == do
                "×" puts
            elif dup 2 == do
                "◯" puts
            end drop
            " | " puts
            n inc
        end drop
        "" print
        "-------------" print
        i inc
    end drop

    
    0 for dup 3 < do -> p
        board 0 read p read -> X
        board 1 read p read -> Y
        board 2 read p read -> Z
        if X 0 != do
            if X Y == X Z == && do
                if X 2 == do
                    "◯" -> player
                else
                    "×" -> player
                end
                "player " puts player puts " won!" print
                exit
            end
        end
        p inc
    end drop

    
    0 for dup 3 < do -> p
        board p read dup dup
        0 read -> X
        1 read -> Y
        2 read -> Z
        if X 0 != do
            if X Y == X Z == && do
                if X 2 == do
                    "◯" -> player
                else
                    "×" -> player
                end
                "player " puts player puts " won!" print
                exit
            end
        end
        p inc
    end drop

    board 0 read -> first_row
    board 1 read -> second_row
    board 2 read -> third_row
    first_row 0 read -> X
    second_row 1 read -> Y
    third_row 2 read -> Z
    if X 0 != do
        if X Y == X Z == && do
            if X 2 == do
                "◯" -> player
            else
                "×" -> player
            end
            "player " puts player puts " won!" print
            exit
        end
    end

    first_row 2 read -> X
    second_row 1 read -> Y
    third_row 0 read -> Z
    if X 0 != do
        if X Y == X Z == && do
            if X 2 == do
                "◯" -> player
            else
                "×" -> player
            end
            "player " puts player puts " won!" print
            exit
        end
    end

    if user 2 == do
        "player ○ turn >> " puts
    else
        "player × turn >> " puts
    end
    input -> input_value
    if input_value "quit" == do
        break
    elif input_value { "A" "B" "C" } in do
        board 0 read -> replaced_board
        if input_value "A" == do
            replaced_board user 0 replace
        elif input_value "B" == do
            replaced_board user 1 replace
        elif input_value "C" == do
            replaced_board user 2 replace
        end
        board replaced_board 0 replace -> board
    elif input_value { "D" "E" "F" } in do
        board 1 read -> replaced_board
        if input_value "D" == do
            replaced_board user 0 replace
        elif input_value "E" == do
            replaced_board user 1 replace
        elif input_value "F" == do
            replaced_board user 2 replace
        end
        board replaced_board 1 replace -> board
    elif input_value { "G" "H" "I" } in do
        board 2 read -> replaced_board
        if input_value "G" == do
            replaced_board user 0 replace
        elif input_value "H" == do
            replaced_board user 1 replace
        elif input_value "I" == do
            replaced_board user 2 replace
        end
        board replaced_board 2 replace -> board
    else
        false assert "unreachable"
    end
    
    count inc -> count
end


