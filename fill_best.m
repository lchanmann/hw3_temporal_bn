function [ x ] = fill_best( x )
% fill_best - fill in the best value for x that maximizing the dataset

    x(isnan(x)) = mode(x);
end

