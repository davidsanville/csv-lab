function corr = find_correlation(x, y, min, max)
    %x1 = x(min_range, max_range);
    x1 = x(min:max);
    y1 = y(min:max);
    %cov(x1,y1);
  
    covariance = cov(x1,y1);
    corr = covariance / (std(x) * std(y));
end