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

function grad = computeGradient(...
    Rv, Tv, X, Y, intrinsic, Rv_len, Tv_len, num_samples)
    f = 1e0 * cost4PointsLie(Rv, Tv, X, Y, intrinsic);
    dRv_mat = ...
        [genRandomMatrix(...
            Rv(1) - Rv_len, Rv(1) + Rv_len, [], [num_samples, 1]), ...
         genRandomMatrix(...
            Rv(2) - Rv_len, Rv(2) + Rv_len, [], [num_samples, 1]), ...
         genRandomMatrix(...
            Rv(3) - Rv_len, Rv(3) + Rv_len, [], [num_samples, 1])];
        
    dTv_mat = ...
        [genRandomMatrix(...
            Tv(1) - Tv_len, Tv(1) + Tv_len, [], [num_samples, 1]), ...
         genRandomMatrix(...
            Tv(2) - Tv_len, Tv(2) + Tv_len, [], [num_samples, 1]), ...
         genRandomMatrix(...
            Tv(3) - Tv_len, Tv(3) + Tv_len, [], [num_samples, 1])];
    
    A = [dRv_mat - Rv', dTv_mat - Tv'];
    b = zeros(num_samples, 1);

    for i = 1:num_samples
        b(i) = 1e0 * cost4PointsLie(dRv_mat(i, :), ...
                              dTv_mat(i, :), X, Y, intrinsic) - f;
    end
    grad = pinv(A) * b;
end