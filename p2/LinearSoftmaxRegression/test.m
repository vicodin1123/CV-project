figure; 
scatter(ITERATION_COUNTS, corretPTrain);
hold on;
scatter(ITERATION_COUNTS, corretPTest);
axis([1000, 10000, 0, 100]);
set(gca,'xscale','log');
legend('Train','Test');
title('Classification Rate vs. # of Iterations');