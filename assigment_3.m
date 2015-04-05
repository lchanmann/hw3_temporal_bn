%% Setup
clc; clear;
set_laplace_k(1);

%% Load the data and discretize
dataset = load('1001-b-clean.csv');
NaN_Pd = isnan(dataset(:, 5));
dataset = dataset(~NaN_Pd, :);

Pd = dataset(:, 5);
Xb = discretize(dataset(:, 1));
Xh = discretize(dataset(:, 2));
Xt = discretize(dataset(:, 3));

test_dataset = load('1004-b-clean.csv');
Pd_test = test_dataset(:, 5);
Xb_test = discretize(test_dataset(:, 1));
Xh_test = discretize(test_dataset(:, 2));
Xt_test = discretize(test_dataset(:, 3));
observation = [Xb_test Xh_test Xt_test];

%% BN 1
BN1