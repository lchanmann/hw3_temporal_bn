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

%% BN 1
BN1