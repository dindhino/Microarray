clear;
clc;
population = zeros(5, 2000);
for i = 1:5
    for j = 1:2000
        s = rand();
        if (s < 0.5)
            population(i,j)=0;
        else 
            population(i,j)=1;
        end
    end
end