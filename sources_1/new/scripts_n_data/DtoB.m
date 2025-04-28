function [e] = DtoB(num, dataWidth, fracBits)
    if num >= 0
        num = num * (2^fracBits);
        num = int64(num); % Use int64 to prevent overflow
        e = dec2bin(num, dataWidth); % Specify minimum number of digits
    else
        num = -num;
        num = num * (2^fracBits);
        num = int64(num); % Use int64 to prevent overflow
        if num == 0
            d = 0;
        else
            d = 2^dataWidth - num;
        end
        e = dec2bin(d, dataWidth); % Specify minimum number of digits
    end
end