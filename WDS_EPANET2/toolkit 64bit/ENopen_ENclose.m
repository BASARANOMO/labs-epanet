clc;
clear;

%%  load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
else
    display('EPANET library is loaded');
end

%% Open the Net1.inp file
[err1] = calllib('epanet2','ENopen','Net1.inp','Net_rpt','');
err1 

%% Open the Net2.inp file
[err2] = calllib('epanet2','ENopen','Net2.inp','Net_rpt','');
err2
if err1==0 & err2==0
 display('Well done! Net1 and Net2 are now open')
end

%% Close the Net1/2.inp file and unload the epanet library
[err] = calllib('epanet2','ENclose');
unloadlibrary('epanet2');
disp('Closes down the Toolkit system !')
