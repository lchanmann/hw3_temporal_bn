function [ p ] = theta_0 ( domain )
% theta_0 - Create abitarary probability close to 0.5
    
    domain_size = length(domain);
    p = zeros(1, domain_size);
    for i=1:(domain_size-1)
        p(i) = 1/domain_size + .09 * randn;
    end
    p(domain_size) = 1 - sum(p);
end

