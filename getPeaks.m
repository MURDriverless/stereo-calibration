function [x_peak, y_peak] = getPeaks(c, targetSize, numPeaks)
    x_peak = zeros(1, numPeaks);
    y_peak = zeros(1, numPeaks);
    widthA = -targetSize/2:targetSize/2;
    
    for i = 1:numPeaks
        [rows, cols] = find(c == max(c(:)));
        c(rows + widthA, cols + widthA) = 0;
        x_peak(i) = cols - targetSize/2;
        y_peak(i) = rows - targetSize/2;
    end
end