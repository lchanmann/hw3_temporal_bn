function Pd_prime = predict( Pd, Xa, Xb, Xt, Xh, ...
    Xa_prime, Xb_prime, Xt_prime, Xh_prime, ...
    CPT_Pd, CPT_Xb_given_Pd_and_Xa, CPT_Xh_given_Pd_and_Xa, CPT_Xt_given_Pd_and_Xa, ...
    CPT_Pd_prime_given_Pd_and_Xa, CPT_Xa_prime_given_Pd_and_Xa )
%PREDICT Summary of this function goes here
%   inputs:
%       Pd, Xa, Xb, Xt, Xh: evidence variables for the previous time slice
%       Xa_prime, Xb_prime, Xt_prime, Xh_prime, CPT_Pd: evidence variables for
%             current time slice
%       CPT_Xb_given_Pd_and_Xa, CPT_Xh_given_Pd_and_Xa, CPT_Xt_given_Pd_and_Xa: conditional
%           probabilities for previous time slice (shared with current)
%       CPT_Pd, CPT_Xa: conditional probabilities for previous time slice (not 
%           shared with current) 
%       CPT_Xb_given_Pd_and_Xa, , CPT_Xt_given_Pd_and_Xa:
%           conditional probabilities for current time slice (not shared 
%           with previous)
%   outputs:
%       predicted class
    xa_domain = [1 2 3];
    xj_domain = ['H', 'M', 'L'];
    pd_domain = [1 0];
    P_Pd=1;
    P_Xa=1;
    P_Xb_given_Pd_Xa=lookup_x(CPT_Xb_given_Pd_and_Xa, Xb, Pd, Xa);
    P_Xh_given_Pd_and_Xa=lookup_x(CPT_Xh_given_Pd_and_Xa, Xh, Pd, Xa);
    P_Xt_given_Pd_and_Xa=lookup_x(CPT_Xt_given_Pd_and_Xa, Xt, Pd, Xa);
    P_Pd_prime_given_Pd_and_Xa=1;
    P_Xa_prime_given_Pd_and_Xa=1;
    jointP_Xa_prime=1;
    
    if ~isnan(Pd)
        %Catch case 2: is an Xj missing? Regardless of Xa
        if ~isnan(Xb)
            jointP_Xb_prime = sum(P_Xb_given_Pd_Xa.*jointP_Xa_prime);
            jointP_Xh_prime = sum(P_Xh_given_Pd_Xa.*jointP_Xa_prime);
            jointP_Xt_prime = sum(P_Xt_given_Pd_Xa.*jointP_Xa_prime);
        else
            if ~isnan(Xa)
        end
    end
end

function P = lookup_x(cpt, x, pd, xa)
%gives the value of the cell in CPT for X=x, Pd=pd and Xa=xa. Assumes
%default domains for these variables. if any one of the values is missing, 
%Returns a vector with the probabilities for all three possible values
    if isnan(x)
        col = (index(xa, [1 2 3])-1)*3;
        P = cpt( index(pd, [1 0]), [col:col+3]);
    else if isnan(xa)
            col = index(x, ['H', 'M', 'L']);
            P = cpt( index(pd, [1 0]), [col col+3 col+6]);
        else if isnan(xa)
                P = cpt( :, (index(xa, [1 2 3])-1)*3 + index(x, ['H', 'M', 'L']) );
            else
                P = cpt( index(pd, [1 0]), (index(xa, [1 2 3])-1)*3 + index(x, ['H', 'M', 'L']) );
            end
        end
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
