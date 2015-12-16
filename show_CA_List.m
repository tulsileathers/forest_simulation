% plots images from evolution of a CA, all in one figure
%           waiting for user keypress before changing image
% inputs:   list -- list of CA frames to be plotted
%           interval -- every  <interval> frames willbe plotted
%           upperCmapBound -- lowest value for upperbound on colormap
%           lowerCmapBound -- highest value for lower bound on colormap
% outputs: none
% side effects: changes images in a figure window
%
function [ ] = show_CA_List(list,interval,upperCmapBound,lowerCmapBound)
    % bounds on colormap scale. For Ch. 10.2, try [24.9.. 25.1]
    upper = upperCmapBound;
    lower = lowerCmapBound;
    % set default colormap for plots
    set(groot,'DefaultFigureColormap',jet(64));

    % plot the CA grids
    for i=1:interval:length(list)
        % get the data to be plotted
        data = list{i};
        % be sure cmap bounds are set if needed
        cmax = max(data(:));
        if cmax < upper
            cmax = upper;
        end
        cmin = min(data(:));
        if cmin > lower
            cmin = lower;
        end
        % plot the image
        imagesc(data);
        caxis([cmin cmax]);
        colorbar;
        title(sprintf('Frame: %d',i));
        hold;
        axis equal; axis tight; axis xy;
        % wait to go on to next image
        fprintf('Waiting for any key to be pressed\n');
        w = waitforbuttonpress;
    end
end