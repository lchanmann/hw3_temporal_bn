prediction = zeros(row, 1);

% prediction
model = BN1.model(...
    P_Pd, P_Pd_prime_given_Pd, ...
    P_Xb_prime_given_Pd_prime, P_Xh_prime_given_Pd_prime, P_Xt_prime_given_Pd_prime);

for i = 1:row
    if ~isnan(Pd_prime(i))
        sample = [Xb(i) Xh(i) Xt(i) Pd(i) Xb_prime(i) Xh_prime(i) Xt_prime(i)];
        prediction(i, 1) = model.predict(1, sample);
    end
end

% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));