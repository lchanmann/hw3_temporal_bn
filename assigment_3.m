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
set_laplace_k(0);

%% Load the data and discretize...
%% Training ...
train_dataset = load('1001-b-clean.csv');
NaN_Pd = isnan(train_dataset(:, 5));
train_dataset = train_dataset(~NaN_Pd, :);

Pd_train = train_dataset(:, 5);
Xb_train = discretize(train_dataset(:, 1));
Xh_train = discretize(train_dataset(:, 2));
Xt_train = discretize(train_dataset(:, 3));

Pd_prime_train = [Pd_train(2:end); nan];
Xb_prime_train = [Xb_train(2:end); nan];
Xh_prime_train = [Xh_train(2:end); nan];
Xt_prime_train = [Xt_train(2:end); nan];

%% Testing...
test_dataset = load('1004-b-clean.csv');
Pd_test = test_dataset(:, 5);
Xb_test = discretize(test_dataset(:, 1));
Xh_test = discretize(test_dataset(:, 2));
Xt_test = discretize(test_dataset(:, 3));

%% BN 1
BN1