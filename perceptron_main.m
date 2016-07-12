clear;
close all;
clc;

fprintf('Loading data\n');
data = load('class_feature2_2.dat');
%shuffling
data = data(randperm(size(data, 1)), :);
%Obtain x and d. d is the desired output
x = data(:, 1:(end-1));
d = data(:, end);
[m, n] = size(x);

%Plotting
pos = find(d==1);
neg = find(d==0);

figure; hold on;

plot(x(pos, 1), x(pos, 2), 'k+', 'LineWidth', 2, 'MarkerSize', 7);
plot(x(neg, 1), x(neg, 2), 'ko', 'MarkerFaceColor', 'g', 'MarkerSize', 5);


x = [ones(m, 1), x];
w = zeros(n+1, 1);

alpha = 1;
iterations = 100;

% [weights, gerror_history] = perceptron_learn(x, d, w, alpha, iterations);
[weights, gerror_history] = perceptron_memory_learn(x, d, w, alpha, iterations);


xplot = [0.0:0.01:1];
yplot = (-1./weights(3)).*(weights(2).*xplot + weights(1));
plot(xplot, yplot, 'b-');


plot_error(gerror_history);
disp(gerror_history(iterations));

[weights, gerror_history] = perceptron_learn(x, d, w, alpha, iterations);
plot_error(gerror_history);
disp(gerror_history(iterations));