function [test_data,train_data] = KFoldCrossValidation(data,k)
    sort_array = randperm(size(data,1));
    for i = 1: size(data,1)
        randomized_data(i,:) = data(sort_array(i),:);
    end
    
    nrows = size(data,1);

    test_data{k,1} = [];
    train_data{k,1} = [];

  block = floor(nrows/k);

  test_data{1} = randomized_data(1:block,:);
  train_data{1} = randomized_data(block+1:end,:);

  for f = 2:k
      test_data{f} = randomized_data((f-1)*block+1:(f)*block,:);
      train_data{f} = [randomized_data(1:(f-1)*block,:); randomized_data(f*block+1:end, :)];
  end
end