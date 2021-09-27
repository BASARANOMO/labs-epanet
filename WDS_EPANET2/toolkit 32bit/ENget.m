clc;
clear;
%%  load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
    end

%% Open the Net1.inp file
[err] = calllib('epanet2','ENopen','Net1.inp','Net_rpt','');

%%  Get the index of a node (11, 12 or 22...) and get its base demand 
% Get index
id = input('Enter the node id in single quotes: '); index = 0;
[err,id,index] = calllib('epanet2','ENgetnodeindex',id,index);
disp('The index is: ');
disp(index);
% Get pressure 
node_demand = 0;
[err,node_demand] = calllib('epanet2','ENgetnodevalue',index,1,node_demand);
disp('The base demand of this node is: ');
disp(node_demand);
%the number 1 indicates base demand, 11 indicates pressure... more
% information is provided in toolkit

%% Get the link index of a link (111 or ...) 
linkid = input('Enter the link id in single quotes: '); linkindex = 0; 
[err,linkid,linkindex] = calllib('epanet2','ENgetlinkindex',linkid,linkindex);
disp('The index is: ');
disp(linkindex);
% Please try to get some values of this link by learning the toolkit



