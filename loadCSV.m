%align dates across csv files
    %weekday_filter is broke
clear all;
close all;

%Read in S&P pricing
    %high correlations (75, 100)=0.123 (45, 85) =0.14 (30,55) -0.106
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

%covariance & variance tests
%v = var(y10,snp_glance); disp(v);
disp(var(snp_glance, btc_glance));
disp(cov(snp_glance, btc_glance));
%disp(cov(y10, snp_glance));


%https://blockchain.info/charts/market-price?timespan=180days
%https://www.nasdaq.com/symbol/spy/historical
%https://www.mathworks.com/help/matlab/matlab_prog/set-up-git-source-control.html

