clear all;
clc;

M = 12;

dataWidth = 12;
inputIntSize = 3;

dataWidth_LUT = 13;
inputIntSize_LUT = 3;

index = 0:1:((2^M)-1);
boundary_list = [];
address_list = [];

input = 8 * rand(1, 100); 
input_fixed = arrayfun(@(x) DtoB(x, dataWidth, dataWidth-inputIntSize), input, 'UniformOutput', false);

input_decimal = cellfun(@(x) bin2dec(x), input_fixed);  % Convert each binary string to decimal

for j = 2:1:size(index,2)
    boundary(j-1)= -log((2^(M+1))/((2^M)+index(j))-1);
    boundary_ele = DtoB(boundary(j-1), dataWidth, dataWidth - inputIntSize);
    boundary_list = [boundary_list,bin2dec(boundary_ele)];
    address = DtoB(j-1, dataWidth, 0);
    address_list = [address_list,bin2dec(address)];
end

[found, idx] = ismember(address_list', boundary_list');

for i = 2:length(idx)
    if idx(i) == 0
        idx(i) = idx(i-1); % Assign previous non-zero value
    end
end

LU_LUT = {};  % Initialize LU_LUT cell array

% Calculate final_LUT and convert to binary using DtoB
final_LUT = 0.5 + (index(idx) + 0.5) / (2^(M+1));

% Populate LU_LUT with binary representations for each value in final_LUT
for j = 1:numel(final_LUT)
    LU_LUT{j} = DtoB(final_LUT(j), dataWidth_LUT, dataWidth_LUT - inputIntSize_LUT);
end

% Initialize decimal_values to store the result
final_LUT_decimal = [];

% Iterate through each element of LU_LUT
for i = 1:length(LU_LUT)
    bin_str = LU_LUT{i};  % Get the binary string from LU_LUT cell array
    
    % Check if the binary string is non-empty
    if ischar(bin_str) && ~isempty(bin_str)
        % Convert binary string to integer (fixed-point)
        int_value = bin2dec(bin_str);  % Convert binary to integer
        total_bits = inputIntSize_LUT + (dataWidth_LUT - inputIntSize_LUT) + 1;  % Include sign bit
        
        % Check the sign bit (MSB) for two's complement representation
        if bin_str(1) == '1'  % Negative number
            int_value = int_value - 2^total_bits;
        end
        
        % Scale by 2^(number of fractional bits) to get fixed-point value
        fractional_bits = dataWidth_LUT - inputIntSize_LUT;
        decimal_value = int_value / (2^fractional_bits);  % Convert to fixed-point
        
        % Store the result in decimal_values
        final_LUT_decimal = [final_LUT_decimal; decimal_value]; %#ok<AGROW>
    end
end

fetched_values = final_LUT_decimal(input_decimal);  % Use input_decimal as addresses

sigmoid_values = 1 ./ (1 + exp(-input));

mae = mean(abs(sigmoid_values' - fetched_values));

% Calculate the Maximum Error (Max Error)
max_error = max(abs(sigmoid_values' - fetched_values));

% Display the results
disp(['Maximum Error: ', num2str(max_error)]);
disp(['Mean Absolute Error (MAE): ', num2str(mae)]);