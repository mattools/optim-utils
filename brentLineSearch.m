function varargout = brentLineSearch(fun, ax, bx, cx, tol)
%BRENTLINESEARCH  Brent algorithm for line search
%
%   output = brentLineSearch(FUN, AX, BX, CX, TOL)
%
%   Example
%   brentLineSearch
%
%   See also
%
%
% ------
% Author: David Legland
% e-mail: david.legland@grignon.inra.fr
% Created: 2010-08-10,    using Matlab 7.9.0.529 (R2009b)
% Copyright 2010 INRA - Cepia Software Platform.

%% constants

% max number of iterations
MAX_ITER = 100;

% to protect against divisions by zero
ZEPS = 1e-10;

% golden ratio, approx equal to 0.311966
CGOLD = (3-sqrt(5))/2;

%% Initialisations

% compute bounds in ascending order
if ax < cx
    a = ax;
    b = cx;
else
    a = cx;
    b = ax;
end

% move distance from last point
e = 0;

% initialisations to approximated value
x = bx;
v = bx;
w = bx;

% first function evaluations
fx = fun(x);
fv = fx;
fw = fx;

% main loop
done = false;
for iter = 1:MAX_ITER
    
    xm = (a + b)*.5;
    tol1 = tol*abs(x)+ZEPS;
    tol2 = 2*tol1;
    
    % test if convergence criterion is met
    if abs(x-xm) <= (tol2 - (b-a)*.5)
        done = true;
        xmin = x;
        res = fx;
        break;
    end

    % construct a trial parabolic fit
    if abs(e) > tol1
        r = (x - w) * (fx - fv);
        q = (x - v) * (fx - fw);
        p = (x - v) * q - (x - w) * r;
        q = 2 * (q - r);
        
        if q > 0
            p = -p;
        end        
        q = abs(q);
        
        etemp = e;
        e = d;
        
        % Test the acceptability of the parabolic fit
        if abs(p) <= abs(q*etemp*.5) || p <= q*(a-x) || p>= q*(b-x)
            % choose the golden section into the larger of the two segments
            if x >= xm
                e = a - x;
            else
                e = b - x;
            end
            d = CGOLD * e;
        else
            % take the parabolic step
            d = p / q;
            u = x + d;
            if u-a < tol2 || b-u < tol2
                d = tol1 * sign(xm-x);
            end
        end
        
    else
        % choose the golden section into the larger of the two segments
        if x >= xm
            e = a - x;
        else
            e = b - x;
        end
        d = CGOLD * e;
    end
    
    % compute new evaluation point
    if abs(d) >= tol1
        u = x + d;
    else
        u = x + tol1*sign(d);
    end
    
    % evaluate function at new value
    fu = fun(u);
    
    % Decide what to do with function evaluation
    if fu <= fx
        % update search itnerval
        if u >= x
            a = x;
        else 
            b = x;
        end
        
        v = w; 
        w = x; 
        x = u;
        fv = fw; 
        fw = fx; 
        fx = fu;
    else
        if u < x
            a = u;
        else
            b = u;
        end
        
        if fu <= fw || w==x
            v = w;
            w = u;
            fv = fw;
            fw = fu;
        elseif fu <= fv || v == x || v == w
            v = u;
            fv = fu;
        end
    end
    
end % iteration loop

% process error if no convergence
if ~done
    warning('BrentLineSearch:MaxIterReached', ...
        'Too many iteration in Brent line search');
    xmin = x;
    res = fx;
end


% process output arguments
if nargout<=1
    varargout{1} = xmin;
else
    varargout = {xmin, res};
end
