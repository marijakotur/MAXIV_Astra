%field scan analysis
%   FOM(1)='hor emit',
%   FOM(2)='hor spot',
%   FOM(3)='bunch length'

xlabeltext = 'Phi(1) [deg]'; 
%xlabeltext = 'Field [MV/m]';
% xlabeltext = 'B field [T]';
m2ps = 3.33*1e3;

% close all
scan_files=dir('*.Scan.*')
for i=1:length(scan_files)
    y=load(['inject_tophat_batch_run.Scan.00' num2str(i)]);




% figure(1)
% set(gcf,'unit','pixel','position',[100 100 600 200]);

% subplot('Position',[0.1 0.25 0.22 0.6])
subplot(2,2,1)
hold on
plot(y(:,1),y(:,5)*m2ps/1000,'o-') %FOM(5)
title('RMS bunch length')
xlabel(xlabeltext)
ylabel('\tau [ps]')
axis tight
box on

% subplot('Position',[0.44 0.25 0.22 0.6])
subplot(2,2,2)
hold on
plot(y(:,1),y(:,4),'o-') %FOM(4)
title('hor. spot size')
xlabel(xlabeltext)
ylabel('x [mm]')
axis tight
box on

% subplot('Position',[0.76 0.25 0.22 0.6])
subplot(2,2,3)
hold on
plot(y(:,1),y(:,3),'o-') %FOM(3)
title('hor. emittance')
ylabel('\epsilon [\murad]')
xlabel(xlabeltext)
box on
axis tight

% subplot('Position',[0.76 0.25 0.22 0.6])
subplot(2,2,4)
hold on
plot(y(:,1),y(:,6),'o-') %FOM(3)
title('rms en. spread')
ylabel('\epsilon [\murad]')
xlabel(xlabeltext)
box on
axis tight

end
% legend('\phi_1 scan2','\phi_1 scan3','location','best')
% legend('B_1 scan4','B_1 scan5','B_1 scan6')
% legend('\phi_2 scan9','\phi_2 scan10','\phi_2 scan11','\phi_2 scan12')

