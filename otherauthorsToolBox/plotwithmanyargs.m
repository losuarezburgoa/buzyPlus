function [ plotHandle ] =plotwithmanyargs( x, y, varargin )
%
% Description:
% Plot with many plot options arguments.
% 
% Input(s):
% Absisa values array (x).
% 
% Ordinate values array (y).
%
% Arguments in order to be effective in the plot function.
%
% Output(s):
% Handle of the plot in order to perform other modifications 
% after the function was run.
%
% Example1:
% myplot(1:10, sin(1:10), 'ok-', 'LineWidth', 2, 'MarkerSize', 4, ...
%     'MarkerEdgeColor', 'r', 'MarkerFaceColor', 'w');
%
%%%%%%%%%
% [ plotHandle ] =plotwithmanyargs( x, y, varargin );
%%%%%%%%%

parserObj =inputParser;
parserObj.KeepUnmatched =true;
parserObj.addOptional('LineSpec','-',@(x) ischar(x) && (numel(x) <= 4));
parserObj.parse(varargin{:});

% your inputs are in Results
myArguments =parserObj.Results;

% plot's arguments are unmatched
plotArgs =struct2pv( parserObj.Unmatched ); 

plotHandle =plot( x, y, myArguments.LineSpec, plotArgs{:} );

end
%
function [ pv_list, pv_array ] =struct2pv( s )
    p =fieldnames(s);
    v =struct2cell(s);
    pv_array =[p, v];
    pv_list =reshape( pv_array', [], 1 )';
end
