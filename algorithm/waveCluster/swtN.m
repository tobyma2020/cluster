%Performs an n-dimensional multilevel stationary wavelet transform, passing any
%arguments beyond the input data and level along to the individual swt calls
%from which the transform is constructed.

%TODO: Returns the 2^n sets of coefficients, approx. first (LLL, LLH, LHL, LHH...)
%Currently returns the approximation coefficients.
function [X] = swtN(X, level, varargin)
    if (ndims(X) == 2)
        %The below algorithm will work in the 2D case, but the 2D builtin is faster.
        [X, tmp, tmp, tmp] = swt2(X, level, varargin{:});
        return;
    end

    for dimidx = 1:ndims(X)
        %Matricize on mode 2, adding new rows for modes 3 and larger.
        xsize = size(X);
        X = unfold(X,2)';

        workingslice = [];
        for modeidx = 1:size(X, 1)  %We always work on the first dimension.
            [wtemp, tmp] = swt(X(modeidx, :), level, varargin{:});

            if (isempty(workingslice))
                workingslice = zeros(size(X, 1), size(wtemp, 2));
            end

            workingslice(modeidx, :) = wtemp;
        end

        %Fold the matrix back up into a tensor and work on the next mode.            
        xsize(2) = size(workingslice, 2);

        X = shiftdim(fold(workingslice', 2, xsize), 1);
    end
end
