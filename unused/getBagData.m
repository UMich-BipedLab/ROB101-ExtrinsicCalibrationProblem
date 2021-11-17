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

function [BagData, TestData] = getBagData()

    
    TestData(1).bagfile = "outdoor4.bag";
    TestData(1).pc_file = "velodyne_points-outdoor4--2019-09-04-18-16.mat";
   

    %%% tag size: largest -> smallest 
    %%% parameter for dataset

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lab3-closer-cleaner.bag dataset
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    i = 1;
    BagData(1).bagfile = "lab3-closer-cleaner.bag";
    BagData(1).num_tag = 2;
    BagData(1).lidar_target(1).pc_file = 'velodyne_points-lab3-closer-big--2019-09-06-08-38.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(1).lidar_target(1).tag_size = 0.8051;
    BagData(1).lidar_target(2).pc_file = 'velodyne_points-lab3-closer-small--2019-09-06-08-35.mat'; %% payload
    BagData(1).lidar_target(2).tag_size = 0.158;
    BagData(1).lidar_full_scan = "velodyne_points-lab3-closer-full-scan--2019-09-06-08-28.mat";
    BagData(1).camera_target(2).corners = [200, 157, 223, 180;
                                    251, 275, 292, 315;
                                    1, 1, 1, 1];
    BagData(1).camera_target(1).corners = [333, 248, 418, 328;
                                   239, 322, 328, 416;
                                   1, 1, 1, 1];    



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lab4-closer-cleaner.bag dataset
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    i = 2;
    BagData(i).bagfile = "lab4-closer-cleaner.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-lab4-closer-big--2019-09-06-13-49.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-lab4-closer-small--2019-09-06-13-38.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-lab4-closer-full-pc--2019-09-06-13-34.mat";
    BagData(i).camera_target(2).corners = [250, 206, 272, 230;
                                  257, 281, 299, 323;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [473, 349, 575, 435;
                                   227, 314, 361, 448;
                                   1, 1, 1, 1];    


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lab5-closer-cleaner.bag dataset
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    i = 3;
    BagData(i).bagfile = "lab5-closer-cleaner.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-lab5-closer-bag--2019-09-06-14-27.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-lab5-closer-small--2019-09-06-14-23.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-lab5-closer-full-pc--2019-09-06-14-15.mat";
    BagData(i).camera_target(2).corners = [145, 105, 165, 127;
                                  263, 284, 299, 321;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [398, 281, 490, 367;
                                   233, 318, 349, 440;
                                   1, 1, 1, 1];     


    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lab7-closer-cleaner.bag dataset
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%  
    i = 4;
    BagData(i).bagfile = "lab7-closer-cleaner.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-lab7-closer-big--2019-09-06-15-14.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-lab7-closer-small--2019-09-06-15-12.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-lab7-closer-full-pc--2019-09-06-14-16.mat";
    BagData(i).camera_target(2).corners = [509, 479, 529, 498;
                                  274, 292, 305, 323;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [178, 79, 230, 137;
                                   253, 307, 342, 402;
                                   1, 1, 1, 1];    



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % lab8-closer-cleaner.bag dataset
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    i = 5;
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


    i = 6;
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


    i = 7;
    BagData(i).bagfile = "wavefield5-tag.bag";
    BagData(i).num_tag = 2;
    BagData(i).lidar_target(1).pc_file = 'velodyne_points-wavefield5-big--2019-09-07-20-24.mat'; %% payload: 3Tags-OldLiDAR.bag
    BagData(i).lidar_target(1).tag_size = 0.8051;
    BagData(i).lidar_target(2).pc_file = 'velodyne_points-wavefield5-small--2019-09-07-19-17.mat'; %% payload
    BagData(i).lidar_target(2).tag_size = 0.158;
    BagData(i).lidar_full_scan = "velodyne_points-wavefield5-full-pc--2019-09-07-19-01.mat";
    BagData(i).camera_target(2).corners = [483, 443, 517, 474;
                                  236, 273, 280, 317;
                                  1, 1, 1, 1];
    BagData(i).camera_target(1).corners = [168, 110, 204, 152;
                                    268, 317, 329, 383;
                                    1, 1, 1, 1];                            
end
