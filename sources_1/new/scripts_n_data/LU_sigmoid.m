function quant = LU_sigmoid(input)
    M = 9;
    index = 0:(2^M - 1);
    qvalue = 0.5 + (index + 0.5) / (2^(M + 1));
    boundary = -log((2^(M + 1)) ./ ((2^M) + index(2:end)) - 1);

    [row, col] = size(input);
    input_flat = input(:); % More compact flattening

    quant = zeros(size(input_flat)); % Preallocate for efficiency

    for i = 1:numel(input_flat)
        if input_flat(i) <= 0
            [~, quant(i)] = quantiz(input_flat(i), boundary, qvalue);
            quant(i) = 1 - quant(i);
        else
            [~, quant(i)] = quantiz(input_flat(i), boundary, qvalue); % Corrected: input_flat(i)
        end
    end

    quant = reshape(quant, row, col);
end