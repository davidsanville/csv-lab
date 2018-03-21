%read CSV files
file1 = fopen('SnPClose.csv','r');
Data1 = textscan(file1, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
fclose = (file1);

file2 = fopen('bitcoin.csv','r');
Data2 = textscan(file2, '%s%s%d', 'Delimiter', ',', 'CollectOutput', 1);
fclose = (file2);

%display read files
%     disp(Data1{1}(:,1)); %S&P dates
%     disp(Data1{1}(:,2)); %S&P prices
%     disp(Data2{1}(:,1)); %BTC dates
%     disp(Data2{1}(:,2)); %BTC prices
        

%removes seconds from time string, for alignment
% for c=1:size(Data2{1,1}, 1)
%     str = (strtok(Data2{1,1}(c,1)));
%     Data2{1,1}(c,1) = str;
%     %disp(Data2{1,1}(c,1));
% end

%filter btc for weekdays
dates_of_weekdays = [];
btc_weekday_indexes = [];
for c=1:size(Data2{1,1}, 1)
    if(mod(c+1,7) == 1) %skip saturday
        continue
    end
    if(mod(c,7) == 1) %skip sunday
        continue
    end
    str = (strtok(Data2{1,1}(c,1))); %elimate seconds parameters
    Data2{1}(c,1) = str;
    dates_of_weekdays = [dates_of_weekdays; str]; %append
    btc_weekday_indexes = [btc_weekday_indexes; c];
    %disp(Data2{1,1}(c,1));
end

%      disp(Data2{1}(:,1)); %BTC dates
      disp(dates_of_weekdays); disp(size(dates_of_weekdays));
      disp(btc_weekday_indexes); disp(size(btc_weekday_indexes));
      
filtered_btc = [];
%for c in btc_weekday_indexes
for c=1:129
    pr = Data2{1}(btc_weekday_indexes(c),2);
    filtered_btc = [filtered_btc ; pr];
end
    %disp(filtered_btc); disp(size(filtered_btc));
    plot(str2double(filtered_btc), 'g');
    %hold on
    figure
    plot(str2double(flip(Data1{1}(:,2))));




% %align S&P and weekend
% Weekdays = []; %date strings of weekends
% indexs_weekdays = []; %indexes of weekdays 
% btc_weekday_prices = [];
% 
% for c=4:size(Data2{1,1}, 1)
%     weekday = Data2{1,1}(c,1); %disp(weekday);
%     price = Data2{1,1}(c,2);
%    
%     if(mod(c,7)== 0 || mod(c+1,7) == 0)%Friday, Saturday?
%         continue;
%     end 
%     
%     Weekdays = [Weekdays ; weekday];
%     indexs_weekdays = [indexs_weekdays ; c];
%     btc_weekday_prices = [btc_weekday_prices ; price]; 
% end

% disp(Weekdays);
% disp(indexs_weekdays);
% disp(btc_weekday_prices); % disp(btc_weekday_prices{1});


%Convert to num to plot, btc_weekday_prices and S&P prices Data1{1}{:,2}
% for c=1:127 %size(btc_weekday_prices)
%     btc_weekday_prices{c} = str2num(btc_weekday_prices{c});
% end
% 
% %figure
% %plot(btc_weekday_prices);
% 
% for c=1:127
%     hold on
%     plot(btc_weekday_prices{c});
% end
% disp(btc_weekday_prices);
% 
% x = linspace(1,127);
%plot(cell2mat(Data1{1,1}(:,1)));
%hold on

%plot(btc_weekday_prices{1,1});
%plot(Weekdays{1,1},btc_prices{1,1});




  %disp(Data1{1,1}(:,1));
  %disp(size(Data1{1,1}));
% disp(Data2{1,1}(:,1));


% querySet = Data1{1,1}(:,1);
% searchedSet = Data2{1,1}(:,1);
% sS_ = flip(Data2{1,1}(:,1)); %disp(sS_);


% LiA = ismember(querySet, sS_, 'rows'); 
% disp(LiA);


% [LiA,LoC] = ismember(querySet, sS_,'legacy');
% disp(LiA); disp(LoC);

%foo = find('2018/03/14');
%indx = index_of(foo);