%{
 * Copyright (C) 2013-2025, The Regents of The University of Michigan.
 * All rights reserved.
 * This software was developed in the Biped Lab (https://www.biped.solutions/) 
 * under the direction of Jessy Grizzle, grizzle@umich.edu. This software may 
 * be available under alternative licensing terms; contact the address above.
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 * 1. Redistributions of source code must retain the above copyright notice, this
 *    list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 *    this list of conditions and the following disclaimer in the documentation
 *    and/or other materials provided with the distribution.
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
 * ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 * The views and conclusions contained in the software and documentation are those
 * of the authors and should not be interpreted as representing official policies,
 * either expressed or implied, of the Regents of The University of Michigan.
 * 
 * AUTHOR: Bruce JK Huang (bjhuang[at]umich.edu)
 * WEBSITE: https://www.brucerobot.com/
%}


clc, clear
%% Path and utils
opts.data_path = "./ROB101_data/";
opts.utils = "./utils/";
addpath(genpath(opts.utils));

%% Parameters
opt.Hessian = 1; % 0: use gradient descent 1: use the Hessian

% optimization initialization
opt.H_LC.T_init = [0.4, -0.15, 0]; % [x, y, z] in meters
opt.H_LC.rpy_init = [80, 0, 90]; % [roll, pitch, yaw] in degrees

% plotting parameters
opts.display = 1; % if plot results
opts.clean = 1; % clean canvas before redraw it


%% Load data 
[bag_data, test_data, training] = getBagDataForROB101(opts);
choisen_indices = [36:48];
testing_pc = loadTestingMatFiles(opts.data_path, test_data(1).pc_file);
training_pc1 = loadTestingMatFiles(...
    opts.data_path, string(bag_data(2).lidar_target(1).pc_file)).mat_pc;
training_pc2 = loadTestingMatFiles(...
    opts.data_path, string(bag_data(2).lidar_target(2).pc_file)).mat_pc;
training_pc = [training_pc1, training_pc2];
X_train = training.X_train.X_train;
Y_train = training.Y_train.Y_train;


%% camera intrinsic parameters
opt.intrinsic_matrix = [616.3681640625, 0.0,            319.93463134765625;
                        0.0,            616.7451171875, 243.6385955810547;
                        0.0, 0.0, 1.0];  


%% Calibrate a LiDAR and a Camera
if opt.Hessian
    disp("====================================")
    disp("Optiming using the Hessian method...")
    disp("====================================")
else
    disp("=============================================")
    disp("Optiming using the gradient descent method...")
    disp("=============================================")
end
tic
[H_LC, P, opt] = ...
    optimize4PointsLieNumerical(opt, ...
    X_train(:, choisen_indices), Y_train(:, choisen_indices), ...
    opt.intrinsic_matrix, opts.display);
toc


%% Plottings
warning('off','all')
H_init = constructHByRPYXYZ(opt.H_LC.rpy_init, opt.H_LC.T_init);
P_init = opt.intrinsic_matrix * [eye(3), zeros(3,1)] * H_init;

% Create figure and axes hangles
[axes_handles, fig_handles] = createFigHandleWithNumber(8, 1, "ROB101", 1, 1);

% Plot image and its edges
cur_fig = axes_handles(1);
loadBagImg(cur_fig, opts.data_path, bag_data(1).bagfile, opts.display, opts.clean)

cur_fig = axes_handles(2);
loadBagImg(cur_fig, opts.data_path, bag_data(1).bagfile, opts.display, opts.clean, 1)



% Show initial state of the optimization and resulting state
cur_fig = axes_handles(3);
loadBagImg(cur_fig, opts.data_path, test_data(1).bagfile, opts.display, opts.clean)
drawellipse(...
    cur_fig, 'Center',[114 372],'SemiAxes',[50 100], 'StripeColor','r');
drawellipse(...
    cur_fig, 'Center',[268 374],'SemiAxes',[70 100], 'StripeColor','r');
projectBackToImage(cur_fig, P_init, testing_pc.mat_pc, ...
    20, 'g.', "", "not display", "Not-Clean");

cur_fig = axes_handles(4);
loadBagImg(cur_fig, opts.data_path, test_data(1).bagfile, opts.display, opts.clean)
projectBackToImage(cur_fig, P, testing_pc.mat_pc, ...
     20, 'g.', "", "not display", "Not-Clean");



% Show LiDAR Vertices and camera corners
cur_fig = axes_handles(5);
scatter3(cur_fig, training_pc(1, :), training_pc(2, :), training_pc(3, :), 150, 'k.');
hold(cur_fig, 'on')
scatter3(cur_fig, ...
    X_train(1, 41:48), X_train(2, 41:48), X_train(3, 41:48), ...
    80, 'ro', 'fill');
viewCurrentPlot(cur_fig, "LiDAR vertices")
reloadCurrentPlot(fig_handles(5));

cur_fig = axes_handles(6);
loadBagImg(cur_fig, opts.data_path, bag_data(2).bagfile, opts.display, opts.clean)
hold(cur_fig, 'on')
scatter(cur_fig, Y_train(1, 41:48), Y_train(2, 41:48), 50, 'ro', 'fill');



% Show initial state of the optimization and resulting state
cur_fig = axes_handles(7);
loadBagImg(cur_fig, opts.data_path, bag_data(2).bagfile, opts.display, opts.clean)
hold(cur_fig, 'on')
scatter(cur_fig, Y_train(1, 41:48), Y_train(2, 41:48), 50, 'ro', 'fill');
X_projected = projectionMap(X_train(:, 41:48), P_init);
plotConnectedVerticesStructure(cur_fig, ...
    convertXYZmatrixToXYZstruct(Y_train(:, [41 42 44 43])), 'm')
plotConnectedVerticesStructure(cur_fig, ...
    convertXYZmatrixToXYZstruct(Y_train(:, [45 46 48 47])), 'm')
plotConnectedVerticesStructure(cur_fig, ...
    convertXYZmatrixToXYZstruct(X_projected(:, [1 2 4 3])), 'y')
plotConnectedVerticesStructure(cur_fig, ...
    convertXYZmatrixToXYZstruct(X_projected(:, [5 6 8 7])), 'y')
projectBackToImage(cur_fig, P_init, X_train(:, 41:48), ...
    200, 'g.', "", "not display", "Not-Clean");
% draw direction vectors
% Direction = -(X_projected - Y_train);
% quiver(cur_fig, X_projected(1, 41:48), X_projected(2, 41:48), ...
%        Direction(1, 41:48), Direction(2, 41:48), 0.5, '-y', 'LineWidth', 2) 

cur_fig = axes_handles(8);
loadBagImg(cur_fig, opts.data_path, bag_data(2).bagfile, opts.display, opts.clean)
hold(cur_fig, 'on')
scatter(cur_fig, Y_train(1, 41:48), Y_train(2, 41:48), 80, 'ro', 'fill');
projectBackToImage(cur_fig, P, X_train(:, 41:48), ...
    200, 'g.', "", "not display", "Not-Clean");
popCurrentFigure(fig_handles(7));
warning('on','all')

