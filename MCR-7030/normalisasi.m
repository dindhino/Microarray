function [inputan] = normalisasi(inputan)
%     Min-Max
% 
%     Metode Min-Max merupakan metode normalisasi dengan melakukan transformasi
%     linier terhadap data asli
% 
%     rumus
%     newdata = (data-min)*(newmax-newmin)/(max-min)+newmin
% 
%     newdata= data hasil normalisasi
%     min = nilai minimum dari data per kolom
%     max = nilai maximum dari data per kolom
%     newmin = adalah batas minimum yang kita berikan
%     newmax = adalah batas maximum yang kita berikan

    minimal = min(inputan);
    maximal = max(inputan);
    newmin = 0;
    newmax = 1;
    for i=1:size(inputan,2)
        inputan(:,i) = (((inputan(:,i) - minimal(i))*(newmax - newmin)) / ((maximal(i) - minimal(i))+newmin));
    end
end

