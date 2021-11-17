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

function [H_LC, P, opt] = optimize4PointsLieNumerical(...
    opt, X, Y, intrinsic, display)
    R = rotx(opt.H_LC.rpy_init(1)) * ...
        roty(opt.H_LC.rpy_init(2)) * ...
        rotz(opt.H_LC.rpy_init(3));
    Rv = Log_SO3(R);
    Tv = opt.H_LC.T_init;
    theta = [Rv; Tv'];
    cost_init = cost4PointsLie(theta(1: 3), theta(4: 6), X, Y, intrinsic);
    h_Rv = 1e-6;
    h_Tv = 1e-6;
    counter = 1;

    if opt.Hessian
        % Hessian Solver
        cost_pre = 1e10;
        gamma = 1.5;
        dcost_gradient = computeSymmetricDifferenceGradient(...
            theta(1: 3), theta(4: 6), X, Y, intrinsic, h_Rv, h_Tv);
        while 1 && counter < 1e3
            dcost_hessian = computeSymmetricDifferenceHessian(...
            theta(1: 3), theta(4: 6), X, Y, intrinsic, h_Rv, h_Tv);
            update = gamma * inv(dcost_hessian) * dcost_gradient';
            theta = theta - update;
            dcost_gradient = computeSymmetricDifferenceGradient(...
                theta(1: 3), theta(4: 6), X, Y, intrinsic, h_Rv, h_Tv);

            cost = cost4PointsLie(theta(1: 3), theta(4: 6), X, Y, intrinsic);
            if abs(cost - cost_pre) < 1e-5
                break
            end
            cost_pre = cost;
            counter = counter + 1;
        end
    else
        % Gradient Solver
        gamma = 1e-8; % 1e-17;
        cost_pre = 1e10;
        while 1
            grad = computeSymmetricDifferenceGradient(...
                theta(1: 3), theta(4: 6), X, Y, intrinsic, h_Rv, h_Tv);
            update = gamma * grad;
    %         update = [0 0 0 update(4) update(5) update(6)]';
            theta = theta - makeColumn(update);
            cost = cost4PointsLie(theta(1: 3), theta(4: 6), X, Y, intrinsic);
            if mod(counter, 1000) == 0
                counter;
                update_norm = norm(update);
                cost;
            end

            if abs(cost - cost_pre) < 1e-5
                break
            end
            if abs(cost - cost_pre) > 1e-5 && counter > 1e5
                text1 = "The optimization might have diverged, ";
                text2 = "please change your initial guess!";
                warning(text1 + text2)
                break
            end
             
            cost_pre = cost;
            counter = counter + 1;
        end
    end
    
    H_LC = eye(4);
    H_LC(1:3, 1:3) = Exp_SO3(theta(1: 3));
    H_LC(1:3, 4) = theta(4: 6)';
    P = intrinsic * [eye(3) zeros(3,1)] * H_LC;
    
    opt.total_cost = cost;
    opt.RMSE = sqrt(cost/size(Y,2));
    opt.counter = counter;
    
    %% Results
    fprintf("The initial cost is: %.2f\n", cost_init)
    fprintf("After optimizing over %i iterations, ", opt.counter)
    fprintf("the final cost is: %.2f\n", opt.total_cost)
end