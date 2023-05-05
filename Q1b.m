clc,close all,clear all
N=50;
L=1000;

for k=1:30
  mu = k*0.1;  
for i = 1:4
    u = randn(L,1);
    h = randn(50,1);
    d = filter(h,1,u);
    
    nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS', 'StepSize' , mu);
    [y,e,w] = nlms(u,d);
    [yy,ee,ww] = NLMS(u,d,mu,0.1,N);
    [mmse,emse] = msepred(nlms,u,d);
    subplot(3,1,1);
    plot(1:length(ee),ee.^2,'b');
    delta_h = zeros(L,1);
    for j = 1:L
        delta_h(j) = (norm(ww(:,j)-h)/norm(h)).^2;
    end
    subplot(3,1,2);
    plot(1:length(e),delta_h,'b');
    subplot(3,1,3);
    plot(1:length(d),d,'b',1:length(y),y,'r--');
    title(['\mu=', num2str(mu), ', EMSE=' num2str(emse)])
    pause(1)
    str=['Q1b/result (' num2str(k), ')/' num2str(i) '.jpg'];
    saveas(gcf,str)
end 
end
