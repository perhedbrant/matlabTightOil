function well = createWell(input,T)
% Creates a well:
% Output: A struct (Matlab object) 
% containing all the attributes of the well. 
% 
% INPUT: q0,drillTime,compTime,royaltiesAndTaxes,
% operatingCost,fixedOperCost,discountRate,b,D,T
global distribution_b distribution_D distribution_q0
global stochasticInitialProduction stochasticDeclinecurveVariables

q = zeros(T,1);  % [avg bbl/day] Time serie of production.

% [months] Counter of the how many months the well is in production:
prodTime = -input.drillTime -input.comTime;


% Default values are given in 'constructInputs.m':

% if(isempty(input.drillCost)); input.drillCost = 5e6;end%[USD] One-time drilling cost
% if(isempty(input.comCost));   input.comCost = 5e6;  end%[USD] One-time completion cost
% if(isempty(input.royaltiesAndTaxes));  input.royaltiesAndTaxes = 0.30; end%[percentage]
% if(isempty(input.operatingCost));   input.operatingCost = 10; end%[USD/bbl] Variable
% if(isempty(input.fixedOperCost));   input.fixedOperCost = 500;end%[USD/bbl] Fixed
% if(isempty(input.discountRate));    input.discountRate = .10; end%[percentage] Discount rate
%
% %[month] The month when the well is taken out of service. 
% if(isempty(input.decommissioned)); input.decommissioned = T; end 


% Decline curve parameters:
if(stochasticDeclinecurveVariables)
    input.b = parameter_b(distribution_b);
    input.D = parameter_D(distribution_D); 
end % Else default values are used in 'constructInputs.m'.

% Initial production
if(stochasticInitialProduction)
    input.b = parameter_q0(distribution_q0);
end 


% ________OLD_______ Initial production adjustment:
% if(length(input.initProd_ajustment)==1)
%     input.q0 = input.q0 * input.initProd_ajustment;
% elseif(length(input.initProd_ajustment)==T && exist('t','var'))
%     input.q0 = input.q0 * input.initProd_ajustment(t);
% elseif(exist('input.initProd_ajustment','var'))
%     adj = mean(input.initProd_ajustment);
%     input.q0 = input.q0 * adj;
% end 
%____________________________________________   

well = struct('q0',input.q0,...
    'q',q,...
    'b',input.b,...
    'D',input.D,...
    'prodTime',prodTime,...
    'drillCost',input.drillCost,...
    'comCost',input.comCost,...
    'royaltiesAndTaxes',input.royaltiesAndTaxes,...
    'operatingCost',input.operatingCost,...
    'fixedOperCost',input.fixedOperCost,...
    'decommissioned',input.decommissioned);
end

