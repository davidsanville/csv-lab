%dont run external functions (call from main, and run main)

function res = derivate(x)
    %disp(x);
    sz = size(x,1)-1; %cant get last point
    der = zeros(sz,1);
    for j = 1:sz
        der(j) = (x(j+1) - x(j)) / x(j);
    end 
    res = der;
end