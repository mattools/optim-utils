function [xmin fres] = directionSetMinimizer(fun, x0, directions, tol)
%DIRECTIONSETMINIMIZER  One-line description here, please.
%
%   output = directionSetMinimizer(FUN, X0, DIRS)
%   FUN is the function to minimize. It accepts a row vector as input, and
%       returns a scalar.
%   X0 is the initial guess of the minimum. It is a 1-by-N row vector.
%   DIR is the direction seach. It is a 1-by-N row vector.
%   TOL is the tolerance used by brentLineSearch.
%
%   Example
%   directionSetMinimizer
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-10,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% number of iterations
MAX_ITER = 200;

dirIndex = 1;

% main loop
for iter = 1:MAX_ITER
    % current direction
    dir = directions(dirIndex, :);
    
    % update direction index
    dirIndex = mod(dirIndex, size(directions, 1)) + 1;
    
    % use a function handle of 1 variable
    fun1 = @(t) fun(x0 + t*dir);
    
    % guess initial bounds of the function
    ax = 0;
    bx = 1;
    [ax bx cx] = fMinBracket(fun1, ax, bx);
    
    % search minimum along dimension DIR
    tmin = brentLineSearch(fun1, ax, bx, cx, tol);
    
    % construct new optimal point
    x0 = x0 + tmin*dir;
end

xmin = x0;
if nargout>1
    fres = fun(xmin);
end
