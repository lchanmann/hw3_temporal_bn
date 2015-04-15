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
initialize_cpt = @() [theta_0('HML'); theta_0('HML')];

P_Pd = theta_0(1, [1 0]);
P_Pd_prime_given_Pd = theta_0(2, [1 0]);
P_Xb_prime_given_Pd_prime = theta_0(2, 'HML');
P_Xh_prime_given_Pd_prime = theta_0(2, 'HML');
P_Xt_prime_given_Pd_prime = theta_0(2, 'HML');

% Loop until converge
P_Pd_prime_given_Pd_temp = P_Pd_prime_given_Pd;
epsilon = 10e-8;
while 1
    BN1.E_step
    BN1.M_step
    
    distance = abs(sum(sum(P_Pd_prime_given_Pd - P_Pd_prime_given_Pd_temp))) / 4;
    if distance < epsilon
        break
    end
    P_Pd_prime_given_Pd_temp = P_Pd_prime_given_Pd;
end

display('--------------------- Parameters learned ---------------------');
display(P_Pd);
display(P_Pd_prime_given_Pd);
display(P_Xb_prime_given_Pd_prime);
display(P_Xh_prime_given_Pd_prime);
display(P_Xt_prime_given_Pd_prime);

%% Confusion matrix (Train)
Pd = Pd_train;
Xb = Xb_train;
Xh = Xh_train;
Xt = Xt_train;
Pd_prime = Pd_prime_train;
Xb_prime = Xb_prime_train;
Xh_prime = Xh_prime_train;
Xt_prime = Xt_prime_train;

BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Train) ---------------------');
display(C);
display(accuracy);

%% Confusion matrix (Test)
Pd = Pd_test;
Xb = Xb_test;
Xh = Xh_test;
Xt = Xt_test;
Pd_prime = Pd_prime_test;
Xb_prime = Xb_prime_test;
Xh_prime = Xh_prime_test;
Xt_prime = Xt_prime_test;

BN1.compute_confusion_and_accuracy;

display(' ');
display('--------------------- Confusion matrix (Test) ---------------------');
display(C);
display(accuracy);

display('Press Enter to continue ... ');
pause;