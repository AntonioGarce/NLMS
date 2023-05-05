clc,close all,clear all
N=50;
L=1000;
u = randn(L,1);
h = randn(50,1);
d = filter(h,1,u);

nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS');
[mumax,mumaxsenlms] = maxstep(nlms,u);

for i = 1:50
    mu = 2*mumax*i/50;
    nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS', 'StepSize' , mu);
    [y,e,w] = nlms(u,d);
    [mmse,emse] = msepred(nlms,u,d);
    plot(1:length(d),d,'b',1:length(y),y,'r--');
    title(['\mu=', num2str(mu), ', EMSE=' num2str(emse)])
    pause(1)
    str=['Q1a/' num2str(i),'.jpg'];
    saveas(gcf,str)
end 
