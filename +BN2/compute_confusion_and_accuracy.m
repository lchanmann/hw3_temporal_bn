[data_size, ~] = size(Pd_prime);

% prediction
prediction = [];
Pd_prime_true = [];
for i = 1:data_size
    pd_prime = Pd_prime(i);
    if ~isnan(pd_prime)
        sample = [Xb(i) Xh(i) Xt(i) Pd(i) Xb_prime(i) Xh_prime(i) Xt_prime(i)];
        Pd_prime_true(end+1, 1) = pd_prime;
        
        prediction(end+1, 1) = ...
            BN2.predict(Pd(i), Xa(i), Xb(i), Xt(i), Xh(i), ...
                Xa_prime(i), Xb_prime(i), Xt_prime(i), Xh_prime(i), ...
                P_Pd, P_Xa, P_Xb_given_Pd_and_Xa, P_Xh_given_Pd_and_Xa, P_Xt_given_Pd_and_Xa, ...
                P_Pd_prime_given_Pd, P_Xa_prime_given_Pd_and_Xa);
    end
end

% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd_prime_true, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));