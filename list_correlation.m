function res = list_correlation(f1, f2, num_intervals)
    
    B =[];
    d=round(size(f1,1)/num_intervals);
    for i=1:num_intervals
        A = find_correlation(f1,f2,i*num_intervals,i*num_intervals + d );
        disp ("Interval: " + i); disp(A);
        %disp (A(1)); %disp(A(2)); disp(A(1,1));
        B= [B ; A ];
    end
res = B;
end