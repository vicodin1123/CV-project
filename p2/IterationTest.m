
ITERATION_COUNTS = [0:1:99 100:100:1000];
corretPTrain = zeros(size(ITERATION_COUNTS));
corretPTest = zeros(size(ITERATION_COUNTS));

for C = 1 : numel(ITERATION_COUNTS)

%% Learning    
MAX_ITERATION = ITERATION_COUNTS(C);
MIN_GRADIENT_DIFF_PERCENTAGE = 0.001;
LAMBDA = 0.0005;
theta = 0.0005 * randn(DIMENSION, MAX_CLASS);

lastG = 0;
g = 0;
for i = 1 : MAX_ITERATION
    [L, g] = gradientDescent(TrainSet, theta); 
    theta = theta - LAMBDA.*g;
    %disp(mean(mean(abs(g))));
end

disp(sprintf('For %d iterations: final cost = %.2f', MAX_ITERATION, L));

%% Training Set error
K = MAX_CLASS;
errorCount = zeros(size(TrainSet));

for i = 1 : K
    target = i;
    
    for r = 1 : size(TrainSet{i}, 1)
        xi = TrainSet{i}(r, :).';
        yi = softmax(xi, theta);
        [v ind] = max(yi);
        if ind ~= target
            errorCount(i) = errorCount(i) + 1;
        end
    end
end
corretPTrain(C) = (1-sum(errorCount)/sum(TrainCount)) * 100;
disp( sprintf('Training correct %%: %.2f%%', (1-sum(errorCount)/sum(TrainCount)) * 100));

%% Testing Set error
K = MAX_CLASS;
errorCount = zeros(size(TestSet));

for i = 1 : K
    target = i;
    
    for r = 1 : size(TestSet{i}, 1)
        xi = TestSet{i}(r, :).';
        yi = softmax(xi, theta);
        [v ind] = max(yi);
        if ind ~= target
            errorCount(i) = errorCount(i) + 1;
        end
    end
end
corretPTest(C) = (1-sum(errorCount)/sum(TestCount)) * 100;
disp( sprintf('Testing correct %%: %.2f%%', (1-sum(errorCount)/sum(TestCount)) * 100));

end
figure; 
scatter(ITERATION_COUNTS, corretPTrain);
hold on;
scatter(ITERATION_COUNTS, corretPTest);
axis([0, 1000, 0, 100]);
legend('Train','Test');
title('Classification rate vs. # of iterations');