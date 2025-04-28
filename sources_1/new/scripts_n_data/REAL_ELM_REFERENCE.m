%"Train process"
clear;

rng(0);

read_FPGA = 0;

int_bitw = 4;
data_bitw = 12;
frac_bitw = data_bitw-int_bitw;
sigmoid_depth = 12;

load DCS_training_datasets.mat
OutputNode=2;  
NumberofHiddenNeurons=50;
ActivF='sigmoid'; %lu_sigmoid,sigmoid,sigmoid_lut

fprintf('Training......\n');

train_data=g2_noise_nor;
training_label=[beta,BFi_scaled];
TrainingSample=train_data;
NumberofTrainingData=size(TrainingSample,1);
NumberofInputNeurons=size(TrainingSample,2);
NumberofOutputNeurons=OutputNode;

tic

InputWeight=rand(NumberofHiddenNeurons,NumberofInputNeurons)*2-1;
BiasofHiddenNeurons=rand(NumberofHiddenNeurons,1);

tempH=InputWeight*TrainingSample';

ind=ones(1,NumberofTrainingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);     
tempH=tempH+BiasMatrix;

switch lower(ActivF)
    case {'sig','sigmoid'}
        H = 1 ./ (1 + exp(-tempH));
    case {'lu_sigmoid'}
        H  = LU_sigmoid(tempH);
    case {'sigmoid_lut'}
        table = LUT_sigmoid(sigmoid_depth, int_bitw, int_bitw);
        [row,col] = size(tempH);
        tempH = reshape(tempH, 1, []);
        for i=1:size(tempH,2)
           e = DtoB(tempH(i), data_bitw, frac_bitw);
           if tempH(i)>=0
            addr = bin2dec(e(data_bitw-sigmoid_depth+1:data_bitw));
            if addr == 0
                tempH(i) = 0;
            else
                tempH(i) = table(addr);
            end
           else
            addr = bin2dec(e(data_bitw-sigmoid_depth+1:data_bitw));
            if addr == 0
                tempH(i) = 0;
            else
                tempH(i) = table(addr)*(-1);
            end
           end
        end
    H = reshape(tempH,row,col);
    case {'relu'}
        H = (max(0,tempH));
    case {'sin','sine'}
        H = sin(tempH);    
    case {'hardlim'}
        H = double(hardlim(tempH));
    case {'tribas'}
        H = tribas(tempH);
    case {'radbas'}
        H = radbas(tempH);
