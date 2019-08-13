function [xmin fret] = lineSearchND(fun, x0, dir, tol)
%LINESEARCHND  Multidimensional line search
%
%   Usage
%   XMIN = lineSearchND(FUN, X0, DIR, TOL)
%
%   Description
%   FUN is the function to minimize. It accepts a row vector as input, and
%       returns a scalar.
%   X0 is the initial guess of the minimum. It is a 1-by-N row vector.
%   DIR is the direction seach. It is a 1-by-N row vector.
%   TOL is the tolerance used by brentLineSearch.
%
%
%   calls the brentLineSearch function.
%
%   Example
%   lineSearchND
%
%   See also
%   brentLineSearch
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% use a function handle of 1 variable
fun1 = @(t) fun(x0 + t*dir);

% guess initial bounds of the function
ax = -1;
bx = 1;
[ax bx cx] = fMinBracket(fun1, ax, bx);

% search minimum along dimension DIR
tmin = brentLineSearch(fun1, ax, bx, cx, tol);

% construct new optimal point
xmin = x0 + tmin*dir;

if nargout>1
    fret = fun(xmin);
end
