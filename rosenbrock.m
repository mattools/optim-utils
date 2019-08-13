function [f, grad] = rosenbrock(x, varargin)
%ROSENBROCK Rosenbrock function ("banana-like") of two variables
%
%   Compute the value of the Rosenbrock function. The Rosenborck function
%   (also called "banana function" due to its shape) is a function of 2
%   variables given by equation:
%       f(x,y) = (1 - x)^2 + 100*(y - x^2)^2;
%   
%   The global minimum is given by x = [1 1], for which f = 0.
%
%   f = rosenbrock(x)
%   Where x is a row vector of two variables, returns the value of the
%   function for the point (x(1) x(2)).
%   
%   f = rosenbrock(x, y)
%   Computes the value for the point (x, y). x and y can be arrays the same
%   size, in this case the result f has the same size as inputs.
%
%   [f g] = rosenbrock(x)
%   Also returns the gradient of the Rosenbock function for the parameter
%   x. the result gradient g has the same number of dimension of x plus
%   one.
%
%   Example
%   rosenbrock([1 0])
%   ans = 
%      100
%   rosenbrock([1 1])
%   ans = 
%        0
%
%   lx = linspace(0, 2, 500);
%   ly = linspace(0, 2, 500);
%   [x y] = meshgrid(lx, ly);
%   fval = rosenbrock(x, y);
%   surf(x, y, fval, 'linestyle', 'none');
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
    nd = 1;
else
    y = varargin{1};
    nd = ndims(x);
    if isscalar(x)
        nd = 1;
    end
end

f = (1 - x).^2 + 100*(y - x.^2).^2;

% eventually compute gradient
if nargout>1
    gx = 2*(x - 1) + 400*x.*(x.^2 - y);
    gy = 100*(2*y - 2*x.^2);
    grad = squeeze(cat(nd+1, gx, gy));
end