% Bayesian Networks No.1
%%
clc;
display('_______________________________________________________');
display('                                                       ');
display('                Programming Assignment #3              ');
display('_______________________________________________________');
display('                                                       ');
display('                 Bayesian Networks No.1                ');
display('_______________________________________________________');
display(' ');
%% Run EM algorithm and learn CPDs
domain = ['H' 'M' 'L'];
P_Pd = Pr(Pd_train, [1 0]');
P_Xb_given_Pd = EM(Xb_train, Pd_train, [theta_0(domain); theta_0(domain)]);
P_Xh_given_Pd = EM(Xh_train, Pd_train, [theta_0(domain); theta_0(domain)]);
P_Xt_given_Pd = EM(Xt_train, Pd_train, [theta_0(domain); theta_0(domain)]);

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Xb_given_Pd);
display(P_Xh_given_Pd);
display(P_Xt_given_Pd);

%% Confusion matrix (Train)
observation = [Xb_train Xh_train Xt_train];
Pd = Pd_train;
BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Train) ---------------------');
display(C);
display(accuracy);

%% Confusion matrix (Test)
observation = [Xb_test Xh_test Xt_test];
Pd = Pd_test;
BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Test) ---------------------');
display(C);
display(accuracy);

display('Press Enter to continue ... ');
pause;