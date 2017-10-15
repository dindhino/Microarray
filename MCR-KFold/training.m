function totMSE = training(pop, inputan, hasildata)
    count = 0;
    for i=1:size(pop,2)
        if pop(1,i) == 1
            count = count + 1;
        end
    end
    
    datatest = [];
    for i=1:size(pop,2)
        if pop(i) == 1
            datatest = [datatest inputan(:,i)];
        end
    end
    
    inputan = datatest;
    epoch = 10;
    lr = 0.1;
    in = count;
    hidden = 15;
    out = 1;
    mc = 0.9;
    W1 = rand(in,hidden);
    b1 = rand(1, hidden);
    W2 = rand(hidden, out);
    b2 = rand(1, out);
    nrow = size(inputan,1);
    totMSE = [];

%     tic
    for j=1:epoch
        toterr = [];
        for i=1:nrow
    %         forward
            v = W1'* inputan(i,1:count)'+ b1';
            A1 = 1/(1+exp(-v));
            v2 = W2'*A1'+b2;
            A2 = 1/(1+exp(-v2));
            e = hasildata(i,1) - A2;
            toterr = [toterr e];

    %         backward
            D2 = A2*(1-A2)*e;
            D1 = A1*(1-A1)'*(W2*D2);
            dW1 = lr * D1 * inputan(i,1:count);
            dW2 = lr * D2 * A1;
            dB1 = lr * D1;
            dB2 = lr * D2;

%             pake momentum
    %         perbaikan bobot
            W1 = W1*mc + dW1'*(1-mc);
            W2 = W2*mc + dW2'*(1-mc);

    %         perbaikan bias
            b1 = b1*mc + dB1'*(1-mc);
            b2 = b2*mc + dB2'*(1-mc);

% %             gapake momentum
%     %         perbaikan bobot
%             W1 = W1 + dW1';
%             W2 = W2 + dW2';
% 
%     %         perbaikan bias
%             b1 = b1 + dB1';
%             b2 = b2 + dB2';

        end 
        MSE = mean(toterr.^2);
        totMSE = [totMSE MSE];
    end
%     toc
    figure; plot(totMSE);
    save hasilTraining W1 W2 b1 b2 count;
end