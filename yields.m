
%Fred 10year yield to maturity has patch '.' in data

fileID = fopen('DGS10.csv','r');
Data = textscan(fileID, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
fclose(fileID);
%disp(Data);
disp(Data{1,1}(:,2));
yield10 = Data{1,1}(:,2);

for j = 1:size(Data{1,1},1)
    yield10{j} = str2double(yield10(j));
end
disp(yield10);

double_ = cell2mat(yield10);
plot(double_,'bo-');




%yd = C_text(1); disp(yd{1,1});
%xd = C_text(2); disp(xd{1,1});

%csvwrite('clean10.csv', cell2mat(Data));
%x=linspace(0,180);

%plot(x, yd(:,1));
%disp(fileID(:,1));
