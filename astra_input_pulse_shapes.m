figure
hold on



y=load('C:\Users\markot\Documents\ASTRA_simulations\double_gaussian_14ps_60pC\double_gauss_14ps_20mm_60pC_50k.ini');
Nbins = round((max(y(:,7))-min(y(:,7)))/3.4e-5);
[N,edges] = histcounts(y(:,7),Nbins);
plot(edges(1:end-1)*1000,N)

y=load('C:\Users\markot\Documents\ASTRA_simulations\pulse_duration\tophat_30ps_05ps_20mm_60pC_50k.ini');
Nbins = round((max(y(:,7))-min(y(:,7)))/3.4e-5);
[N,edges] = histcounts(y(:,7),Nbins);
plot(edges(1:end-1)*1000,N)

y=load('C:\Users\markot\Documents\ASTRA_simulations\short_rise_time\tophat_30ps_01ps_20mm_60pC_50k.ini');
Nbins = round((max(y(:,7))-min(y(:,7)))/3.4e-5);
[N,edges] = histcounts(y(:,7),Nbins);
plot(edges(1:end-1)*1000,N)

y=load('C:\Users\markot\Documents\ASTRA_simulations\shaped_pulse1\shape1_60pC_50k.ini');
Nbins = round((max(y(:,7))-min(y(:,7)))/3.4e-5);
[N,edges] = histcounts(y(:,7),Nbins);
plot(edges(1:end-1)*1000,N)
