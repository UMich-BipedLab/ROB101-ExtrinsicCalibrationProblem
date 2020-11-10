%{
 * Copyright (C) 2013-2020, The Regents of The University of Michigan.
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

function [BagData, TestData, training] = getBagDataForROB101(opts)

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Qualitative results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    TestData(1).bagfile = "outdoor4.bag";
    TestData(1).pc_file = "velodyne_points-outdoor4--2019-09-04-18-16.mat";
  
    


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Quantitative results
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    i = 1;
    BagData(i).bagfile = "lab8-closer-cleaner.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-lab8-closer-big--2019-09-06-15-28.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-lab8-closer-small--2019-09-06-15-17.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-lab8-closer-full-pc--2019-09-06-14-16.mat";
    BagData(i).camera_target(2).corners = [264, 226, 284, 246;
                                  258, 279, 296, 316;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [465, 372, 545, 445;
                                   222, 293, 318, 389;
                                   1, 1, 1, 1];    


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Training data
    %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    i = 2;
    BagData(i).bagfile = "wavefield3-tag.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-wavefield3-big--2019-09-07-19-04.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-wavefield3-small--2019-09-07-20-18.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-wavefield3-full-pc--2019-09-07-19-00.mat";
    BagData(i).camera_target(2).corners = [517, 489, 540, 512;
                                  268, 289, 297, 319;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [255, 215, 282, 243;
                                    284, 313, 328, 359;
                                    1, 1, 1, 1];    
                                
    training.X_train = load(opts.data_path + "X_train.mat"); % LiDAR vertices
    training.Y_train = load(opts.data_path + "Y_train.mat"); % Camera corners
end
