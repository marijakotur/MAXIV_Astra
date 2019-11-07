clear all
close all

figure
hold on
fname = ['gauss_14ps_20mm_60pC_50k.ini']
y=load(fname);

[N,edges] = histcounts(y(:,7),100);
plot(edges(1:end-1),N)

fit = [max(N) 0 0.0006 0]
fit = fitcurvedemo_gaussian(edges(1:end-1),N,fit)y

A1 = fit(1);
x_0 = fit(2);
A2 = fit(3);
B = fit(4);
xdata = edges(1:end-1);
FittedCurve = A1 * exp(- (xdata-x_0).^2/(2*A2^2)) + B;
plot(xdata,FittedCurve)

fwhm = 2.35482*fit(3)*1000 %in ps

    subplot(3,2,i)
hist(y(2:end,4)*3.33*1e3,100)

% shift distribution by shifting every other delay
delay = 1.650*1e-3; %in ns, 825fs per mm of alpha-BBO
shift_matrix = repmat([-delay/2; delay/2], size(y,1)/2, 1);
y(:,7) = y(:,7) + shift_matrix;

[N,edges] = histcounts(y(:,7),100);
plot(edges(1:end-1),N,'g')

%modify the spatial distribution
fname = ['gauss_14ps_20mm_60pC_50k.ini'];
y=load(fname);
% for j=1:length(y)
%     if ((y(:,1)+3/4).^2+(y(:,2)).^2)>(1/4)^2;
%         y(:,8)=0;§
%     end
% end
 
for j=1:length(y)
    if rem(j,3)==1
        y(j,1)=(y(j,1)/7-3/4*1e-3);
        y(j,2)=y(j,2)/7;
    elseif rem(j,3)==2
        y(j,1)=(y(j,1)/7+3/8*1e-3);
        y(j,2)=y(j,2)/7+3/8*sqrt(3)*1e-3;
    else
        y(j,1)=(y(j,1)/7+3/8*1e-3);
        y(j,2)=y(j,2)/7-3/8*sqrt(3)*1e-3;
    end
end

save('gauss_14ps_20mm_60pC_50k_shifted2.ini','y','-ascii')
figure
hold on
plot(z(:,1),z(:,2),'.')
axis equal
