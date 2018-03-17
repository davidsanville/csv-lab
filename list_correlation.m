function res = list_correlation(f1, f2, num_intervals)

    d=round(size(f1,1)/num_intervals);
    for i=1:num_intervals
        disp(find_correlation(f1,f2,i*num_intervals,i*num_intervals + d ));
    end
res = -1;
end