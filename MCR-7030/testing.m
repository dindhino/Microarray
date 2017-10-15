function akurasi = testing(hasildata, iteration)
    load (sprintf('hasilTraining%04d.mat', iteration));
    nrow = size(inputan,1);
    jumBenar=0;
    toterr= [];

    for i=ceil(nrow*nk):nrow
    %   forward
        v = W1'* inputan(i,1:count)'+ b1';
        A1 = 1/(1+exp(-v));
        v2 = W2'*A1'+b2;
        A2 = 1/(1+exp(-v2));
        e = hasildata(i) - A2;
        toterr = [toterr e];
%         A2
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
    fprintf('%f \n', akurasi);
end