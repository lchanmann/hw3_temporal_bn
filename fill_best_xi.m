function [ x ] = fill_best_xi( x, Pd, Xa )
% fill_best_xi - filling the best value for x that has Pd and Xa as parent
%                in the bayesian network

    domain = [1 1; 1 2; 1 3; 0 1; 0 2; 0 3];
    x_size = [];
    for i=1:size(domain, 1)
        d = domain(i, :);
        x_size(end+1) = sum(Pd == d(1) & Xa == d(2));
    end
    [~, k] = max(x_size);
    d = domain(k, :);
    x(isnan(x)) = mode(x(Pd == d(1) & Xa == d(2)));
end

