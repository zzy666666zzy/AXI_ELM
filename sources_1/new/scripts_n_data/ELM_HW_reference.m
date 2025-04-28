clear;clc;

%input input and weight
dataWidth = 12;
inputIntSize = 4;

n_input = 128;
n_hidden = 50;
n_output = 2;

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
    0.931598    0.982759    0.903271    0.785641    0.949432    0.738309    0.678115    0.324974 ...
    0.906316    0.919106    0.981669    0.559828    0.725367    0.820215    0.459912    0.487328 ...
    0.948719    0.724335    0.902154    0.356256    0.99562    0.806524    0.694254    0.078928 ...
    0.936157    0.928043    0.938627    0.173561    0.896227    0.559542    0.358123    0.040464 ...
    0.849303    0.658467    0.234877    0.796287    0.927803    0.121024    0.329928    0.023710 ...
    0.302515    0.394472    0.930416    0.658771    0.739281    0.233168    0.839137    0.206902 ...
    0.777526    0.535407    0.030888    0.276278    0.941741    0.874676    0.290003    0.097957 ...
    0.777526    0.535407    0.030888    0.276278    0.941741    0.874676    0.290003    0.097957 ...
];


input_fixed = arrayfun(@(x) DtoB(x, dataWidth, dataWidth-inputIntSize), input, 'UniformOutput', false);
fileID = fopen('./input.mif', 'w');

% Write input_fixed values to file
for i = 1:length(input_fixed)
    fprintf(fileID, '%s\n', input_fixed{i});
end


rng(42);  % Ensure reproducibility
IW = rand(n_hidden, n_input) * 2 - 1;
Bias = rand(1, n_hidden) * 2 - 1;
OW = rand(n_hidden, n_output) * 2 - 1;

fracBits = dataWidth - inputIntSize;

%% Save IW (each hidden neuron's input weights into its own .coe file)
for h = 1:n_hidden
    w_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), IW(h, :), 'UniformOutput', false);
    fileID = fopen(sprintf('./Weight_mem_1_%d.coe', h-1), 'w');
    fprintf(fileID, 'memory_initialization_radix=2;\n');
    fprintf(fileID, 'memory_initialization_vector=\n');
    for i = 1:length(w_bin)
        if i < length(w_bin)
            fprintf(fileID, '%s,\n', w_bin{i});
        else
            fprintf(fileID, '%s;\n', w_bin{i}); 
        end
    end
    fclose(fileID);
end

Bias_bin = cell(1, n_hidden); 

for h = 1:n_hidden
    b_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), Bias(h), 'UniformOutput', false); 
    Bias_bin{h} = b_bin;
end

%% Optionally: Save OW (weights from hidden to output layer) into one file per output neuron
for o = 1:n_output
    ow_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), OW(:, o), 'UniformOutput', false);
    fileID = fopen(sprintf('./Weight_mem_2_%d.coe', o-1), 'w');
    fprintf(fileID, 'memory_initialization_radix=2;\n');
    fprintf(fileID, 'memory_initialization_vector=\n');
    for i = 1:length(ow_bin)
        if i < length(ow_bin)
            fprintf(fileID, '%s,\n', ow_bin{i});
        else
            fprintf(fileID, '%s;\n', ow_bin{i});
        end
    end
    fclose(fileID);
end

disp('Weight_mem_1_*.coe and Weight_mem_2_*.coe files generated.');

sigmoid = @(x) 1 ./ (1 + exp(-x));

input = reshape(input, 1, []);

H = sigmoid(input * IW' + Bias);  

output = H * OW; 

disp('Final ELM Inference Output:');
disp(output);

