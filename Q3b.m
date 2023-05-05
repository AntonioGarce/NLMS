clc,close all,clear all
N=40;
L=1000;

mse = zeros(L,1);
adelta_h =zeros(L,1);
for k=1:30
    mu = 0.1*k;
    avemse=0;
    mse=0;
    adelta_h=0;
    for i = 1:40
        u = randn(L,1);
        h = randn(50,1);
        d = filter(h,1,u);
        delta_h = zeros(L,1);

        nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS', 'StepSize' , mu);
        [y,e,w] = nlms(u,d);
        [mmse,emse] = msepred(nlms,u,d);
        [yy,ee,ww] = NLMS(u,d,mu,0.1,N);
        avemse=avemse+emse;
        mse=mse + ee.^2;

        adelta_h=adelta_h+delta_h;
        for j = 1:L
            ww_ = ww(:,j);
            for kk = N:50
             ww_(kk)=0;
            end
           delta_h(j) = (norm(ww_-h)/norm(h)).^2;
        end
        adelta_h=adelta_h+delta_h;
    end 
     subplot(2,1,1);
    plot(1:length(ee),mse/40,'b');
    title(['average squared errors' 'N=35' '  \mu=', num2str(mu), 'emse=' num2str(avemse/40)])
    subplot(2,1,2);
    plot(1:length(e),adelta_h/40,'b');
    title([ 'average filter coefficient erorrs' ])
    pause(1)
    str=['Q3b/' num2str(k),'.jpg'];
    saveas(gcf,str)
end
