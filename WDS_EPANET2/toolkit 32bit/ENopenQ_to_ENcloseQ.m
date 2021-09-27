clear;
clc;
%% Load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
end

%% Open the Net1.inp
[err] = calllib('epanet2','ENopen','Net15.inp','Net_rpt','');

%% Set some parameters and get some data
% Get the index number of id '12' and '9'
index = 0;id = '12';
[err,id,index] = calllib('epanet2','ENgetnodeindex',id,index);
indexx=0;idd='9';
[err,idd,indexx] = calllib('epanet2','ENgetnodeindex',idd,indexx);

% Set the quality type to chlorine(chemical)
[err] = calllib('epanet2','ENsetqualtype',1,'chlorine','mg/L','');

% Set the source quality (node 9 is the reservoir)
[err] = calllib('epanet2','ENsetnodevalue',indexx,4,1);

%% Run the hydraulic simulation and water quality simulation
% Run the hydraulic simulation (a compulsary step before quality
% simulation)
[err] = calllib('epanet2','ENsolveH');

% Run the water quality simulation
[err] = calllib('epanet2','ENopenQ');
[err] = calllib('epanet2','ENinitQ',0);
t = 0; tstep = 3600;chlorine_matrix = [];m = 1;
while tstep > 0
    [err,t] = calllib('epanet2','ENrunQ',t);
    % Get the node chlorine concentration
    if mod(t,3600) == 0
        node_chlorine = 0 ;
        [err,node_chlorine] = calllib('epanet2','ENgetnodevalue',index,12,node_chlorine);
        chlorine_matrix(m) = node_chlorine;
        m = m + 1;
    end
    [err,tstep] = calllib('epanet2','ENnextQ',tstep);
end
[err] = calllib('epanet2','ENcloseQ');

%% Close the Net1.inp file and unload the epanet library
[err] = calllib('epanet2','ENclose');
unloadlibrary('epanet2');


%% Submit the chart
%Please learn the function "plot" in matlab.
figure
plot(0:1:24,chlorine_matrix,'-'); 
xlabel('Time/hours');
ylabel('Chlorine/mg/L');
grid on;

