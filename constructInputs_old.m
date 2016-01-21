function NVP_parameters = constructInputs(...
    initProd_ajustment,...
    q0,...
    drillCost,...
    comCost,...
    royaltiesAndTaxes,...
    operatingCost,...
    fixedOperCost,...
    discountRate,...
    timeHorizon,...
    D,...
    b)
% To make it easier to pass on function variables into the function of
% NPV-estimation, we here make a struct which is sent instead. 
% OUTPUT: A struct containing all the input variables for NPV estimation. 
% INPUT: All input variable are optional. 
global T

%% Default values used in Excel model made by
% John Kemp, Senior Market Analyst, Reuters
% Twitter: @JKempEnergy
% Phone: +44 7789 483 325
% Check if variables exist or are unset:
%if(~exist('oilPrice','var') || isempty(oilPrice));     oilPrice = 50;  end%[USD/bbl] Oil price  (wellhead).
if(~exist('q0','var') || isempty(q0));           q0 = 644;       end%[bbl/day] Initial production rate.
if(~exist('drillCost','var') || isempty(drillCost));    drillCost = 5e6;end%[USD] One-time drilling cost
if(~exist('comCost','var')   || isempty(comCost));      comCost = 5e6;  end%[USD] One-time completion cost
if(~exist('drillTime','var') || isempty(drillTime));    drillTime = 1;end
if(~exist('comTime','var')   || isempty(comTime));      comTime = 1;  end
if(~exist('royaltiesAndTaxes','var')   || isempty(royaltiesAndTaxes));  royaltiesAndTaxes = 0.30; end%[percentage]
if(~exist('operatingCost','var')   || isempty(operatingCost));  operatingCost = 10; end%[USD/bbl] Variable
if(~exist('fixedOperCost','var')   || isempty(fixedOperCost));   fixedOperCost = 0;  end%[USD/bbl] Fixed
if(~exist('discountRate','var')   || isempty(discountRate));    discountRate = .10; end%[percentage] Discount rate
% Time horizon: [months] Number of months used when computing NPV.
if(~exist('timeHorizon','var')   || isempty(timeHorizon));  timeHorizon = 240;  end 
if(~exist('D','var')   || isempty(D));  D = .237; end % Decline curve parameter 1 (initial decline rate)
if(~exist('b','var')   || isempty(b));  b = .927; end % Decline curve parameter 2 (curvature of line)
if(~exist('initProd_ajustment','var')   || isempty(initProd_ajustment)); initProd_ajustment = ones(1,T); end

if(~exist('decommissioned','var')   || isempty(decommissioned));  decommissioned = T; end
%%

% Values used by Lennea Lund et al (2014)
%b = 1.08;
%D = .309;



% OUTPUT: The struct
NVP_parameters = struct(...
    'q0',q0,...
    'drillCost',drillCost,...
    'comCost',comCost,...
    'drillTime',drillTime,...
    'comTime',comTime,...
    'royaltiesAndTaxes',royaltiesAndTaxes,...
    'operatingCost',operatingCost,...
    'fixedOperCost',fixedOperCost,...
    'discountRate',discountRate,...
    'timeHorizon',timeHorizon,...
    'D',D,...
    'b',b,...
    'initProd_ajustment',initProd_ajustment,...
    'decommissioned',decommissioned);
end

