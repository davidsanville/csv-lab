function corr_list = correlation_intervals(d1, d2, n_intervals)

%num_intervals = 5;
spacing = floor(size(d1,1) / n_intervals);  
sz1 = size(d1,1); sz2 = size(d2,1);
assert(sz1 == sz2);

Corr_ = zeros(n_intervals);
for c =1:n_intervals
    s = 1 + (c-1)*spacing; 
    f= s+ spacing;

    denominator = std(d1(s:f)) * std(d2(s:f));
    corr = cov(d1(s:f), d2(s:f)) / denominator;
    Corr_(c) = corr(1,2);
    %disp("interval " +c+ ": " +s + " to " + f); disp(corr);
end 

%plot(Corr_);


corr_list = Corr_;
end