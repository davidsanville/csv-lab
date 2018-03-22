%This script aligns two CSV files by date
    %the smarter way is to break matching into weekly containers?
close all
clear all

%read CSV files
file1 = fopen('SPY.csv','r');
Data1 = textscan(file1, '%s%s%d', 'Delimiter',',', 'CollectOutput',1);
fclose1 = (file1);

file2 = fopen('BTC.csv','r');
Data2 = textscan(file2, '%s%s%d', 'Delimiter', ',', 'CollectOutput', 1);
fclose2 = (file2);

file3 = fopen('Y10.csv','r');
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
janky = 255;
%first_row_to_clear = size(snp_price,1); %sub 127
snp_price = str2double(flip(Data1{1}(:,2))); %typechange
snp_price(janky) = 0; %?delete first row with "close" label?
SNP = snp_price;
BTC = str2double(filtered_btc(1:janky));
%END FILTERING S&P


% %FILTER TREASURY
% ten_year = str2double(Data3{1}(:,2));
% % %Filter our '.' in treasure (even if hardcoded tenyear(17) = 0;
% ten_year(1) = 0;
% ten_year(17) = 0;
% ten_year(50) = 0;
% ten_year(72) = 0;
% ten_year(77) = 0;
% ten_year(87) = 0;
% ten_year(112) = 0;
% Y10 = ten_year(1:janky);
% %disp(ten_year)


   
   

%---------------%
%   STATISTICS  %
%---------------%

%covariance 

%correlation of whole data range
denominator = std(BTC) * std(SNP);
Corr = cov(BTC, SNP) / denominator;
disp("Overall BTC versus SNP"); disp(Corr);

% denominator = std(SNP) * std(Y10); Corr = cov(SNP, Y10) / denominator;
% disp("Overall SNP versus 10Y"); disp(Corr);
% 
% denominator = std(Y10) * std(BTC);
% Corr = cov(Y10, BTC) / denominator;
% disp("Overall Y10 versus BTC"); disp(Corr);

% %interval correlations
% BTCvSNP = correlation_intervals(BTC, SNP, 5);
% SNPvTEN = correlation_intervals(SNP, Y10, 5);
% TENvBTC = correlation_intervals(Y10, BTC, 5);

%plot correlations over time

% plot(BTCvSNP, 'g');
% hold on, plot(SNPvTEN ,'r');
% hold on, plot(TENvBTC ,'b');
%  figure 
%  plot(SNPvTEN ,'r');
%  
%  figure
%  plot(BTCvSNP, 'g');
