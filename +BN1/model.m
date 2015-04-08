classdef model
    % MODEL - BN1 prediction
    %   Compute probability of 'Pd' given the evidences
    
    properties
        P_Pd;
        P_Pd_prime_given_Pd;
        P_Xb_prime_given_Pd_prime;
        P_Xh_prime_given_Pd_prime;
        P_Xt_prime_given_Pd_prime;
    end
    
    methods
        %
        % Initializer
        %
        function obj = model( ...
            P_Pd, P_Pd_prime_given_Pd,...
            P_Xb_prime_given_Pd_prime, P_Xh_prime_given_Pd_prime, P_Xt_prime_given_Pd_prime)
        
            obj.P_Pd = [P_Pd 1];
            obj.P_Pd_prime_given_Pd = [P_Pd_prime_given_Pd ones(2,1)];
            % Add total of probability as the last column
            obj.P_Xb_prime_given_Pd_prime = [P_Xb_prime_given_Pd_prime ones(2,1)];
            obj.P_Xh_prime_given_Pd_prime = [P_Xh_prime_given_Pd_prime ones(2,1)];
            obj.P_Xt_prime_given_Pd_prime = [P_Xt_prime_given_Pd_prime ones(2,1)];
        end
        
        %
        % Compute P(pd'|e)
        %
        function P = predict(obj, pd_prime, e)
            p_pd = obj.p_pd( e(1) );
            p_pd_prime_given_pd = obj.p_pd_prime_given_pd( e(1) );
            p_xb_prime_given_pd_prime = obj.p_x_prime_given_pd_prime(obj.P_Xb_prime_given_Pd_prime, e(2) );
            p_xh_prime_given_pd_prime = obj.p_x_prime_given_pd_prime(obj.P_Xh_prime_given_Pd_prime, e(3) );
            p_xt_prime_given_pd_prime = obj.p_x_prime_given_pd_prime(obj.P_Xt_prime_given_Pd_prime, e(4) );
            
            P_normalized = p_pd .* p_pd_prime_given_pd .* p_xb_prime_given_pd_prime ...
                .* p_xh_prime_given_pd_prime .* p_xt_prime_given_pd_prime;
            
            P = P_normalized(obj.index(pd_prime, [1 0])) / sum(P_normalized);
        end
    end
    
    %
    % private functions
    %
    methods(Access = private)
        %
        % Get index from domain
        %
        function ind = index(~, value, domain)
            if isnan(value)
                ind = length(domain) + 1;
            else
                ind = find(domain == value);
            end
        end
        
        %
        % Lookup P(pd)
        %
        function P = p_pd(obj, pd)
            P = obj.P_Pd(obj.index(pd, [1 0]));
        end
        
        %
        % Lookup P(pd'|pd)
        %
        function P = p_pd_prime_given_pd(obj, pd)
            domain = [1 0];
            P = obj.P_Pd_prime_given_Pd(obj.index(pd, domain), 1:length(domain));
        end
        
        %
        % Look P(x_'|pd')
        %
        function P = p_x_prime_given_pd_prime(obj, cpt, x)
            P = cpt(:, obj.index(x, ['H' 'M' 'L']))';
        end
    end
end
