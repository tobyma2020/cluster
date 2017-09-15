function [sigcells, datacellindices, counts, wdata] = WaveCluster_Preprocess(data, weights, num_cells, densitythreshold, level, wavename, useSWT)
    %Default arguments.
    if (~exist('num_cells', 'var') || isempty(num_cells))
        num_cells = max(data) - min(data) + 1;  %One-to-one grid mapping.
    end
    
    if (~exist('densitythreshold', 'var') || isempty(densitythreshold))
        densitythreshold = '10%';
    end
    
    if (~exist('level', 'var') || isempty(level))
        level = 1;
    end

    if (~exist('wavename', 'var') || isempty(wavename))
        wavename = 'bior2.2';
    end

    if (~exist('useSWT', 'var') || isempty(useSWT))
        useSWT = 0; %Use the DWT by default.
    end
    
    %Grid the data.
    [counts, datacellindices] = data2grid(data, weights, num_cells);

    %Wavelet transform using a biorthogonal wavelet.
    oldmode = dwtmode('status', 'nodisp');
    dwtmode('zpd', 'nodisp'); %Zero-pad the edges during convolution (avoids spurious clusters at the borders).
    
    %[decwaves, bookkeep] = wavedec2(counts, level, wavename);
    try
        if (useSWT)
            wdata = swtN(counts, level, wavename);
        else
            wdata = dwtN(counts, level, wavename);

            %For each level, the grid size is downsampled by 2. Match the indices.
            datacellindices = ceil(datacellindices ./ 2 ^ level);
        end
    catch me
        dwtmode(oldmode, 'nodisp');   %Restore the old dwtmode, whatever it was.
        rethrow(me);
    end
    
    dwtmode(oldmode, 'nodisp');   %Restore the old dwtmode, whatever it was.
    
    %wavedec gives us the entire multilevel decomposition (dwt2 only gives one level).
    %We only want level N approximation coefficients, which we now extract:
    %wdata = appcoef2(decwaves, bookkeep, wavename, level)

    if (ischar(densitythreshold) && densitythreshold(end) == '%')
        %If the density threshold is a char variable ending in '%', use the
        %percentile specified instead of an absolute threshold.
        pctthresh = str2double(densitythreshold(1:end-1));
        densitythreshold = prctile(wdata(wdata > 0), pctthresh);
        disp(['Automatic density threshold @ ' num2str(pctthresh) '%: ' num2str(densitythreshold)])
    end

    %A cell is either significant or it isn't.
    sigcells = (wdata >= densitythreshold);
end
