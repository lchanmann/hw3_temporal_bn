%% Learn parameters of the CPDs
P_Pd = Pr(Pd, [1 0]');
P_Xb_given_Pd = BN1.CPT(Xb, Pd);
P_Xh_given_Pd = BN1.CPT(Xh, Pd);
P_Xt_given_Pd = BN1.CPT(Xt, Pd);

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Xb_given_Pd);
display(P_Xh_given_Pd);
display(P_Xt_given_Pd);

%% Confusion matrix
data_size = size(test_dataset, 1);
prediction = zeros(data_size, 1);

% prediction
model = BN1.model(P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd);
for i = 1:data_size
    prediction(i, 1) = model.predict(1, observation(i, :));
end
% normalize the prediction 
%   the person drink (Pd = 1) if prediction > 0.5,
%   otherwise, the person doesn't drink (Pd = 0)
predicted_Pd = prediction > 0.5;
C = confusion(Pd_test, predicted_Pd);
% accuracy rate = sum of diagonal / sum of all
accuracy = sum(diag(C)) / sum(sum(C));

display(' ');
display('--------------------- Confusion matrix ---------------------');
display(C);
display(accuracy);
display('Press Enter to continue ... ');
pause;