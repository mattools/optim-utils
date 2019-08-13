function varargout = f1dim(varargin)
%F1DIM wrapper d'une fonction ND vers une fonction 1D
%
%   output = f1dim(input)
%
%   Example
%   f1dim
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
N = 200;

% base search vectors
e1 = [1 0];
e2 = [0 1];

% initial point
x0 = [0 0];

% init result
trace = zeros(N, 2);
trace(1,:) = x0;

% main loop
for i=2:2:N
    % find minimim for vector 1
    x0 = trace(i-1, :);
    tmin = brentLineSearch(@(t)(fun(x0+t*e1)), -10, 0, 10, 1e-5);
    
    % update current point
    x0 = x0 + tmin*e1;
    trace(i,:) = x0;
    
    % find minimim for vector 2
    tmin = brentLineSearch(@(t)(fun(x0+t*e2)), -10, 0, 10, 1e-5);

    % update current point
    x0 = x0 + tmin*e2;
    trace(i+1,:) = x0;
end

