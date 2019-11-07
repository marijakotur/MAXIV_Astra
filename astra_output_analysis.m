%astra output analysis
close all

%cd('C:\Users\markot\Documents\ASTRA_simulations\pulse_duration')
% pulse_duration = [ 3 6 8 10 1.4];
% pulse_duration = [1.4 2 3 6 8];
%pulse_duration = [1.4 1.4 3 3 6 6];
% charge = [ 50 25 50 25 50 25];
% [pd, ind] = sort(pulse_duration);

%C:\Users\markot\Documents\ASTRA_simulations\pulse_duration\charge_pulse_duration_scan3
pulse_duration = [1.4 1.4 3 3 6 6 ];
charge = [ 40 60 40 60 40 60];
[pd, ind] = sort(pulse_duration);
no_plots = length(pulse_duration);
length(charge);

% %C:\Users\markot\Documents\ASTRA_simulations\pulse_duration\charge_pulse_duration_scan2
% pulse_duration = [1.4 1.4 3 3 6 6 ];
% charge = [ 40 60 40 60 40 60];
% [pd, ind] = sort(pulse_duration);
% no_plots = length(pulse_duration);
% length(charge);

m2ps = 3.33*1e3;


figure
for i=1:length(ind)
    %foldername = ['tophat_' num2str(10*pulse_duration(i)) 'ps_05ps_34mm_100pC_50k'];
    filename = ['inject_tophat_batch_run.0800.00' num2str(ind(i))];
    %cd(foldername)
    y=load(filename);
    subplot(3,2,i)
    hist(y(2:end,3)*m2ps,200);
    z_dist = y(2:end,3);
    rms_pulse_duration = sqrt(sum(y(2:end,3).^2)/length(y(2:end,3)))*m2ps;
    pulse_duration_str = ['\tau_{RMS}=' num2str(rms_pulse_duration, '%10.2f') 'ps'];
    title([num2str(pulse_duration(ind(i))) ' ps, ' num2str(charge(ind(i))) 'pC, ' pulse_duration_str])
    %    title([num2str(pulse_duration(ind(i))) ' ps' ', ' num2str(charge(i)) 'pC' ])
    if i>4
        xlabel('Time [ps]')
    end
    axis([-3,3, -inf, inf])
    t=load(['inject_tophat_batch_run.Xemit.00' num2str(i)]);
    emit(i)=t(end,6);
end

% figure
% stem3( reshape(emit,3,[]))
% stem3( pulse_duration,charge, reshape(emit,2,[]))