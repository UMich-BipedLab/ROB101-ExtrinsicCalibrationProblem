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

function h = plotConnectedVerticesStructure(fig_handle, vertices, properties, hold_on)
%     if isempty(fig_handle)
%         fig_handle = createFigHandleWithNumber(1, 999,"test");
%     end
    if ~exist('properties','var')
        properties = 'k';
    end
    
    if ~exist('hold_on','var')
         hold_on = 'on';
    end
    [~, fig_handle] = checkFigureHandle(fig_handle, 1);
    hold(fig_handle, hold_on)
    if isfield(vertices, 'z')
        h = plot3(fig_handle, ...
            [vertices.x vertices.x(1)], ...
            [vertices.y vertices.y(1)], ...
            [vertices.z vertices.z(1)], 'color', properties, 'LineWidth', 2);
    else
        h = plot(fig_handle, ...
                [vertices.x vertices.x(1)], ...
                [vertices.y vertices.y(1)], 'color', properties, 'LineWidth', 2);
    end
        %     hold(fig_handle, hold_on)
    if ~nargout % if nargout == 0
       clearvars % or simply clearvars y
    end
end
