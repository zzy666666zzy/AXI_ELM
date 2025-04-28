%original 12 12 4 4
clear;clc;

dataWidth = 12;%number bit-width in the ROM
sigmoidSize = 12;%length of the ROM

weightIntSize = 4;
inputIntSize = 4;

x_list = [];
y_list = [];
fileID = fopen('./sigContent.mif', 'w');

fileID1 = fopen('./sigmoid_rom.coe', 'w');
fprintf(fileID1, 'memory_initialization_radix=2;\n');
fprintf(fileID1, 'memory_initialization_vector=\n');
% truncate frac, keep integer
%fractBits = sigmoidSize - (weightIntSize + inputIntSize);

fractBits = sigmoidSize - (weightIntSize);

fprintf('Resolution is x %f\n', 2^-fractBits);

if fractBits < 0
    fractBits = 0;
end

%x = -2^(weightIntSize + inputIntSize - 1); % Smallest input

x = -2^(weightIntSize - 1);

fprintf('smallest x %f\n', x);

for i = 0 : (2^sigmoidSize - 1)
    try
        y = 1 / (1 + exp(-x));
    catch
        y = 0; % Handle potential overflow/underflow
    end

    y_list = [y_list, y];

    z = DtoB(y, dataWidth, dataWidth - inputIntSize); %(8,4)
    fprintf(fileID, '%s\n', z);
    
    if i < (2^sigmoidSize - 1)
        fprintf(fileID1, '%s,\n', z);  % add comma
    else
        fprintf(fileID1, '%s;\n', z);  % semicolon at last line
    end
    
    x = x + (2^-fractBits);
    x_list = [x_list, x];
end

fclose(fileID);
fclose(fileID1);