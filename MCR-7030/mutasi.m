function pop = mutasi(pop)
    if (rand() > 0.6)
        r1 = randi([1 size(pop,2)],1);
        r2 = randi([1 size(pop,2)],1);
        pop(r1) = pop(r1) + pop(r2);
        pop(r2) = pop(r1) - pop(r2);
        pop(r1) = pop(r1) - pop(r2);
    end
end