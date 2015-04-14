function [ cpt ] = theta_0 ( row, domain )
% theta_0 - Create abitarary probability close to uniform for each row
    
    cpt = zeros(row, length(domain));
    for k=1:row
        cpt(k,:) = probability(domain);
    end
end

%% Generate probability
function [ p ] = probability( domain )
    domain_size = length(domain);
    p = zeros(1, domain_size);
    for i=1:(domain_size-1)
        p(i) = 1/domain_size + .09 * randn;
    end
    p(domain_size) = 1 - sum(p);
end