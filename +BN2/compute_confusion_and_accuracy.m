data_size = size(observation, 1);
prediction = zeros(data_size, 1);

% prediction
model = BN2.model(...
    P_Pd, P_Xa, P_Pd_prime_given_Pd, P_Xa_prime_given_Pd_and_Xa, ...
    P_Xb_prime_given_Pd_prime_and_Xa_prime, ...
    P_Xh_prime_given_Pd_prime_and_Xa_prime, ...
    P_Xt_prime_given_Pd_prime_and_Xa_prime );
for i = 1:data_size
    prediction(i, 1) = model.predict(1, observation(i, :));
end
% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));