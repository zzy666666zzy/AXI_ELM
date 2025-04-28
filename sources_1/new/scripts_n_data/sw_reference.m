clear;clc;

%input input and weight
dataWidth = 12;
inputIntSize = 4;

%LUT output
dataWidth_LUT = 12;
inputIntSize_LUT = 4;

input = [
    0.931598    0.982759    0.903271    0.785641    0.949432    0.738309    0.678115    0.324974 ...
    0.906316    0.919106    0.981669    0.559828    0.725367    0.820215    0.459912    0.487328 ...
    0.948719    0.724335    0.902154    0.356256    0.99562    0.806524    0.694254    0.078928 ...
    0.936157    0.928043    0.938627    0.173561    0.896227    0.559542    0.358123    0.040464 ...
    0.849303    0.658467    0.234877    0.796287    0.927803    0.121024    0.329928    0.023710 ...
    0.302515    0.394472    0.930416    0.658771    0.739281    0.233168    0.839137    0.206902 ...
    0.777526    0.535407    0.030888    0.276278    0.941741    0.874676    0.290003    0.097957 ...
    0.777526    0.535407    0.030888    0.276278    0.941741    0.874676    0.290003    0.097957 ...
];

weight = [
    0.173344    0.168214    0.115318   0.144231   0.195740    0.143765   0.187678   -0.765288 ...
    0.122526   0.105331   0.171914    0.417806    0.222169   0.330043   0.204965    0.245926 ...
   0.510044    0.869129    0.053955   -0.432361   -0.694671   -0.352143   -0.551279    0.781937 ...
    0.907211   -0.574930    0.366741   -0.530309   -0.032558    0.687112   -0.762158   -0.311347 ...
    0.547747    0.551525   -0.268523   -0.312913   -0.470157    0.551122   -0.157918    0.219029 ...
   -0.300337   -0.148318    0.758417   -0.679144   -0.177320    0.149646   -0.274052    0.685515 ...
    0.436341   -0.141755   -0.991056   -0.817943   -0.048607    0.232818   -0.510545   -0.767847 ...
    0.436341   -0.141755   -0.991056   -0.817943   -0.048607    0.232818   -0.510545   -0.767847 ...
];

bias = 1.133;

input_fixed = arrayfun(@(x) DtoB(x, dataWidth, dataWidth-inputIntSize), input, 'UniformOutput', false);
weight_fixed = arrayfun(@(x) DtoB(x, dataWidth, dataWidth-inputIntSize), weight, 'UniformOutput', false);
bias_fixed = arrayfun(@(x) DtoB(x, dataWidth, dataWidth-inputIntSize), bias, 'UniformOutput', false);

fileID = fopen('./input.mif', 'w');

% Write input_fixed values to file
for i = 1:length(input_fixed)
    fprintf(fileID, '%s\n', input_fixed{i});
end

fileID1 = fopen('./weight.mif', 'w');
% Write weight_fixed values to file
for i = 1:length(weight_fixed)
    fprintf(fileID1, '%s\n', weight_fixed{i});
end

fileID2 = fopen('./weight.coe', 'w');
fprintf(fileID2, 'memory_initialization_radix=2;\n');
fprintf(fileID2, 'memory_initialization_vector=\n');
% Write weight_fixed values to file
for i = 1:length(weight_fixed)
    if i < length(weight_fixed)
        fprintf(fileID2, '%s,\n', weight_fixed{i});  % add comma
    else
        fprintf(fileID2, '%s;\n', weight_fixed{i});  % semicolon at last line
    end
end

% Close file
fclose(fileID);
fclose(fileID1);
fclose(fileID2);

disp('File saved as fixed_point_values.txt');

result = sum(input .* weight) + bias;

sigmoid_result = sigmoid(result);

for i = 1:64
    mac_result = input(i) * weight(i); % Multiply-Accumulate (MAC) operation
    
    if i == 1
        mac_result_list(i) = mac_result; % First element initialization
    else
        mac_result_list(i) = mac_result + mac_result_list(i-1); % Cumulative sum
    end
    x = mac_result_list(i);
    each_sigmoid_result(i) = 1 / (1 + exp(-x)); % Apply sigmoid
end

%%
fid = fopen('./output_LU_FPGA.txt', 'r');
if fid == -1
    error('Error opening file: %s', filename);
end

% Initialize cell array to store results temporarily
decimal_values = [];

% Read file line by line
while ~feof(fid)
    bin_str = fgetl(fid); % Read a line (binary string)
    if ischar(bin_str) && ~isempty(bin_str)
        % Convert binary string to fixed-point decimal
        int_value = bin2dec(bin_str); % Convert binary to integer
        total_bits = inputIntSize_LUT + (dataWidth_LUT-inputIntSize_LUT) + 1; % 1 sign bit
        
        % Check sign bit (MSB)
        if bin_str(1) == '1' % Negative number (two's complement)
            int_value = int_value - 2^total_bits;
        end

        % Scale by 2^num_frac to get fixed-point value
        decimal_value = int_value / (2^(dataWidth_LUT-inputIntSize_LUT));
        
        % Store the result in an array
        decimal_values = [decimal_values; decimal_value]; %#ok<AGROW>
    end
end

% Close the file
fclose(fid);

errors = abs(decimal_values' - each_sigmoid_result(1:59));

% Compute max and mean error
max_error = max(errors);
mean_error = mean(errors);


