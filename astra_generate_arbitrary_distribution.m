% astra_generate_arbitrary_distribution
clear all
close all

%load distribution data
t=load('C:\Users\markot\Documents\ASTRA_simulations\initial_distributions\Gauss21nm_chirp27_tuckey025_21nm_time.txt');
Intt = load('C:\Users\markot\Documents\ASTRA_simulations\initial_distributions\Gauss21nm_chirp27_tuckey025_21nm_Intt.txt');

t=load('sine_phase_test_time.txt');
Intt = load('sine_phase_test_Intt.txt');

% normalize
Intt = Intt/sum(Intt);

% generate cumulative distribution
Intt_cum = cumsum(Intt);


figure(1)
hold on
plotyy(t,Intt,t,Intt_cum)
% axis tight

% generate y distribution
y_dist = rand(50000,1);

for i=1:length(y_dist)
    t_dist(i)=t(find(Intt_cum>=y_dist(i),1));
    
%     t_dist(i) = t(Intt_cum>cum_dist(i),'first');
end

figure(2)
hist(t_dist,250)

[N,edges] = histcounts(t_dist,200);

figure(3)
hold on
plotyy(t,Intt,edges(1:end-1),N/sum(N))
% axis tight
% plot(edges(1:end-1),N/sum(N),'g')

%% generate output
fname = ['tophat_30ps_01ps_20mm_60pC_50k.ini']
y=load(fname);
y(:,7) = t_dist/1000';

% save('shape1_60pC_50k.ini','y','-ascii')