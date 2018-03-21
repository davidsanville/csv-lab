%This script aligns two CSV files by date
    %the smarter way is to break matching into weekly containers?

%read CSV files
file1 = fopen('SnPClose.csv','r');
Data1 = textscan(file1, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
fclose1 = (file1);

file2 = fopen('bitcoin.csv','r');
Data2 = textscan(file2, '%s%s%d', 'Delimiter', ',', 'CollectOutput', 1);
fclose2 = (file2);

file3 = fopen('DGS10.csv','r');
Data3 = textscan(file3, '%s%s%d', 'Delimiter', ',', 'CollectOutput', 1);
fclose3 = (file3);

%display read files
%     disp(Data1{1}(:,1)); %S&P dates
%     disp(Data1{1}(:,2)); %S&P prices
%     disp(Data2{1}(:,1)); %BTC dates
%     disp(Data2{1}(:,2)); %BTC prices
%disp(Data3{1}(:,2)); %treary prices
   

%---------%
%FILTERING%
%---------%

dates_of_weekdays = []; btc_weekday_indexes = [];

for c=1:size(Data2{1,1}, 1) 
    %filter out weekends,
    Sat = c+1; Sun = c; 
    if(mod(Sat,7) == 1); continue; end
    if(mod(Sun,7) == 1); continue; end
    
    %%removes seconds from time string,
    str = (strtok(Data2{1,1}(c,1))); 
    Data2{1}(c,1) = str;
    dates_of_weekdays = [dates_of_weekdays; str]; 
    btc_weekday_indexes = [btc_weekday_indexes; c];
end

%get values at each weekday index
filtered_btc = [];
fixMe = size(btc_weekday_indexes,1) - 2; 
%filtered_btc = %%please initialize me
%disp(size(btc_weekday_indexes,1));
for c=1:fixMe %janky at the side, unit test and update
    pr = Data2{1}(btc_weekday_indexes(c),2);
    filtered_btc = [filtered_btc ; pr];
end %end get values at index



%BEGIN FILTERING S&P
janky = 127;
%first_row_to_clear = size(snp_price,1); %sub 127
snp_price = str2double(flip(Data1{1}(:,2))); %typechange
snp_price(janky) = 0; %?delete first row with "close" label?
SNP = snp_price;
BTC = str2double(filtered_btc);
%END FILTERING S&P


%FILTER TREASURY
ten_year = str2double(Data3{1}(:,2));
% %Filter our '.' in treasure (even if hardcoded tenyear(17) = 0;
ten_year(1) = 0;
ten_year(17) = 0;
ten_year(50) = 0;
ten_year(72) = 0;
ten_year(77) = 0;
ten_year(87) = 0;
ten_year(112) = 0;
Y10 = ten_year(1:janky);
%disp(ten_year)


   
   

%---------------%
%   STATISTICS  %
%---------------%

%covariance 

%correlation of whole data range
denominator = std(BTC) * std(SNP);
Corr = cov(BTC, SNP) / denominator;
disp("Overall BTC versus SNP"); disp(Corr);

denominator = std(SNP) * std(Y10); Corr = cov(SNP, Y10) / denominator;
disp("Overall SNP versus 10Y"); disp(Corr);

denominator = std(Y10) * std(BTC);
Corr = cov(Y10, BTC) / denominator;
disp("Overall Y10 versus BTC"); disp(Corr);

%interval correlations
BTCvSNP = correlation_intervals(BTC, SNP, 5);
SNPvTEN = correlation_intervals(SNP, Y10, 5);
TENvBTC = correlation_intervals(Y10, BTC, 5);

%plot correlations over time
plot(BTCvSNP, 'g');
hold on, plot(SNPvTEN ,'r');
hold on, plot(TENvBTC ,'b');






%--------------------------------------------------%
%--------------------------------------------------%
%--------------------------------------------------%
%RUSTY TOOLS aka FOOBAR CODE
%
%


%for debugging
%      disp(Data2{1}(:,1)); %BTC dates
%       disp(dates_of_weekdays); disp(size(dates_of_weekdays));
%       disp(btc_weekday_indexes); disp(size(btc_weekday_indexes));
      

% %for debugging data plots (was after btc value @ index loop)
%     %disp(filtered_btc); disp(size(filtered_btc));
% plot(str2double(filtered_btc), 'g');
%     %hold on
% figure
% plot(str2double(flip(Data1{1}(:,2))));
% 
% %for debugging sizing
% disp(size(str2double(filtered_btc)));
% % disp(size(str2double(flip(Data1{1}(:,2)))));
    %disp(str2double(flip(Data1{1}(:,2))));
%corrs_ = list_correlation(str2double(filtered_btc), str2double(flip(Data1{1}(:,2))),4);
%disp(cov(str2double(filtered_btc),str2double(flip(Data1{1}(:,2)))));

%disp(cov(str2double(filtered_btc),str2double(flip(filtered_snp))));
%disp(str2double(flip(filtered_snp)));

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


%removes seconds from time string, for alignment
% for c=1:size(Data2{1,1}, 1)
%     str = (strtok(Data2{1,1}(c,1)));
%     Data2{1,1}(c,1) = str;
%     %disp(Data2{1,1}(c,1));
% end

%in function now
% %intervalled correlation
% num_intervals = 5;
% spacing = floor(size(BTC,1) / num_intervals);  %spacing = 25;
% sz1 = size(BTC,1); sz2 = size(SNP,1);
% assert(sz1 == sz2);
% 
% Corr_ = zeros(num_intervals);
% for c =1:num_intervals
%     s = 1 + (c-1)*spacing; 
%     f= s+ spacing;
% 
%     denominator = std(BTC(s:f)) * std(SNP(s:f));
%     corr = cov(BTC(s:f), SNP(s:f)) / denominator;
%     Corr_(c) = corr(1,2);
%     disp("interval " +c+ ": " +s + " to " + f); disp(corr);
% end 
% 
% plot(Corr_);
