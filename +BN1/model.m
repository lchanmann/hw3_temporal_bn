classdef model
    % MODEL - BN1 prediction
    %   Compute probability of 'Pd' given the evidences
    
    properties
        P_Pd;
        P_Xb_given_Pd;
        P_Xh_given_Pd;
        P_Xt_given_Pd;
    end
    
    methods
        %
        % Initializer
        %
        function obj = model( ...
            P_Pd, P_Xb_given_Pd, P_Xh_given_Pd, P_Xt_given_Pd)
        
            obj.P_Pd = P_Pd;
            % Add total of probability as the last column
            obj.P_Xb_given_Pd = [P_Xb_given_Pd ones(2,1)];
            obj.P_Xh_given_Pd = [P_Xh_given_Pd ones(2,1)];
            obj.P_Xt_given_Pd = [P_Xt_given_Pd ones(2,1)];
        end
        
        %
        % Compute P(pd|e)
        %
        function P = predict(obj, pd, e)
            p_pd_is_1 = obj.p_pd(1);
            p_xb_given_pd_is_1 = obj.p_x_given_pd(e(1), 1, obj.P_Xb_given_Pd);
            p_xh_given_pd_is_1 = obj.p_x_given_pd(e(2), 1, obj.P_Xh_given_Pd);
            p_xt_given_pd_is_1 = obj.p_x_given_pd(e(3), 1, obj.P_Xt_given_Pd);
           
            p_pd_is_0 = obj.p_pd(0);
            p_xb_given_pd_is_0 = obj.p_x_given_pd(e(1), 0, obj.P_Xb_given_Pd);
            p_xh_given_pd_is_0 = obj.p_x_given_pd(e(2), 0, obj.P_Xh_given_Pd);
            p_xt_given_pd_is_0 = obj.p_x_given_pd(e(3), 0, obj.P_Xt_given_Pd);
            
            P_normalized = [ ...
              p_pd_is_1 * p_xb_given_pd_is_1 * p_xh_given_pd_is_1 * p_xt_given_pd_is_1 ...
              p_pd_is_0 * p_xb_given_pd_is_0 * p_xh_given_pd_is_0 * p_xt_given_pd_is_0
            ];
            P = P_normalized(obj.pd_row(pd)) / sum(P_normalized);
        end
    end
    
    %
    % private functions
    %
    methods(Access = private)
        %
        % Lookup P(x|pd) probability from CPT
        %
        function P = p_x_given_pd(obj, x, pd, cpt)
            P = cpt(obj.pd_row(pd), obj.x_column(x));
        end
        
        %
        % Lookup P(pd) from CPT
        %
        function P = p_pd(obj, pd)
            P = obj.P_Pd(obj.pd_row(pd));
        end
        
        %
        % Map Pd values {1 0} to row [1 2] in the CPT
        %
        function r = pd_row(~, pd)
            pds = [1 0];
            rows = [1 2];
            
            r = rows(pds == pd);
        end
        
        %
        % Map the values {H, M, L , -} to column [1 2 3 4]
        %
        function c = x_column(~, x)
            if isnan(x)
                c = 4;
                return
            end
            
            xs = ['H' 'M' 'L'];
            columns = [1 2 3];
            
            c = columns(xs == x);
        end
    end
end
