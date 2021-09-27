clc;
clear;
%%  load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
    end

%% Open the Net1.inp file
[err] = calllib('epanet2','ENopen','./Net1.inp','Net_rpt','');
if err==0
    disp('Net1.inp Was Opend successfully !');
end

%%  Get the index of a node (11, 12 or 22...) and get its base demand 
% Get index
id = input('Enter the node id in single quotes: '); index = 0;  %% input node 11 is: '11'
[err,id,index] = calllib('epanet2','ENgetnodeindex',id,index);
disp('The index is: ');
disp(index);
% Get Base Demand 
value = 0;
[err,value] = calllib('epanet2','ENgetnodevalue',index,0,value);
disp('The base demand of this node is: ');
disp(value);
%the number 1 indicates base demand, 11 indicates pressure... more
% information is provided in ToolKit

% %% Get the link index of a link (111 or ...) 
% linkid = input('Enter the link id in single quotes: '); linkindex = 0; 
% [err,linkid,linkindex] = calllib('epanet2','ENgetlinkindex',linkid,linkindex);
% disp('The index is: ');
% disp(linkindex);
% Please try to get some values of this link by learning the ToolKit

