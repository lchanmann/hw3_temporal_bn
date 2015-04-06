%% Setup
clc; clear;
set_laplace_k(1);

%% Load the data and discretize
train_dataset = load('1001-b-clean.csv');
NaN_Pd = isnan(train_dataset(:, 5));
train_dataset = train_dataset(~NaN_Pd, :);

Pd_train = train_dataset(:, 5);
Xb_train = discretize(train_dataset(:, 1));
Xh_train = discretize(train_dataset(:, 2));
Xt_train = discretize(train_dataset(:, 3));

test_dataset = load('1004-b-clean.csv');
Pd_test = test_dataset(:, 5);
Xb_test = discretize(test_dataset(:, 1));
Xh_test = discretize(test_dataset(:, 2));
Xt_test = discretize(test_dataset(:, 3));

%% BN 1
BN1