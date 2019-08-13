function [ax bx cx] = mnbrak(fun, ax, bx)
%MNBRAK Routine for initially bracketing a minimum
%
%   [ax bx cx] = mnbrak(FUN, LOW, HIGH)
%
%   Example
%   mnbrak
%
%   Algorithm taken from Numerical Recipes in C, second ed., p400
%   
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% gold ratio constant
GOLD = (1+sqrt(5))/2;

% evaluate function at bounds
fa = fun(ax);
fb = fun(bx);

% we want to go downhill in the direction a -> b
if fb>fa
    dum = fa; fa = fb; fb = dum;
    dum = ax; ax = bx; bx = dum;
end

% first guess of cx
cx = bx + GOLD*(bx-ax);

% corresponding function value
fc = fun(cx);

% Iterate until the middle point has value below the largest one
while fb > fc
    % compute u using parabolic interpolation
    r = (bx - ax) * (fb - fc);
    q = (bx - cx) * (fb - fa);
    
    % some trick to avoid 0 at denominator
    denom = 2*sign(q - r)*max(abs(q - r), 1e-12);
    u = bx - ((bx - xx)*q - (bx - ax)*r) / denom;
    ulim = bx + 100 * (cx - bx);
    
    % test different cases for relative location of u wrt ax and bx
    if (bx - u) * (u - cx) > 0
        % u is between b and c
        fu = fun(u);
        if fu < fc
            % a minimum was found between b and c
            ax = bx;
            bx = u;
            break;
            
        elseif fu > fb
            % a minimum was found between a and u
            cx = u;
            break;
            
        else 
            % parabolic fit was not useful
            u = cx + GOLD * (cx - bx);
            fu = fun(u);
            
        end
        
    elseif (cx-u) * (u-ulim) > 0
        % found minimum above c and below limit
        fu = fun(u);
        if fu < fc
            bx = cx; cx = u; u = cx+GOLD*(cx-bx);
            fb = fc; fc = fu; fu = fun(u);
        end
        
    elseif (u-ulim) * (ulim - cx) >= 0
        % limit parabolic u to maximum allowed value
        u = ulim;
        fu = fun(u);
        
    else
        % reject parabolic u and use the default magnification
        u = cx + GOLD * (cx - bx);
        fu = fun(u);
    end
    
    % update for next iteration
    ax = bx; bx = cx; cx = u;
    fa = fb; fb = fc; fc = fu;
    
end % while

% end of iteration, nothing to do

