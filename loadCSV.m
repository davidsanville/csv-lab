
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
y10_glance = Y10(look_from:look_to);

%align dates across csv files
    %see weekday_filer
    %see align

plot(snp_glance);
%hold on
figure
plot(btc_glance);
%hold on 
figure
plot(y10_glance);

figure; 

%not robust for all intervals, unit test
foo = list_correlation(snp_glance, btc_glance,5);
for j =1:5
    corrs_(j) = foo(2*j);
end

plot(corrs_);

% figure;
% plot(list_variation(snp_glance, btc_glance, 5));
% figure;
% plot(list_variation(btc_glance, btc_glance, 5));

%correlation12 = cov12 / (stdev1 * stdev2)
%variance1 = v1;
%pca, etc



