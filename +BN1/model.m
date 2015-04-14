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
        
        %
        % pd_count
        %
        function count = pd_count(obj, pd)
            if isnan(pd)
                count = obj.P_Pd(1:2);
            else
                count = [1 0] == pd;
            end
        end
        
        %
        % pd_prime_given_pd_count
        %
        function count = pd_prime_given_pd_count(obj, value)
            nan_value = isnan(value);
            
            if sum(nan_value) == 0
                domain = [1 1; 0 1; 1 0; 0 0];
                count = obj.match_count(domain, value);
            else
                count = obj.P_Pd_prime_given_Pd(:, [1 2]);
                if nan_value(1) == 0
                    pd_prime = value(1);                    
                    if pd_prime == 1
                        % keep the first column
                        count = count * [1 0; 0 0];
                    else
                        % keep the second column
                        count = count * [0 0; 0 1];
                    end
                    count = count / sum(sum(count));
                elseif nan_value(2) == 0
                    pd = value(2);
                    count = obj.count_given_pd(count, pd);
                else
                    count = count / sum(sum(count));
                end
            end
        end
        
        %
        % xb_given_pd_count
        %
        function count = xb_given_pd_count(obj, value)
            count = obj.x_given_pd_count(value, obj.P_Xb_prime_given_Pd_prime(:, [1 2 3]));
        end
        
        %
        % xh_given_pd_count
        %
        function count = xh_given_pd_count(obj, value)
            count = obj.x_given_pd_count(value, obj.P_Xh_prime_given_Pd_prime(:, [1 2 3]));
        end
        
        %
        % xt_given_pd_count
        %
        function count = xt_given_pd_count(obj, value)
            count = obj.x_given_pd_count(value, obj.P_Xt_prime_given_Pd_prime(:, [1 2 3]));
        end
        
        %
        % x_given_pd_count
        %
        function count = x_given_pd_count(obj, value, cpt)
            nan_value = isnan(value);
            
            if sum(nan_value) == 0
                domain = ['H'+0 1; 'M'+0 1; 'L'+0 1
                          'H'+0 0; 'M'+0 0; 'L'+0 0];
                count = obj.match_count(domain, value);
            else
                count = cpt;
                if nan_value(1) == 0 % Xi has value
                    xb = value(1);
                    if xb == 'H'
                        % keep the first column
                        count = count * [1 0 0; 0 0 0; 0 0 0];
                    elseif xb == 'M'
                        % keep the second column
                        count = count * [0 0 0; 0 1 0; 0 0 0];
                    else
                        % keep the third column
                        count = count * [0 0 0; 0 0 0; 0 0 1];
                    end
                    count = count / sum(sum(count));                    
                elseif nan_value(2) == 0 % Pd has value
                    pd = value(2);
                    count = obj.count_given_pd(count, pd);
                else
                    count = count / sum(sum(count));
                end
            end
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
        % match_count
        %
        function count = match_count(obj, domain, value)
            [r, ~] = size(domain);
            test = domain == (ones(r, 1) * value);
            match = sum(test, 2) == 2;
            count = [match(1:(r/2))'; match((r/2+1):r)'];
        end
        
        %
        % count_given_pd
        %
        function count = count_given_pd(~, count, pd)
            if pd == 1
                % keep the first row
                count = [1 0; 0 0] * count;
            else
                % keep the second row
                count = [0 0; 0 1] * count;
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
