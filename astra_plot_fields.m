%astra_plot_fields


y1=load('photo-20150304.dat');
p1 = 0;

y2=load('radiabeam-sol-fitted-20141022.dat');
p2 = -0.089;

y3=load('TWS_S-max3_raw.dat');
p3 = 1.5005;


figure
hold on

plot(y1(:,1)+p1,y1(:,2)/30,'b')
plot(y2(:,1)+p2,y2(:,2)*30,'r')
plot(y3(:,1)+p3,y3(:,2),'g')

axis tight

legend('gun /30','solenoid *30','L00','location','best')