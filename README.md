# ROB101-Optimization Problem
## Overview
This package demonstrates how to use the naive gradient decent algorithm and the Hessian method to calibrate a LiDAR and a camera. For more details about this package, please read the textbook at [here](https://github.com/michiganrobotics/rob101).

* Authors: Bruce JK Huang and Jessy W. Grizzle
* Maintainer: [Bruce JK Huang](https://www.BrucebotStudio.com/), brucejkh[at]gmail.com
* Affiliation: [The Biped Lab](https://www.biped.solutions/), the University of Michigan

This package has been tested under **MATLAB 2020a** on **Ubuntu 18.04**, **MacOs Catalina (10.15.7)**, and MacOs Big Sur (11.6).


## How To Start
**[Required Packages]**
Please install the following packages in your MATLAB:
* Image Processing Toolbox
* Phased Array System Toolbox
* ROS Toolbox


**[Data Preparation]**
Please download the data from [the Google Drive](https://drive.google.com/drive/folders/12ejdZXoIA268aHeHha4N6Wqlw6LTdMnp?usp=sharing), and put them under the ROB101_data folder.


**[Running]**
Directly run rob101_optimization.m. All the eight figures should pop up, and the results will be shown in the command window.\
Here are the results shown in my command window with `opt.Hessian = 1`:
```
Loading data...
======================================
Optimizing using the Hessian method...
======================================
The initial cost is: 49750.06
After optimizing over 14 iterations, the final cost is: 12.11
Elapsed time is 0.092645 seconds.
Plotting restuls...
All Done!!
```

###### Note on parameters
```
opt.Hessian (0/1): <default: 1>
0: use the gradient descent method
1: use the hessian method
```

**[Issues]**
If you encounter issues when running the code, please take a look at the issues opened. If there is related issue, please open a new one, I will try my best to help. 


## Citations
The detail is described in:
Jiunn-Kai Huang and J. Grizzle, "Improvements to Target-Based 3D LiDAR to Camera Calibration" ([PDF](https://github.com/UMich-BipedLab/extrinsic_lidar_camera_calibration/blob/master/LiDAR2CameraCalibration.pdf))([arXiv](https://arxiv.org/abs/1910.03126))
```
@article{huang2020improvements,
  author={J. {Huang} and J. W. {Grizzle}},
  journal={IEEE Access},
  title={Improvements to Target-Based 3D LiDAR to Camera Calibration},
  year={2020},
  volume={8},
  number={},
  pages={134101-134110},}
```
