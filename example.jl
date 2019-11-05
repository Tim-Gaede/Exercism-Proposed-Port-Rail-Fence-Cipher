function encode(message::String, numRails::Int)
    encoded = ""
    for rail_num = 1 : numRails
        if rail_num ≤ length(message)
            encoded *= message[rail_num]
        end
        limit_reached = false
        peak_num = 1
        while !limit_reached
            # index for left side of peak
            iₗ = 2*(numRails-1)*peak_num + 1 - (rail_num - 1)
            if iₗ ≤ length(message)
                if iₗ != numRails
                    encoded *= message[iₗ]
                end

                if rail_num != 1  &&  rail_num != numRails
                    # index for right side of peak
                    iᵣ= 2*(numRails-1)*peak_num + 1 + (rail_num - 1)
                    if iᵣ ≤ length(message)
                        encoded *= message[iᵣ]
                    else
                        limit_reached = true
                    end
                end

            else
                limit_reached = true
            end

            peak_num += 1
        end
    end

    encoded
end




function decode(message_encoded::String, numRails::Int)
    if numRails < 2
        msg = "The argument, \"numRails\" for the function, decrypt(), " +
              "must be at least 2"
        throw(Exception(msg))
    end

    nChars_in_rail = numChars_per_rail(message_encoded, numRails)



    # Set up local indices for the rails
    indicesLocal_for_rails = []
    start = 1
    for r = 1 : numRails
        indicesLocal_for_rail = []
        for i = start : start + nChars_in_rail[r] - 1
            push!(indicesLocal_for_rail, i)
        end

        push!(indicesLocal_for_rails, indicesLocal_for_rail)
        start += nChars_in_rail[r]
    end

    railNum = 1
    railNum_incr = 1 # incrementing by 1 when going down
    iLocal_last = [] # last used local index
    for i = 1 : numRails
        push!(iLocal_last, 0)
    end

    decrypted = message_encoded[1]
    iLocal_last[1] = 1
    for n = 2 : length(message_encoded)
        railNum += railNum_incr
        if railNum == numRails
            # reached a trough
            railNum_incr = -1 # now go up
        elseif railNum == 1
            # reached a peak
            railNum_incr = 1 # now go down
        end

        i_local = iLocal_last[railNum] + 1
        decrypted *= message_encoded[indicesLocal_for_rails[railNum][i_local]]
        iLocal_last[railNum] = i_local
    end


    decrypted
end





function numChars_per_rail(message_encoded::String, numRails::Int)
    if length(message_encoded) < 1
        throw(Exception("message_encoded is empty"))
    end


    if numRails == 1;    return [length(message_encoded)];    end



    numChars_in_rails = []
    for i = 1 : numRails
        push!(numChars_in_rails, 0)
    end

    railNum = 1
    railNum_incr = 1
    for charNum = 1 : length(message_encoded)
        numChars_in_rails[railNum] += 1
        railNum += railNum_incr
        if railNum == numRails
            # reached a trough
            railNum_incr = -1 # now go up
        elseif railNum == 1
            # reached a peak
            railNum_incr = 1 # now go down
        end
    end


    numChars_in_rails
end
