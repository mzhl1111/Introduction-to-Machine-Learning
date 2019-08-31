function[proba probb] = max_abs(N,mu)

proba = zeros(1,10000);
probb = zeros(1,10000);
record = zeros(1,10000);
nnnn = 0;
for j = 1:10000
    epsilon = j/10000;
    
    for i = 1:10000
        rng(i);
        c1 = randi([0,1],1,N);
        nu1 = mean(c1);
        rng(i+10000);
        c2 = randi([0,1],1,N);
        nu2= mean(c2);
        m = max(abs(nu1-mu),abs(nu2-mu));
        record(i) = m > epsilon ;
    
    end 

    proba(j) = mean(record);
    probb(j) = 4 * exp(-12 * epsilon^2);
    nnnn = nnnn+1
end

end


    