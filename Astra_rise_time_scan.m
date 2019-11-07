%rise time scan

rise_time = [0.2 .3 .4 .5 .6];
pulse_duration = [3 3 3 3 3];
m2ps = 3.33*1e3;
figure(1)
emittance = [];
emittance_initial = [];

for i=2:5
    fname = ['inject_tophat_batch_run' ];
    y=load([fname '.0800.00' num2str(i)]);
    emit = load([fname '.Xemit.00' num2str(i)]);
    emittance = [emittance emit(end,6)];
    emittance_initial = [emittance_initial emit(1,6)];
    
    subplot(2,3,i)
    hist(y(2:end,3)*m2ps,200);
    title([num2str(pulse_duration(i)) ' ps, ' num2str(rise_time(i)) 'ps'])
    axis([-3,3, -inf, inf])
end

figure
hold on
plot(rise_time(2:end),emittance,'-o')
plot(rise_time(2:end),emittance_initial,'r--o')
