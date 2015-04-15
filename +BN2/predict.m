function Pd_prime = predict( pd, xa, xb, xt, xh, ...
    xa_prime, xb_prime, xt_prime, xh_prime, ...
    CPT_Pd, CPT_Xb_given_Pd_and_Xa, CPT_Xh_given_Pd_and_Xa, CPT_Xt_given_Pd_and_Xa, ...
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
%       predicted class
    xa_domain = [1 2 3];
    xj_domain = ['H', 'M', 'L'];
    pd_domain = [1 0];
    P_Pd=1;
    P_Xa=1;
    P_Xb_prime_given_Pd_Xa=lookup(CPT_Xb_given_Pd_and_Xa, Xb_prime, nan, Xa_prime);
    P_Xh_prime_given_Pd_Xa=lookup(CPT_Xh_given_Pd_and_Xa, Xh_prime, nan, Xa_prime);
    P_Xt_prime_given_Pd_Xa=lookup(CPT_Xt_given_Pd_and_Xa, Xt_prime, nan, Xa_prime);
    P_Pd_prime_given_Pd=1;
    P_Xa_prime_given_Pd_and_Xa=1;
    jointP_Xa_prime=lookup(P_Xa_prime_given_Pd_and_Xa, pd, xa);%should yield a 3*1 matrix
    
    if ~isnan(Pd)
        jointPd = lookup(P_Pd_prime_given_Pd, nan, pd)*lookup(P_Pd, pd); %2*1 matrix
        %Catch case 2: is an Xj missing? Regardless of Xa
        if ~isnan(Xb)
            jointPd_rep = repmat(jointPd,1, length(jointP_Xa_prime));
            jointP_Xb_prime = sum(sum(P_Xb_prime_given_Pd_Xa.*jointPd,1).*jointP_Xa_prime,2);
            jointP_Xh_prime = sum(sum(P_Xh_prime_given_Pd_Xa.*jointPd,1).*jointP_Xa_prime,2);
            jointP_Xt_prime = sum(sum(P_Xt_prime_given_Pd_Xa.*jointPd,1).*jointP_Xa_prime,2);
        else
            if ~isnan(Xa)
        end
    end
end

function P = lookup(cpt, x, pd, xa)
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

    if ~isnan(x)
        col = index(x, ['H', 'M', 'L']);
        if ~isnan(xa)
            cols = (index(xa, [1 2 3])-1)*3 + col;
        else
            cols = [col col+3 col+6];
        end
    else
        if ~isnan(xa)
            col = (index(xa, [1 2 3])-1)*3;
            cols = [col:col+3];
        else
            cols = [1:9];
        end
    end
        
    if ~isnan(pd)
        P = cpt(index(pd, [1 0]), cols);
    else
        P = cpt(:, cols);
    end
end

function P = lookup_all_x(cpt, pd, xa)
%Returns a vector with the probabilities for all three possible values
    col = (index(xa, [1 2 3])-1)*3;
    P = cpt( index(pd, [1 0]), [col:col+3]);
end

function ind = index(~, value, domain)
%finds the index of the given value in the domain, useful for tables
%ordered following the order in the domain.
        ind = find(domain == value);
end