end
OutputWeight=pinv(H') * training_label;

lambda = 5e-3;
OutputWeight_regu = (H * H' + lambda * eye(size(H,1))) \ (H * training_label);


toc
Y=(H' * OutputWeight)';   
Y_regu = (H' * OutputWeight_regu)';

MAE_regu = mae(training_label' - Y_regu);
MAE = mae(training_label' - Y);

output=Y;    
fprintf('Training done, ACT FUN: %s\n',ActivF);
fprintf('Training MAE %d,\nof HiddenNeural %d \n',MAE,NumberofHiddenNeurons);
fprintf('Training MAE_regu %d,\nof HiddenNeural %d \n',MAE_regu,NumberofHiddenNeurons);
save('./elm_model_DCS', 'NumberofInputNeurons', 'NumberofOutputNeurons', 'InputWeight',...
    'BiasofHiddenNeurons', 'OutputWeight', 'ActivF', 'training_label');

save('./IW_bias','InputWeight','BiasofHiddenNeurons');
%%
%ELM synthetic test data prediction
load DCS_test_datasets.mat
load elm_model_DCS.mat

fprintf('Testing......\n');

NumberofTestingData=size(g2_noise_test_nor,1);
tempH_test=InputWeight*g2_noise_test_nor';           
ind=ones(1,NumberofTestingData);
BiasMatrix=BiasofHiddenNeurons(:,ind);  %   Extend the bias matrix BiasofHiddenNeurons to match the demention of H
tic
tempH_test=tempH_test + BiasMatrix;
switch lower(ActivF)
    case {'sig','sigmoid'}
        H_test = 1 ./ (1 + exp(-tempH_test));
    case {'lu_sigmoid'}
        H_test  = LU_sigmoid(tempH_test);
    case {'sigmoid_lut'}
        table = LUT_sigmoid(sigmoid_depth, int_bitw, int_bitw);
        [row,col] = size(tempH_test);
        tempH_test = reshape(tempH_test, 1, []);
        for i=1:size(tempH_test,2)
           e = DtoB(tempH_test(i), data_bitw, frac_bitw);
           if tempH_test(i)>=0
            addr = bin2dec(e(data_bitw-sigmoid_depth+1:data_bitw));
            if addr == 0
                tempH_test(i) = 0;
            else
                tempH_test(i) = table(addr);
            end
           else
            addr = bin2dec(e(data_bitw-sigmoid_depth+1:data_bitw));
            if addr == 0
                tempH_test(i) = 0;
            else
                tempH_test(i) = table(addr)*(-1);
            end
           end
        end
    H_test = reshape(tempH_test,row,col);
    case {'relu'}
        H_test = (max(0,tempH_test));
    case {'sin','sine'}
        H_test = sin(tempH_test);        
    case {'hardlim'}
        H_test = hardlim(tempH_test);        
            
end

ResultVec=H_test'*OutputWeight_regu;
beta = ResultVec(:,1); 
BFi_scaled = ResultVec(:,2); 

toc

abs_error_beta = abs(beta_test - beta);
abs_error_BFi = abs(BFi_test_scaled - BFi_scaled');

% Compute max absolute error
max_error_beta = max(abs_error_beta);
max_error_BFi = max(abs_error_BFi);

% Compute mean absolute error (MAE)
mae_beta = mean(abs_error_beta);
mae_BFi = mean(abs_error_BFi);

% Display results
fprintf('Testing MAE beta: %f\n', mae_beta);
fprintf('Testing MAE BFi: %f\n', mae_BFi);
fprintf('Testing Max Error beta: %f\n', max_error_beta);
fprintf('Testing Max Error BFi: %f\n', max_error_BFi);
%% Input weight and bias L1
% Settings
dataWidth = 12;  % total bitwidth
fracBits = dataWidth - 4;  % assuming int_part = 4
n_hidden = NumberofHiddenNeurons;  % 50
n_output = NumberofOutputNeurons;  % 2
IW = InputWeight;  % size [n_hidden × n_input]
Bias = BiasofHiddenNeurons;  % size [n_hidden × 1]
OW = OutputWeight_regu;  % size [n_hidden × n_output]

% Save Input to Hidden Layer Weights
for h = 1:n_hidden
    w_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), IW(h, :), 'UniformOutput', false);
    fileID = fopen(sprintf('../Weight_mem_1_%d.coe', h-1), 'w');
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

% Save Biases of Hidden Layer
Bias_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), Bias, 'UniformOutput', false);

fileID = fopen('../Bias_mem_1.coe', 'w');
fprintf(fileID, 'memory_initialization_radix=2;\n');
fprintf(fileID, 'memory_initialization_vector=\n');
for i = 1:length(Bias_bin)
    if i < length(Bias_bin)
        fprintf(fileID, '%s,\n', Bias_bin{i});
    else
        fprintf(fileID, '%s;\n', Bias_bin{i});
    end
end
fclose(fileID);

% Save Hidden to Output Layer Weights L2
for o = 1:n_output
    ow_bin = arrayfun(@(x) DtoB(x, dataWidth, fracBits), OW(:, o), 'UniformOutput', false);
    fileID = fopen(sprintf('../Weight_mem_2_%d.coe', o-1), 'w');
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

%% Input vector
filename_input = sprintf('../input.mif');
fid_input = fopen(filename_input, 'w');

input_vec = g2_noise_test_nor(1,:);

for i = 1:size(input_vec,2)  % Inner loop iterates over the 256 columns for each row
    input_b = DtoB(input_vec(i), data_bitw, frac_bitw);
    fprintf(fid_input, '%s\n', input_b);  % MIF format starts from address 0
end
%% read FPGA
if read_FPGA
    fileID = fopen('C:/Users/41536/Desktop/sigmoid_proj/HW/ELM_APPROX/ELM_APPROX.srcs/sources_1/new/output_results.txt', 'r');
    % Initialize an empty array to store the binary numbers
    binaryNumbers = [];
    
    data_bitw_LUT = 12;
    int_bitw_LUT = 4;
    
    % Loop to read each line and convert to binary
    for i = 1:50
        currentLine = fgetl(fileID);
        int_value = bin2dec(currentLine); % Convert binary to integer
        total_bits = data_bitw_LUT + (data_bitw_LUT-int_bitw_LUT) + 1; % 1 sign bit
        if currentLine(1) == '1' % Negative number (two's complement)
            int_value = int_value - 2^total_bits;
        end
        decimal_value = int_value / (2^(data_bitw_LUT-int_bitw_LUT));
        binaryNumbers = [binaryNumbers; decimal_value];
    end
    ResultVec_FPGA=binaryNumbers'*OutputWeight_nor;  
    beta=ResultVec_FPGA(:,1).*max(OutputWeight(:,1));
    BFi_scaled=ResultVec_FPGA(:,2).*max(OutputWeight(:,2));
end
