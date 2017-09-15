function [X] = dwtN(X, level, varargin)
    %To test the rotation, pass 0 as the level. The output should match the input.

    for dimidx = 1:ndims(X) %For each mode of the tensor:
        xsize = size(X); %Store the original size, needed in folding.
        X = unfold(X, 2)'; %Preserve existing columns, map all other modes to rows.

        workingslice = [];
        for modeidx = 1:size(X, 1) %For each row,
            wtemp = X(modeidx, :); %(In isolation),
            for lvidx = 1:level
                %Perform a multilevel DWT.
                wtemp = dwt(wtemp, varargin{:});
            end

            if (isempty(workingslice))
                %Preallocate to reduce computation time.
                workingslice = zeros(size(X, 1), size(wtemp, 2));
            end

            %Merge the coefficients into a slice of the tensor.
            workingslice(modeidx, :) = wtemp;
        end

        xsize(2) = size(workingslice, 2);

        %Fold the matrix back into a tensor and rotate it.
        X = shiftdim(fold(workingslice', 2, xsize), 1);
    end
end
