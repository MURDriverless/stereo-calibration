clc;
clear;
close all

load('FitRes.mat');

modelTerms = x_realFit.ModelTerms;

csvwrite('csvFit/modelTerms.csv', modelTerms);
csvwrite('csvFit/x_coeff.csv', x_realFit.Coefficients);
csvwrite('csvFit/y_coeff.csv', y_realFit.Coefficients);
csvwrite('csvFit/z_coeff.csv', z_realFit.Coefficients);

polyvaln(x_realFit, [1 1 1 1])