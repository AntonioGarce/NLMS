function [y,err,wts] = NLMS(u,d,mu,alpha,N )  
%%u: input sequence , d:desired sequence ,mu:stepsize, N:filterLength
    L = length(u);
    err = zeros(L,1);
    wts = zeros(N,L);
    y = zeros(L,1);
    if (L ~= length(d))
        error([ 'The length of input argument ''d'' is ' ...
        ' different from the length of ''x''.' ]);
    end
    if (isempty(N))
        N = 50;
    end 
    if (isempty(alpha))
        alpha = 0; 
    end
    weights = zeros(N,1);
    filo = zeros(N,1);
    for i = 1:L
        filo(2:N) = filo(1:N-1);
        filo(1) = u(i);
        % Compute the output sample using convolution:
        y(i) =weights'*filo;
        % Update the filter coefficients:
        err(i) = d(i) - y(i);
        weights = weights + mu*err(i)*filo/(alpha+filo'*filo);   
        wts(:,i) = weights;
    end
end