%plot spatial distribution

distance = 0.8:0.8:8;

initial = load('gauss_14ps_20mm_60pC_50k_shifted2.ini');

figure
subplot(3,4,1)
plot(initial(:,1),initial(:,2),'.')
axis equal

for j=1:length(distance)
    y=load(['inject_tophat_batch_run.0' num2str(distance(j)*100,'%03.f') '.003']);
    subplot(3,4,j+1)
    plot(y(:,1),y(:,2),'.')
    axis equal
end