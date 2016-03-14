n = 35000;
dat = sumBuf.Data;
entries = floor(length(dat)/n);
total = entries *n;
sumAveraged = zeros(entries,1);

for i=[1:entries]
    sumAveraged(i) = mean(dat([(i-1)*n+1:i*n]));
end

plot(sumAveraged)