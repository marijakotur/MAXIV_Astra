%astra output analysis
% close all
clear y
clear scan_param2
clear scan_param
clear scan_param3
clear emit
clear Ez_rms
clear rms_pulse_duration

% % C:\Users\markot\Documents\ASTRA_simulations\pulse_duration\phase2_scan14
% scan_param = 25:5:50;
% scan_param_str = '\phi_2 [deg]';
% scan_param_name = 'MAXB';
% ind = 1:length(scan_param);

% C:\Users\markot\Documents\ASTRA_simulations\short_rise_time\solenoid_scan1
% scan_param = 0.1947:0.001:0.1967;
scan_param_flag = 4; %1 == MAXB(1)
%2 == PHI(1)
%3 == PHI(2)
% 4 == general

% ind = 1:length(scan_param);

m2ps = 3.33*1e3;
zstop_str = '80';

filelist = dir;
max_ind=1;
for j=1:length(filelist)
    if length(filelist(j).name)>3
        if filelist(j).name(end-5:end-1)==[zstop_str '.00']
            max_ind=max(str2num(filelist(j).name(end)),max_ind);
        end
    end
end

figure(3)
hold on
for i=1:max_ind
    %foldername = ['tophat_' num2str(10*pulse_duration(i)) 'ps_05ps_34mm_100pC_50k'];
    filename = ['inject_tophat_batch_run.0' zstop_str '0.00' num2str(i)];
    logfilename = ['inject_tophat_batch_run.Log.00' num2str(i)];
    A=fileread(logfilename);
    switch scan_param_flag
        case 1
            B=strfind(A, 'MAXB');
            scan_param(i)=str2num(A(B(2)+11:B(2)+20));
            scan_param_str = 'B field [T]';
        case 2
            B=strfind(A, 'PHI');
            scan_param(i)=str2num(A(B(2)+37:B(2)+41));
            scan_param_str = '\phi_1 [deg]';
        case 3
            B=strfind(A, 'PHI');
            scan_param(i)=str2num(A(B(2)+61:B(2)+66));
            scan_param_str = '\phi_2 [deg]';
        case 4
            B1=strfind(A, 'MAXB');
            scan_param(i)=str2num(A(B1(2)+11:B1(2)+20));
            scan_param_str = 'B field [T]';
            B2=strfind(A, 'PHI');
            scan_param2(i)=str2num(A(B2(2)+37:B2(2)+41));
            scan_param_str2 = '\phi_1 [deg]';
            scan_param3(i)=str2num(A(B2(2)+61:B2(2)+66));
            scan_param_str3 = '\phi_2 [deg]';
    end
    
    y=load(filename);
    %     figure(3)
    subplot(2,3,i)
    hold on
    %     hist(y(2:end,3)*m2ps,200);
    plot(y(2:end,3)*m2ps,y(2:end,6),'.')
    xlabel('t [ps]')
    ylabel('E_z')
    Ez_rms(i) = rms(y(2:end,6));
    
    z_dist = y(2:end,3);
    %     rms_pulse_duration(i) = sqrt(sum(y(2:end,3).^2)/length(y(2:end,3)))*m2ps;
    [counts,centers] = hist(y(2:end,3)*m2ps,75);
    rms_pulse_duration(i) = fwhm(centers,counts);
    %     pulse_duration_str = ['\tau_{RMS}=' num2str(rms_pulse_duration, '%10.2f') 'ps'];
    title([num2str(scan_param(i)) ' [deg]']);
    %    title([num2str(pulse_duration(ind(i))) ' ps' ', ' num2str(charge(i)) 'pC' ])
    if i>4
        xlabel('Time [ps]')
    end
    axis tight
    %     axis([-3,3, -inf, inf])
    %     axis([ -inf, inf,-20*1e5,20*1e5])
    t=load(['inject_tophat_batch_run.Xemit.00' num2str(i)]);
    emit(i)=t(end,6);
end

figure(4)
hold on
subplot('Position',[0.1 0.25 0.22 0.6])
hold on
plot(scan_param,emit,'-o')
title('hor. emittance')
box on
axis tight
xlabel(scan_param_str)
ylabel('Emittance [\pi\mum]')

subplot('Position',[0.44 0.25 0.22 0.6])
hold on
plot(scan_param,Ez_rms,'-o')
xlabel(scan_param_str)
ylabel('RMS E_z [V/m]')
title('E_z spread')
box on
axis tight

subplot('Position',[0.76 0.25 0.22 0.6])
hold on
plot(scan_param,rms_pulse_duration,'-o')
xlabel(scan_param_str)
ylabel('RMS \tau [ps]')
title('RMS bunch length')
box on
axis tight

if scan_param_flag == 4
    figure(5)
    hold on
    stem3(scan_param,scan_param2,emit,'-o')
    figure(6)
    hold on
%     stem3(scan_param3,scan_param2,rms_pulse_duration,'s')
    stem3(scan_param3,scan_param2,Ez_rms,'s')
    figure(7)
    hold on
%     stem3(scan_param3,scan_param2,rms_pulse_duration,'s')
    stem3(scan_param3,scan_param2,rms_pulse_duration,'s')

end
% axis([-inf inf -inf inf min(emit)+0.1 max(emit)+0.1])
figure(5)
axis([-inf inf -inf inf 0.25 inf])


% % legend('\phi2 scan1','\phi2 scan2', '\phi2 scan3');
% legend('scan1@B=0.198','scan2@B=0.1952', 'scan3@B=0.198','scan4@B=0.1962');
% title('\phi_1 scans')
% % legend('scan1@\phi_1=30','scan2@\phi_1=30','scan3@\phi_1=30','scan4@\phi_1=42','scan5@\phi_1=42','scan6@\phi_1=40')
% title('Solenoid scans')


% figure
% stem3( reshape(emit,3,[]))
% stem3( pulse_duration,charge, reshape(emit,2,[]))