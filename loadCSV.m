%align dates across csv files
    %weekday_filter is broke
clear all;
close all;

%Read in S&P pricing
look_from = 1; look_to = 125;  %125 weekday, 180 days with weekends
SNP=csvread('SnPClose.csv' ,2,1);
snp = flip(SNP(:, 1));
snp_glance = snp(look_from:look_to);
%Read in BTC pricing
BTC = csvread('bitcoin.csv',0,1);
btc = BTC(:, 1);  
btc_glance = btc(look_from:look_to);
%Read 10yr Yield
Y10 = load_yields();
y10 = Y10(1:125);

list_correlation(snp_glance, btc_glance,10);

%look at even intervals instead
% num_intervals = 10;
% interval_dist = (look_to - look_from) / num_intervals;
% disp(find_correlation(snp_glance, btc_glance, 10, 20));
% for j=1:num_intervals
%     start_indx = j*num_intervals;
%     stop_indx = start_indx + interval_dist;
%    
%     %append to a tablea and sort
% end
%disp(find_correlation(snp_glance, btc_glance, look_from, look_to));


