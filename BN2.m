% Bayesian Networks No.2
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #3              ');
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.2                ');
display('_______________________________________________________');
display(' ');
%% Run EM algorithm and learn CPDs
P_Pd = Pr(Pd_train, [1 0]');
P_Pd_prime = BN2.CPT(Pd_train(1:length(Pd_train)-1), Pd_train(2:length(Pd_train)), Xa_prime_train);
