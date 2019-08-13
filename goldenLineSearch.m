function varargout = goldenLineSearch(fun, ax, bx, cx, tol)
%GOLDENLINESEARCH Minimum of a function using golden section search
%
%   output = goldenLineSearch(FUN, AX, BX, CX, TOL)
%
%   Note: the function does not need to be evaluated at end points.
%
%   Example
%   % evaluate classical probalistic function
%   goldenLineSearch(@(p) p.*log(p), 0, .5, 1, .0001)
%   ans = 
%
%
%   See also
%   fMinBracket
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% some computation constants
R = (1+sqrt(5))/2 - 1; 
C = 1 - R;

% At any time, we need 4 points to estimate next position
x0 = ax;
x3 = cx;

if abs(cx-bx) > abs(bx-ax)
    % use bx as x1, and choose x2 within the bigger segment
    x1 = bx;
    x2 = bx + C * (cx - bx);
else
    % use bx as x2, and choose x1 within the bigger segment
    x2 = bx;
    x1 = bx - C * (bx - ax);
end

% initial function evaluations
f1 = fun(x1);
f2 = fun(x2);

% iterate until 
while abs(x3 - x0) > tol*(abs(x1) + abs(x2))

    if f1 < f2
        % drop last point
        x3 = x2; x2 = x1; 
        % choose new x1 between x0 and x2
        x1 = R*x2 + C*x0;
        f2 = f1;
        % new function evaluation
        f1 = fun(x1);

    else
        % drop first point
        x0 = x1; x1 = x2; 
        % choose x2 between x1 and x3
        x2 = R*x1 + C*x3;
        f1 = f2;
        % new function evaluation
        f2 = fun(x2);
        
    end
    
end % while

if f1 < f2
    res = f1;
    xmin = x1;
else
    res = f2;
    xmin = x2;
end

if nargout<=1
    varargout{1} = xmin;
else
    varargout = {xmin, res};
end
