function [p fret] = linmin(fun, p, v)
%LINMIN  Multidimensional line search
%
%   output = linmin(FUN, P, V)
%   FUN : la fonction de plusieurs variables a minimiser
%   P : le point de depart
%   V : le vecteur de direction a utiliser
%
%   calls the brentLineSearch function.
%
%   Example
%   linmin
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-08,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

% use a function handle of 1 variable
fun1 = @(t) fun(p + t*v);