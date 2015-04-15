%==========================================================================
% CS 8750 - Artificial Intelligence II...
% Programming Assignment #3 ...
% Chanmann Lim   ... CS
% Fernando Torre ... CS
% Adil Al-Azzawi ... ECE
%==========================================================================
%%
%% Setup
clc; clear;
set_laplace_k(1);

%% Load the data and discretize...
%% Training ...
train_dataset = load('1001-b-clean.csv');

Pd_train = train_dataset(:, 5);
Xa_train = train_dataset(:, 4);
Xb_train = discretize(train_dataset(:, 1));
Xh_train = discretize(train_dataset(:, 2));
Xt_train = discretize(train_dataset(:, 3));
Pd_prime_train = Pd_train(2:end);
Xa_prime_train = Xa_train(2:end);
Xb_prime_train = Xb_train(2:end);
Xh_prime_train = Xh_train(2:end);
Xt_prime_train = Xt_train(2:end);

test_dataset = load('1004-b-clean.csv');
Pd_test = test_dataset(:, 5);
Xb_test = discretize(test_dataset(:, 1));
Xh_test = discretize(test_dataset(:, 2));
Xt_test = discretize(test_dataset(:, 3));
Pd_prime_test = Pd_test(2:end);
Xb_prime_test = Xb_test(2:end);
Xh_prime_test = Xh_test(2:end);
Xt_prime_test = Xt_test(2:end);

[row, ~] = size(Pd_prime_train);
%% BN 1
BN1

%% BN 2
BN2