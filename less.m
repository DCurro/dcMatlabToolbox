function less( string )
    STRIDE_LENGTH = 1000;

    i=1;
    textEnd = length(string(:));
    while i<textEnd
        subtextStart = i;
        subtextEnd = i+STRIDE_LENGTH; 

        if subtextEnd>=textEnd
            display(string(subtextStart:end));
        else
            display(string(subtextStart:subtextEnd));
            pause
        end

        i = i+STRIDE_LENGTH;
    end
end

