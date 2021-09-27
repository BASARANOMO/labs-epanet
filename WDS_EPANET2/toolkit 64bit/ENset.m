clc;
clear;

%% Load the epanet library
if ~libisloaded('epanet2')
    loadlibrary('epanet2','epanet2.h');
end

%% Open the Net1.inp
[err] = calllib('epanet2','ENopen','Net1.inp','Net_rpt','');
if err==0
    disp('Net1.inp Was Opend successfully !');
end

%% Set the simulation duration to be 48h
% Check the original duration
duration = 0;
[err,duration] = calllib('epanet2','ENgettimeparam',0,duration);
disp('The duration is:');
disp(duration/3600);
%Set new duration
duration1 = input('Please type new duration:');
duration1=duration1*3600;
[err] = calllib('epanet2','ENsettimeparam',0,duration1);
%Get new duration
[err,duration] = calllib('epanet2','ENgettimeparam',0,duration);
disp('The new duration is:');
disp(duration/3600);

%% Set the C value of link 111 (C value is the roughness of the pipes)
%Get link index
linkid = '111'; linkindex = 0;
[err,linkid,linkindex] = calllib('epanet2','ENgetlinkindex',linkid,linkindex);
%Get the original C value
roughness = 0;
[err, roughness] = calllib('epanet2','ENgetlinkvalue',linkindex,2,roughness);
disp('The C value (roughness) is:');
disp(roughness);
%Set the C value
roughness1 = input('Please type new C value (roughness):');
[err] = calllib('epanet2','ENsetlinkvalue',linkindex,2,roughness1);
%Get new C value
[err, roughness] = calllib('epanet2','ENgetlinkvalue',linkindex,2,roughness);
disp('The new C value is:');
disp(roughness);

