%% Learn parameters of the CPDs
P_Pd = [sum(Pd == 1)/length(Pd); sum(Pd == 0)/length(Pd)];
P_Xb_given_Pd = BN1.CPT(Xb, Pd);
% P_Xh_given_Pd = BN1.CPT(Xh, Pd);
% P_Xt_given_Pd = BN1.CPT(Xt, Pd);