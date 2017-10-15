close all;
clear;
clc;

datauji = 'lk';

% parameter
if datauji == 'ct'
    inputan = xlsread('ColonTumor.xlsx');
    hasildata = xlsread('ColonTumor01.xlsx', 'colonTumor', 'BXY1:BXY62');
elseif datauji == 'lk'
    inputan = xlsread('Leukimia.xlsx');
    hasildata = xlsread('Leukimia01.xlsx', 'leukimia', 'JNF1:JNF72');
end
inputan = normalisasi(inputan);
epoch = 100;
lr = 0.5;
in = size(inputan,2);
hidden = 15;
out = 1;
mc = 0.5;
W1 = rand(in,hidden);
b1 = rand(1, hidden);
W2 = rand(hidden, out);
b2 = rand(1, out);
nrow = size(inputan,1);
totMSE = [];
nk = 0.7;
max = 0;
min = 1;
cmax = 0;
cmin = 0;
    
% learning
for j=1:epoch
    toterr = [];
    for i=1:floor(nrow*nk)
%       forward
        v = W1'* inputan(i,1:size(inputan,2))'+ b1';
        A1 = 1/(1+exp(-v));
        v2 = W2'*A1'+b2;
        A2 = 1/(1+exp(-v2));
        e = hasildata(i,1) - A2;
        toterr = [toterr e];

%       backward
        D2 = A2*(1-A2)*e;
        D1 = A1*(1-A1)'*(W2*D2);
        dW1 = lr * D1 * inputan(i,1:size(inputan,2));
        dW2 = lr * D2 * A1;
        dB1 = lr * D1;
        dB2 = lr * D2;

%       pake momentum
%       perbaikan bobot
        W1 = W1*mc + dW1'*(1-mc);
        W2 = W2*mc + dW2'*(1-mc);

%       perbaikan bias
        b1 = b1*mc + dB1'*(1-mc);
        b2 = b2*mc + dB2'*(1-mc);

% %       gapake momentum
% %             perbaikan bobot
%             W1 = W1 + dW1';
%             W2 = W2 + dW2';
% 
% %             perbaikan bias
%             b1 = b1 + dB1';
%             b2 = b2 + dB2';
    end 
    MSE = mean(toterr.^2);
%     disp(MSE);
    totMSE = [totMSE MSE];
end
plot(totMSE);


%testing
jumBenar=0;
for i=ceil(nrow*nk):nrow
    v = W1'* inputan(i,1:size(inputan,2))'+ b1';
    A1 = 1/(1+exp(-v));
    v2 = W2'*A1'+b2;
    A2 = 1/(1+exp(-v2));
    e = hasildata(i,1) - A2;
    toterr = [toterr e];
%     A2
%     if A2 > max
%         max = A2;  
%         cmax = cmax + 1;
%     end
% 
%     if A2 < min
%         min = A2;
%         cmin = cmin + 1;
%     end
% 
%     if A2 <= (max-(min/1e+15))
%         hasil = 1;
% %         disp('masuk 1');
%     else
% %          disp('masuk 0');
%         hasil = 0;
%     end

    if A2 < 0.5
        hasil = 1;
    else
        hasil = 0;
    end 
    
    if hasil == hasildata(i);
        jumBenar = jumBenar + 1;
    end
end
akurasi = (jumBenar/(nrow-ceil(nrow*nk)+1))*100;
disp(strcat('Akurasi: ', num2str(akurasi), '%'));