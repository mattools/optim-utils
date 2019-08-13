function f = himmelblau(x, varargin)
%HIMMELBLAU Test function of two variables with 4 local minima
%
%   f = himmelblau(x)
%   x is a row vector of two variables.
%
%   The local maxima occurs at:
%   xmax = [-0.270844 -0.923038]
%   f(xmax) = 181.616
%
%   The four global minima occur at
%   x1 = [3 2], 
%   x2 = [-2.805118  3.131312], 
%   x3 = [-3.779310 -3.283186], 
%   x4 = [ 3.584428 -1.848126], 
%   with f(x1) = f(x2) = f(x3) = f(x4) = 0.
%
%   Example
%   himmelblau([0 0])
%   ans = 
%
%   himmelblau([3 2])
%   ans = 
%       0
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-05,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% make it work for 1 or 2 inputs
if isempty(varargin)
    y = x(:,2);
    x = x(:,1);
else
    y = varargin{1};
end

f = (x.^2 + y - 11).^2 + (x + y.^2 - 7).^2;
