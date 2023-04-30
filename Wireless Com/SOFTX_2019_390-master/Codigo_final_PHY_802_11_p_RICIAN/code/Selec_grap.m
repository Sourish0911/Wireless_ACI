%% Main menu
% It presents a menu to obtain the graphs of the:
%
% * 1.Physical layer
%
% * 2.Theoretical models
%
% * 3.Physical layer vs Theoretical models
close all;
fprintf('The options are:\n');
fprintf('1.Physical layer \n2.Theoretical models\n3.Physical layer vs Theoretical models');
op=input('\nSelect the graph you want to obtain: ');
%%
% Depending on the option selected, a menu with the channel options is
% presented
%
% * 1. Rural Line-of-Sight
%
% * 2. Urban Line-of-Sight
%
% * 3. Highway Line-of-Sight
%
% * 4. Highway Non-Line-of-Sight

if (op==1)||(op==3)
fprintf('1.Rural Line-of-Sight \n2.Urban Line-of-Sight\n3.Highway Line-of-Sight\n4.Highway Non-Line-of-Sight');
channel=input('\nSelect the channel you want to use: ');
else
    channel=1;
end

%%
% Depending on the option selected, the corresponding functions 
% are called to display the graphs.
if op==1
    phy_lay(channel);
elseif op==2
    the_mod(channel);
elseif op==3
    phy_vs_the(channel);
else 
    fprintf('It is not among the options');
end

%%
% *See also*
%
% <phy_lay.html Physical layer graph>
%
% <the_mod.html Theorical PER models graph>
%
% <phy_vs_the.html Theorical PER models vs Physical layer graph> 