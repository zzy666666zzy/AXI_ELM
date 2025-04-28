function y = sigmoid(x)
    try
        y = 1 / (1 + exp(-x));
    catch
        y = 0; % Handle potential overflow/underflow
    end
end