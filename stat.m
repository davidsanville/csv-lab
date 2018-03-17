function corr = find_correlation(x, y, max_range, min_range)
    x1 = x(min_range, max_range);
    y1 = y(min_range, max_range);
    %cov(x1,y1);
    
    corr = cov(1,2);
end