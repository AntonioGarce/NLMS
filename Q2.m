clc,close all,clear all
N=60;
L=1000;

mse = zeros(L,1);
adelta_h =zeros(L,1);
for m = 1:4
    N=50+10*m;
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
            for l=51:N
                h(l)=0;
            end
            nlms = dsp.LMSFilter(N, 'Method' , 'Normalized LMS', 'StepSize' , mu);
            [y,e,w] = nlms(u,d);
            [mmse,emse] = msepred(nlms,u,d);
            [yy,ee,ww] = NLMS(u,d,mu,0.1,N);
            avemse=avemse+emse;
            mse=mse + ee.^2;
            for j = 1:L
               delta_h(j) = (norm(ww(:,j)-h)/norm(h)).^2;
            end
            adelta_h=adelta_h+delta_h;
        %     subplot(3,1,1);
        %     plot(1:length(ee),ee.^2,'b');
            delta_h = zeros(L,1);

            for j = 1:L
                delta_h(j) = (norm(ww(:,j)-h)/norm(h)).^2;
            end

        %     subplot(3,1,2);
        %     plot(1:length(e),delta_h,'b');
        %     subplot(3,1,3);
        %     plot(1:length(d),d,'b',1:length(y),y,'r--');
        %     title(['\mu=', num2str(mu)])
        %     pause(1)
        %     str=['Q1c/' num2str(i),'.jpg'];
        %     saveas(gcf,str)
        end 
         subplot(2,1,1);
        plot(1:length(ee),mse/40,'b');
        title(['average squared errors' '  \mu=', num2str(mu), 'emse=' num2str(avemse/40)])
        subplot(2,1,2);
        plot(1:length(e),adelta_h/40,'b');
        title(['average filter coefficient erorrs' ])
        pause(1)
        str=['Q2/result (' num2str(m) ')/' num2str(k),'.jpg'];
        saveas(gcf,str)
    end
end
