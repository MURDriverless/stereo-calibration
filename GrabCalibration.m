clc;
clear;
close all;

target = rgb2gray(imread('target_half_v2.png'));
camLR = 'Right';

for dist = 30:15:120
    imName = sprintf("%s/%s_%d", camLR, camLR, dist);
    im = rgb2gray(imread([char(imName), '.png']));
    im = imgaussfilt(im);
    c = normxcorr2(target, im);
    c = abs(c);
    [xgrid, ygrid] = meshgrid(1:size(c,2), 1:size(c,1));

    nRows = 7;
    nCols = 11;
    numPeaks = nRows * nCols;
    targetSize = size(target,1) + mod(size(target,1),2);

    [xp , yp] = getPeaks(c, targetSize, numPeaks);

    [tmp, I] = sort(yp);
    qRow = reshape(I, nCols, nRows)';

    bin = zeros(size(xp));

    for i = 1:nRows
        bin(qRow(i,:)) = i;
    end

    [M, I] = sortrows([xp', yp', bin'], [3 1]);
    
    xp = xp(I);
    yp = yp(I);

    figure
    imshow(im);
    hold on
    p = plot3(xp, yp, bin(I), 'r-o', 'linewidth', 2);

    n = numel(xp);
    cd = [uint8(parula(n)*255) uint8(ones(n,1))].';

    save(sprintf("Peaks/%s_%d", camLR, dist), 'xp', 'yp');
    
    drawnow
    set(p.Edge, 'ColorBinding','interpolated', 'ColorData',cd)
end