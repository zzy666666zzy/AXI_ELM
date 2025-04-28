clear all;
clc;

gen_half = 1;

if gen_half
    M = 12;
    
    dataWidth = 12;
    inputIntSize = 4;

    dataWidth_LUT = 12;
    inputIntSize_LUT = 4;
else
    M = 12;
    
    dataWidth = 12;
    inputIntSize = 4;
    
    dataWidth_LUT = 12;
    inputIntSize_LUT = 4;
end


fileID = fopen('./sigContent_LU.mif', 'w');

index = 0:1:((2^M)-1);
for j = 1:1:size(index,2)
    qvalue(j) = 0.5+(index(j)+0.5)/(2^(M+1));
end

boundary_list = [];
address_list = [];

for j = 2:1:size(index,2)
    boundary(j-1)= -log((2^(M+1))/((2^M)+index(j))-1);
    boundary_ele = DtoB(boundary(j-1), dataWidth, dataWidth - inputIntSize);
    boundary_list = [boundary_list,bin2dec(boundary_ele)];
    address = DtoB(j-1, dataWidth, 0);
    address_list = [address_list,bin2dec(address)];
    fprintf(fileID, '%s %s\n',address, boundary_ele);
end

[found, idx] = ismember(address_list', boundary_list');

for i = 2:length(idx)
    if idx(i) == 0
        idx(i) = idx(i-1); % Assign previous non-zero value
    end
end

if gen_half
    fileID = fopen('./LU_LUT_HALF.mif', 'w');
    final_LUT = 0.5+(index(idx)+0.5)/(2^(M+1));
    for j = 1:1:size(final_LUT,2)
        LU_LUT = DtoB(final_LUT(j), dataWidth_LUT, dataWidth_LUT - inputIntSize_LUT);
        fprintf(fileID, '%s\n', LU_LUT);
    end
else
    fileID = fopen('./LU_LUT.mif', 'w');
    half1_LUT = 0.5+(index(idx)+0.5)/(2^(M+1));
    half2_LUT = fliplr(1-half1_LUT);
    final_LUT = [half2_LUT, half1_LUT];
    for j = 1:1:size(half1_LUT,2)
        LU_LUT = DtoB(half1_LUT(j), dataWidth_LUT, dataWidth_LUT - inputIntSize_LUT);
        fprintf(fileID, '%s\n', LU_LUT);
    end
end

partition = boundary;
codebook = qvalue;

input = -8:0.01:8;
for ii = 1:1:size(input,2)    
    in = abs(input(ii));
    if input(ii)<=0
       [index,quants(ii)] = quantiz(in,partition,codebook);
       quants(ii) = 1-quants(ii);
    else
       [index,quants(ii)] = quantiz(in,partition,codebook);
    end
end
%%
for j = 1:1:size(input,2)
    real(j) = 1/(1+exp(-input(j))); 
    err(j) = abs(real(j)-quants(j));
end
aveerr = sum(sum(err))/size(input,2);
maxerr = max(err);