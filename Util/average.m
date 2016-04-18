n = 200;
dat = sumBuf.Data;
tim = sumBuf.Time;
entries = floor(length(dat)/n);
total = entries *n;
sumAveraged = zeros(entries,1);
sumAveragedTime = zeros(entries,1);

for i=[1:entries]
    sumAveraged(i) = mean(dat([(i-1)*n+1:i*n]));
    sumAveragedTime(i) = tim(floor((i-0.5)*n));
end
figure
plot(sumAveragedTime,sumAveraged)
