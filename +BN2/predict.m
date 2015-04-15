function Pd_prime = predict( pd, xa, xb, xt, xh, ...
    xa_prime, xb_prime, xt_prime, xh_prime, ...
    CPT_Pd, CPT_Xa, CPT_Xb_given_Pd_and_Xa, CPT_Xh_given_Pd_and_Xa, CPT_Xt_given_Pd_and_Xa, ...
    CPT_Pd_prime_given_Pd, CPT_Xa_prime_given_Pd_and_Xa )
%PREDICT Summary of this function goes here
%   inputs:
%       pd, xa, xb, xt, xh: evidence variables for the previous time slice
%       xa_prime, xb_prime, xt_prime, xh_prime: evidence variables for
%             current time slice
%       CPT_Xb_given_Pd_and_Xa, CPT_Xh_given_Pd_and_Xa, CPT_Xt_given_Pd_and_Xa: conditional
%           probabilities for previous time slice (shared with current)
%       CPT_Pd, CPT_Xa: conditional probabilities for previous time slice (not 
%           shared with current) 
%       CPT_Pd_prime_given_Pd, CPT_Xa_prime_given_Pd_and_Xa:
%           conditional probabilities for current time slice (not shared 
%           with previous)
%   outputs:
%       probability of pd=true
    xa_domain = [1 2 3];
    xj_domain = ['H', 'M', 'L'];
    pd_domain = [1 0];
    P_Pd=lookup(CPT_Pd, pd, pd_domain);
    P_Pd_prime_given_Pd=lookup(CPT_Pd_prime_given_Pd, nan, pd_domain, pd, pd_domain);
    jointPd=sum(P_Pd_prime_given_Pd,2).*P_Pd; %should yield 2*1 matrix

    P_Xa=lookup(CPT_Xa, xa_prime, xa_domain);
    P_Xb_prime_given_Pd_Xa=lookup(CPT_Xb_given_Pd_and_Xa, xb_prime, xj_domain, nan, pd_domain, xa_prime, xa_domain);
    P_Xh_prime_given_Pd_Xa=lookup(CPT_Xh_given_Pd_and_Xa, xh_prime, xj_domain, nan, pd_domain, xa_prime, xa_domain);
    P_Xt_prime_given_Pd_Xa=lookup(CPT_Xt_given_Pd_and_Xa, xt_prime, xj_domain, nan, pd_domain, xa_prime, xa_domain);
    P_Xa_prime_given_Pd_Xa=lookup(CPT_Xa_prime_given_Pd_and_Xa, xa_prime, xa_domain, pd, pd_domain, xa, xa_domain);
    jointP_Xa_prime=P_Xa_prime_given_Pd_Xa.*P_Xa;%should yield a 3*1 matrix

    P_Xb_given_Pd_Xa=lookup(CPT_Xb_given_Pd_and_Xa, xb_prime, xj_domain, pd, pd_domain, xa_prime, xa_domain);
    P_Xh_given_Pd_Xa=lookup(CPT_Xh_given_Pd_and_Xa, xh_prime, xj_domain, pd, pd_domain, xa_prime, xa_domain);
    P_Xt_given_Pd_Xa=lookup(CPT_Xt_given_Pd_and_Xa, xt_prime, xj_domain, pd, pd_domain, xa_prime, xa_domain);
    jointP_Xa=P_Xa.*P_Xa;%should yield a 3*1 matrix
    
    %if ~isnan(Pd)
        jointPd_rep = repmat(jointPd,1, length(jointP_Xa_prime));
        jointP_Xb_prime = sum(sum(P_Xb_prime_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa_prime,2);
        jointP_Xh_prime = sum(sum(P_Xh_prime_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa_prime,2);
        jointP_Xt_prime = sum(sum(P_Xt_prime_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa_prime,2);
        Pd_prime=jointP_Xb_prime * jointP_Xh_prime * jointP_Xt_prime;
    
    if isnan(pd)
        jointPd_rep = repmat(jointPd,1, length(jointP_Xa));
        jointP_Xb = sum(sum(P_Xb_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa,2);
        jointP_Xh = sum(sum(P_Xh_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa,2);
        jointP_Xt = sum(sum(P_Xt_given_Pd_Xa.*jointPd_rep,1).*jointP_Xa,2);
        Pd_prime=Pd_prime*jointP_Xb*jointP_Xh*jointP_Xt;
    end
    
    
    denom=1; %constructed from all lookups which returned a single value
    if ~isnan(pd)
        denom = denom*P_Pd;
    end
    if ~isnan(xa)
        denom = denom*P_Xa;
    end
    if ~isnan(xb)
        denom = denom*P_Xb_given_Pd_Xa;
    end
    if ~isnan(xt)
        denom = denom*P_Xt_given_Pd_Xa;
    end
    if ~isnan(xh)
        denom = denom*P_Xh_given_Pd_Xa;
    end
    if ~isnan(xa_prime)
        denom = denom*P_Xa_prime_given_Pd_Xa;
    end
    if ~isnan(xb_prime)
        denom = denom*P_Xb_prime_given_Pd_Xa;
    end
    if ~isnan(xt_prime)
        denom = denom*P_Xt_prime_given_Pd_Xa;
    end
    if ~isnan(xh_prime)
        denom = denom*P_Xh_prime_given_Pd_Xa;
    end
    
    Pd_prime = Pd_prime / denom;
end

function P = lookup(cpt, x, x_domain, pd, pd_domain, xa, xa_domain)
%gives the value of the cell in a CPT for X=x, Pd=pd and Xa=xa. Assumes
%default domains for these variables.If any one of the values is missing, 
%Returns a vector with the probabilities for all three possible values. If
%two are missing, returns a matrix with the corresponding values. if all
%three are missing, returns full cpt table.
%
%Inputs:
%   cpt: Conditional Probability table (CPT) of a variable x 
%       dependent first on Pd (stored as rows) and second on Xa
%       (columns). The columns are assumed to be subdivided by the values
%       of x, so that if the values of xa are 'a' and 'b', and the values
%       of x are 1 and 2, the columns are taken to represent the pairs
%       (a,1), (a,2), (b,1), (b,2).
%   x:  value of the variable that the CPT estimates
%   pd: first dependency of X
%   xa: second dependency of X
%
%Outputs:
%   P(x|pd,xa) as a scalar probability value, if all values are given
%   a 1*n matrix, if xa is nan (where n is the possible values of Xa)
%       and each cell is P(x|pd,Xa) for each value of xa
%   a 1*m matrix, if x is nan (where m is the possible values of X)
%       and each cell is P(X|pd,xa) for each value of X
%   a d*1 matrix, if pd is mam (where d is the possible values of Pd)
%       and each cell is P(X|pd,xa) for each value of Pd
%   a d*n matrix if pd and xa are missing
%   a d*m matrix if pd and x are missing
%   the full cpt table if all values are msising
    if nargin<6
        xa=nan;
        xa_domain = 1;
        if nargin<4
            pd=nan;
            pd_domain = 1;
        end
    end


    if ~isnan(x)
        col = index(x, x_domain);
        if ~isnan(xa)
            cols = (index(xa, xa_domain)-1)*length(x_domain) + col;
        else
            cols = ([1:length(xa_domain)]-1)*length(x_domain)+col;
        end
    else
        if ~isnan(xa)
            col = (index(xa, xa_domain)-1)*length(x_domain);
            cols = [col:col+length(x_domain)];
        else
            cols = [1:length(xa_domain)*length(x_domain)];
        end
    end
        
    if ~isnan(pd)
        P = cpt(index(pd, pd_domain), cols);
    else
        P = cpt(:, cols);
    end
end

function ind = index(value, domain)
%finds the index of the given value in the domain, useful for tables
%ordered following the order in the domain.
        ind = find(domain == value);
end
