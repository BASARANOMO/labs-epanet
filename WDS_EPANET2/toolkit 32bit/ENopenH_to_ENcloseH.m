clc;
clear;
%%  load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
end

%% Open the Net1.inp file
[err] = calllib('epanet2','ENopen','Net1.inp','Net_rpt','');

%% Set some parameters and get some data
% Get the index number of id '12'
id = '12';index = 0;
[err,id,index] = calllib('epanet2','ENgetnodeindex',id,index);


%% Run the hydraulic simulation 
[err] = calllib('epanet2','ENopenH');
[err] = calllib('epanet2','ENinitH',0);
t = 0; tstep = 3600; pressure_matrix = []; m = 1;
while tstep > 0
    [err,t] = calllib('epanet2','ENrunH',t);
    % Get the node pressure 
    if mod(t,3600) == 0
        node_pressure =0 ;
        [err,node_pressure] = calllib('epanet2','ENgetnodevalue',index,11,node_pressure);
        pressure_matrix(m) = node_pressure;
        m = m + 1;
    end
    [err,tstep] = calllib('epanet2','ENnextH',tstep);
end
[err] = calllib('epanet2','ENcloseH');

%% Close the Net1.inp file and unload the epanet library
[err] = calllib('epanet2','ENclose');
unloadlibrary('epanet2');

%% Submit the chart
%Please learn the function "plot" in matlab.
figure
plot(0:1:24,pressure_matrix,'-'); 
xlabel('Time/hours');
ylabel('Pressure/psi');
grid on;






