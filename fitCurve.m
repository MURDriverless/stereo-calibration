clc;
clear;
close all;

Left_px_coords = [];
Left_py_coords = [];
Right_px_coords = [];
Right_py_coords = [];

camLRs = ["Left", "Right"];

files = dir('Peaks/*.mat');

dists = 30:15:120;

nRows = 7;
nCols = 11;

grid_size = 20; % [mm]
[y_real_grid, x_real_grid] = meshgrid(nRows:-1:1, (1:nCols) - ceil(nCols/2));
x_real_grid = x_real_grid * grid_size;
y_real_grid = y_real_grid * grid_size + 18.4;

x_real = repmat(x_real_grid(:), numel(files)/2, 1)';
y_real = repmat(y_real_grid(:), numel(files)/2, 1)';
z_real = imresize(dists, [1, numel(dists)*nRows*nCols], 'nearest');

for camLR = 1:numel(camLRs)
    for dist = dists
        load(sprintf("Peaks/%s_%d.mat", camLRs(camLR), dist));
        
        if camLR == 1
            Left_px_coords = [Left_px_coords, xp];
            Left_py_coords = [Left_py_coords, yp];
        else
            Right_px_coords = [Right_px_coords, xp];
            Right_py_coords = [Right_py_coords, yp];
        end
    end
end

x_realFit = polyfitn([Left_px_coords', Left_py_coords', Right_px_coords', Right_py_coords'], x_real, 4);
y_realFit = polyfitn([Left_px_coords', Left_py_coords', Right_px_coords', Right_py_coords'], y_real, 4);
z_realFit = polyfitn([Left_px_coords', Left_py_coords', Right_px_coords', Right_py_coords'], z_real, 4);

save('FitRes', 'x_realFit', 'y_realFit', 'z_realFit');