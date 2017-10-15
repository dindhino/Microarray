close all;
clear;
clc;

% parameter
datauji = 'ct';
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
ukpop = 5;
ukiterasi = 2;
ukturnamen = 1;
paramturnamen = 0.5;
fitness = [];
n = 2;
itungtraining = [];
k = 3;
fitfold = [];
[dtest, dtrain] = KFoldCrossValidation(inputan, k);
[htest, htrain] = KFoldCrossValidation(hasildata, k);
        
% inisialisasi populasi
population = randi([0,1], ukpop, gen);

backuppop = population;

% tic %semua
for iterasi = 1:ukiterasi
%     tic %tiap iterasi
%     iterasi
%     cek nilai fitness
    for i=1:ukpop
%         i
        fprintf('Training main pop ke: %i \n', i);
%         tic;
        fitfold = [];
        for fold=1:k
            totMSE = training(population(i,:), cell2mat(dtrain(fold)), cell2mat(htrain(fold)));
%             toc;
            fitfold = [fitfold testing(cell2mat(dtrain(fold)), cell2mat(htrain(fold)))];
        end
        fitness = [fitness mean(fitfold)];
        fprintf('Mean Fitness: %f\n', mean(fitfold));
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
    
    bestkrom = population(mod(index,ukpop),:);
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
% save hasilmain;


% klasifikasi
disp('Hasil Klasifikasi');
akurasiakhir = testing(cell2mat(dtest(fold)), cell2mat(htest(fold)));
fprintf('Fitness: %f \n', akurasiakhir);