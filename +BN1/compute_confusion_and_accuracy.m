[data_size, ~] = size(Pd_prime);

% prediction
model = BN1.model(...
    P_Pd, P_Pd_prime_given_Pd, ...
    P_Xb_prime_given_Pd_prime, P_Xh_prime_given_Pd_prime, P_Xt_prime_given_Pd_prime);

prediction = [];
Pd_prime_true = [];
for i = 1:data_size
    pd_prime = Pd_prime(i);
    if ~isnan(pd_prime)
        sample = [Xb(i) Xh(i) Xt(i) Pd(i) Xb_prime(i) Xh_prime(i) Xt_prime(i)];
        Pd_prime_true(end+1, 1) = pd_prime;
        
        prediction(end+1, 1) = model.predict(sample);
    end
end

% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd_prime_true, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));