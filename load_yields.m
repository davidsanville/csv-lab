function double_ = load_yields() 
fileID = fopen('DGS10.csv','r');
Data = textscan(fileID, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
fclose(fileID);
%disp(Data);
%disp(Data{1,1}(:,2));
yield10 = Data{1,1}(:,2);

for j = 1:size(Data{1,1},1)
    yield10{j} = str2double(yield10(j));
end
%disp(yield10);

double_ = cell2mat(yield10);
%plot(double_,'bo-');

end
