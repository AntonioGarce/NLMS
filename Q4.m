clc,close all,clear all
N=50;

[u,Fs]=audioread('ronald.wav');

L=length(u);
h = randn(50,1);

for k=1:30
    mu = k*0.1;  
    d = filter(h,1,u);
    nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS', 'StepSize' , mu);
    [y,e,w] = nlms(u,d);
    [yy,ee,ww] = NLMS(u,d,mu,0.1,N);
    [mmse,emse] = msepred(nlms,u,d);
    subplot(3,1,1);
    plot((1:length(ee))/Fs,ee.^2,'b');
    delta_h = zeros(L,1);
    for j = 1:L
        delta_h(j) = (norm(ww(:,j)-h)/norm(h)).^2;
    end
    subplot(3,1,2);
    plot((1:length(e))/Fs,delta_h,'b');
    subplot(3,1,3);
    plot((1:length(d))/Fs,d,'b',1:length(y),y,'r--');
    title(['\mu=', num2str(mu), ', EMSE=' num2str(emse)])
    pause(1)
    str=['Q4a/' num2str(k) '.jpg'];
    saveas(gcf,str)
end
