function [ C ] = confusion( Pd, predicted )
% CONFUSION - construct confusion matrix for variable "drink" (Pd)
%   Obtain the confusion vector by calculating the dot product between 
%       unit vector u = [1 2] and [Pd predicted]' 
%   
%   Then reconstruct the confusion matrix from the vector:
%      True  positive = [1 2] * [1 1]' = 3
%      False positive = [1 2] * [0 1]' = 2
%      False negative = [1 2] * [1 0]' = 1
%      True  negative = [1 2] * [0 0]' = 0
%
    v = [1 2] * [Pd predicted]';
    
    true_positive = sum(v == 3);
    false_positive = sum(v == 2);
    false_negative = sum(v == 1);
    true_negative = sum(v == 0);
    
    C = [ 
        true_positive  false_positive
        false_negative true_negative
    ];
end

