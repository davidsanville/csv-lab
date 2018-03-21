%buggy, unit-test before using

function y= weekday_filer(x)
    Sat = 5; Sun = 6; %data starts on a tuesday
    sz = size(x,1);
    y = zeros(sz,1);
    %y = {};
    for j =1:sz
        if(j==Sat || j==Sun) %need modulo not equals
            y(j) = -1;
        end 
        y(j) = x(j);   
        %append(y, x(j)); handles empty-zeros for result
    end
   %IF not append, need to remove all remaining zeros at Sat/Sun positons
   %then make sure new size match
end