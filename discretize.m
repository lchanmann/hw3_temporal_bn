function [ x ] = discretize( x )
% DISCRETIZE - discretize real number state variable into {H, M, L}
%   convert the values to
%     - 'H' if bigger than one standard deviation about the mean
%     - 'L' if less than one standard deviation about the mean
%     - 'M' otherwise
%
    % empirical mean and standard deviation of x
    %   mean = sum(x) / length(x);
    %   std = sqrt( sum((x - mean) .^ 2) / length(x) )
    x_mean = mean(x);
    x_std = std(x, 1);
    
    H = x > x_mean+x_std;
    L = x < x_mean-x_std;
    
    x(H) = 'H'; 
    x(L) = 'L';
    x(~H & ~L) = 'M';
end

