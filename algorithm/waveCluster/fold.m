%"Folds" a matrix back into a tensor of the specified size on the given mode.
function [tensor] = fold(mat, mode, tensorsize)
    othermodes = setdiff(1:numel(tensorsize), mode);
    tensorsize = tensorsize([mode othermodes]);
    tensor = ipermute(reshape(mat, tensorsize), [mode othermodes]);
end