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


function reloadCurrentPlot(axes_h, equal, fontsize, line_width)
% reloadCurrentPlot();
% axes_h = gca; axes_h.FontSize = 30; reloadCurrentPlot(axes_h);
    if ~exist('axes_h', 'var') || isempty(axes_h)
        axes_h = gca; 
        axes_h.FontSize = 30;
    end
    
    [~, axes_h] = checkFigureHandle(axes_h, 1);
    if  ~exist('fontsize', 'var') || isempty(fontsize)
        axes_h.FontSize = 30;
    else
        axes_h.FontSize = fontsize;
    end

    if  ~exist('line_width', 'var') || isempty(line_width)
        set(axes_h, 'LineWidth', 2)
    else
        set(axes_h, 'LineWidth',line_width)
    end
    
    
        
    xlabel(axes_h, get(get(axes_h,'xlabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    ylabel(axes_h, get(get(axes_h,'ylabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    zlabel(axes_h, get(get(axes_h,'zlabel'),'string'), 'interpreter','latex', 'FontSize', axes_h.FontSize)
    
    if ~exist('equal', 'var')
        axis(axes_h, 'equal')
    else
        if equal
            axis(axes_h, 'equal')
        else
            axis(axes_h, 'normal')
        end
    end
    grid(axes_h, 'on')
    set(get(axes_h, 'parent'), 'visible','on');% show the current axes
    drawnow
end