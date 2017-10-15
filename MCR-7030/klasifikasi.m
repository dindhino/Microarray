% clear;
% clc;
load hasilmain;

count = 0;
for i=1:size(bestkrom,2)
    if bestkrom(1,i) == 1
        count = count + 1;
    end
end

fprintf('\n\n');
fprintf('Hasil Klasifikasi \n');
fprintf('Count: %i \n', count);
datatest = [];
for i=1:size(bestkrom,2)
    if bestkrom(i) == 1
        datatest = [datatest inputan(:,i)];
    end
end

% parameter
load (sprintf('hasilTraining%04d.mat', index));
nk = 0.7;
toterr = [];
nrow = size(datatest,1);
jumBenar=0;

for i=ceil(nrow*nk):nrow
%   forward
    v = W1'* datatest(i,1:size(datatest,2))'+ b1';
    A1 = 1/(1+exp(-v));
    v2 = W2'*A1'+b2;
    A2 = 1/(1+exp(-v2));
    e = hasildata(i,1) - A2;
    toterr = [toterr e];
%     A2

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