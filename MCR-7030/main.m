% parameter
datauji = 'lk';
if datauji == 'ct'
    disp('Running Colon Tumor');
    inputan = xlsread('ColonTumor.xlsx');
    hasildata = xlsread('ColonTumor01.xlsx', 'colonTumor', 'BXY1:BXY62');
elseif datauji == 'lk'
    disp('Running Leukimia');
    inputan = xlsread('Leukimia.xlsx');
    hasildata = xlsread('Leukimia01.xlsx', 'leukimia', 'JNF1:JNF72');
end
inputan = normalisasi(inputan);
gen = size(inputan, 2);
ukpop = 10;
ukiterasi = 1;
ukturnamen = 1;
paramturnamen = 0.5;
fitness = [];
n = 2;
itungtraining = [];

% inisialisasi populasi
population = zeros(ukpop, gen);
for i = 1:ukpop
    for j = 1:gen
        s = rand();
        if (s < 0.5)
            population(i,j)=0;
        else 
            population(i,j)=1;
        end
    end
end
% cekpop = population;

% tic %semua
for iterasi = 1:ukiterasi
%     tic %tiap iterasi
%     iterasi
%     cek nilai fitness
    for i=1:ukpop
%         i
        fprintf('Training main pop ke: %i \n', i);
        tic;
        totMSE = training(population(i,:), inputan, hasildata, i);
        toc;
        itungtraining = [itungtraining toc];
%         figure; plot(totMSE);
        fprintf('Fitnessnya: ');
        fitness = [fitness testing(hasildata, i)];
    end
    [bestfit, index] = max(fitness);
    
%     copy dulu populasinya
    newpop = population;

    % generasi baru
    for i = 1:ukturnamen:ukpop
        % seleksi parent
        pilih1 = seleksiturnamen(fitness, paramturnamen, ukturnamen);
        pilih2 = seleksiturnamen(fitness, paramturnamen, ukturnamen);
        p1 = population(pilih1,:);
        p2 = population(pilih2,:);

        % crossover
        [c1, c2] = crossover(p1, p2);
        newpop(i,:) = c1;
        newpop(i+1,:) = c2;
    end

%     mutasi
    newpop = mutasi(newpop);
    
    bestkrom = population(mod(index, ukpop),:);
    newpop = InsertBestIndividual(newpop, bestkrom, n);
        
    population = newpop;
%     fprintf('Hasil running iterasi ke-%i: ' iterasi);
%     toc %tiap iterasi
%     fprintf('\n');
end
% fprintf('Hasil running main: ');
% toc %semua
fprintf('\n\n');
disp('Hasil Main');
fprintf('Fitness: %f \n', bestfit);
fprintf('Best Kromosom (index): %i \n', index);
% disp(bestkrom);

save hasilmain;