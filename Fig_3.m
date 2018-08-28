function Fig_3

% This script creates boxplots of the correlations within words, numbers,
% between words and numbers, and between words and other domains, and
% numbers and other domains. This is done for left and right lateral
% VTC, as well as left and right medial VTC.

partitions = {'lateral', 'medial'};
ResultsDir = './figures';

% We create plots for both lateral and medial VTC.
for p = 1:length(partitions)
    
    partition = partitions{p};

    if strcmp(partition, 'lateral')
        DataDir='./data/lateral_VTC';
    elseif strcmp(partition, 'medial')
        DataDir='./data/medial_VTC';
    end


    %% get young childrens data first
    filename_lh = sprintf('csym_all_lh_vtc_%s_youngc_inplane_3_Runs_z.mat', partition);
    filename_lh_path = fullfile(DataDir, filename_lh);
    filename_rh = sprintf('csym_all_rh_vtc_%s_youngc_inplane_3_Runs_z.mat', partition);
    filename_rh_path = fullfile(DataDir, filename_rh);
    load(filename_lh_path)
    youngc_lh = lh_combinedcsymmatrix; 
    load(filename_rh_path)
    youngc_rh = rh_combinedcsymmatrix;
    
    clear rh_combinedcsymmatrix lh_combinedcsymmatrix 


    %% get older childrens data
    filename_lh_oc = sprintf('csym_all_lh_vtc_%s_olderc_inplane_3_Runs_z.mat', partition);
    filename_lh_oc_path = fullfile(DataDir, filename_lh_oc);
    filename_rh_oc = sprintf('csym_all_rh_vtc_%s_olderc_inplane_3_Runs_z.mat', partition);
    filename_rh_oc_path = fullfile(DataDir, filename_rh_oc);
    load(filename_lh_oc_path)
    olderc_lh = lh_combinedcsymmatrix; 
    load(filename_rh_oc_path)
    olderc_rh = rh_combinedcsymmatrix;
   
    clear rh_combinedcsymmatrix lh_combinedcsymmatrix 

    %% get adult data as well
    filename_lh_ad = sprintf('csym_all_lh_vtc_%s_adults_inplane_3_Runs_z.mat', partition);
    filename_lh_ad_path = fullfile(DataDir, filename_lh_ad);
    filename_rh_ad = sprintf('csym_all_rh_vtc_%s_adults_inplane_3_Runs_z.mat', partition);
    filename_rh_ad_path = fullfile(DataDir, filename_rh_ad);
    load(filename_lh_ad_path)
    adults_lh = lh_combinedcsymmatrix; 
    load(filename_rh_ad_path)
    adults_rh = rh_combinedcsymmatrix;

    clear rh_combinedcsymmatrix lh_combinedcsymmatrix 
     
     %% prepare for plotting
     % The loaded combinedcsymmatrix has
     % 10 rows x 10 columns (representing the categories) and session as a third
     % dimension.Categories are in the following order (W = words, N = Numbers):
     % 1 2 3 4 5 6 7 8 9 10
     % A K B L C G P H W N

    group = cat(1, repmat([1], length(youngc_lh),1), repmat([2], length(olderc_lh),1), repmat([3], length(adults_lh),1));
    
    % words
    ww_yc_lh = reshape(youngc_lh(9,9,:),[length(youngc_lh(9,9,:)),1]);
    ww_oc_lh = reshape(olderc_lh(9,9,:),[length(olderc_lh(9,9,:)),1]);
    ww_ad_lh = reshape(adults_lh(9,9,:),[length(adults_lh(9,9,:)),1]);
    
    % combine data for all groups
    w_w = [ww_yc_lh; ww_oc_lh; ww_ad_lh];
    
    % numbers
    nn_yc_lh = reshape(youngc_lh(10,10,:),[length(youngc_lh(10,10,:)),1]);
    nn_oc_lh = reshape(olderc_lh(10,10,:),[length(olderc_lh(10,10,:)),1]);
    nn_ad_lh = reshape(adults_lh(10,10,:),[length(adults_lh(10,10,:)),1]);
    
    % combine data for groups
    n_n = [nn_yc_lh; nn_oc_lh; nn_ad_lh];
    
    % wordsnumbers
    wn_yc_lh = reshape(youngc_lh(9,10,:),[length(youngc_lh(9,10,:)),1]);
    wn_oc_lh = reshape(olderc_lh(9,10,:),[length(olderc_lh(9,10,:)),1]);
    wn_ad_lh = reshape(adults_lh(9,10,:),[length(adults_lh(9,10,:)),1]);

    w_n = [wn_yc_lh; wn_oc_lh; wn_ad_lh];
    
    % words all nonwords
    wnw_yc_lh = reshape(mean(youngc_lh(9,1:8,:),2), [length(mean(youngc_lh(9,1:8,:),2)),1]);
    wnw_oc_lh = reshape(mean(olderc_lh(9,1:8,:),2), [length(mean(olderc_lh(9,1:8,:),2)),1]);
    wnw_ad_lh = reshape(mean(adults_lh(9,1:8,:),2), [length(mean(adults_lh(9,1:8,:),2)),1]);
    
    w_nw = [wnw_yc_lh; wnw_oc_lh; wnw_ad_lh];
   
    % numbers all nonnumbers
    nnn_yc_lh = reshape(mean(youngc_lh(10,1:8,:),2), [length(mean(youngc_lh(10,1:8,:),2)),1]);
    nnn_oc_lh = reshape(mean(olderc_lh(10,1:8,:),2), [length(mean(olderc_lh(10,1:8,:),2)),1]);
    nnn_ad_lh = reshape(mean(adults_lh(10,1:8,:),2), [length(mean(adults_lh(10,1:8,:),2)),1]);
    
    n_nn = [nnn_yc_lh; nnn_oc_lh; nnn_ad_lh];
    
   
    %% right hemisphere
    
    % words
    ww_yc_rh = reshape(youngc_rh(9,9,:),[length(youngc_rh(9,9,:)),1]);
    ww_oc_rh = reshape(olderc_rh(9,9,:),[length(olderc_rh(9,9,:)),1]);
    ww_ad_rh = reshape(adults_rh(9,9,:),[length(adults_rh(9,9,:)),1]);
    w_w_rh = [ww_yc_rh; ww_oc_rh; ww_ad_rh];
    
    % numbers
    nn_yc_rh = reshape(youngc_rh(10,10,:),[length(youngc_rh(10,10,:)),1]);
    nn_oc_rh = reshape(olderc_rh(10,10,:),[length(olderc_rh(10,10,:)),1]);
    nn_ad_rh = reshape(adults_rh(10,10,:),[length(adults_rh(10,10,:)),1]);
    n_n_rh = [nn_yc_rh; nn_oc_rh; nn_ad_rh];
    
    % wordsnumbers
    wn_yc_rh = reshape(youngc_rh(9,10,:),[length(youngc_rh(9,10,:)),1]);
    wn_oc_rh = reshape(olderc_rh(9,10,:),[length(olderc_rh(9,10,:)),1]);
    wn_ad_rh = reshape(adults_rh(9,10,:),[length(adults_rh(9,10,:)),1]);
    w_n_rh = [wn_yc_rh; wn_oc_rh; wn_ad_rh];
    
    % words all nonwords
    wnw_yc_rh = reshape(mean(youngc_rh(9,1:8,:),2), [length(mean(youngc_rh(9,1:8,:),2)),1]);
    wnw_oc_rh = reshape(mean(olderc_rh(9,1:8,:),2), [length(mean(olderc_rh(9,1:8,:),2)),1]);
    wnw_ad_rh = reshape(mean(adults_rh(9,1:8,:),2), [length(mean(adults_rh(9,1:8,:),2)),1]);
    w_nw_rh = [wnw_yc_rh; wnw_oc_rh; wnw_ad_rh];
   
    % numbers all nonnumbers
    nnn_yc_rh = reshape(mean(youngc_rh(10,1:8,:),2), [length(mean(youngc_rh(10,1:8,:),2)),1]);
    nnn_oc_rh = reshape(mean(olderc_rh(10,1:8,:),2), [length(mean(olderc_rh(10,1:8,:),2)),1]);
    nnn_ad_rh = reshape(mean(adults_rh(10,1:8,:),2), [length(mean(adults_rh(10,1:8,:),2)),1]);
    n_nn_rh = [nnn_yc_rh; nnn_oc_rh; nnn_ad_rh];
    
    %% other preparations for plotting. 

    figure('Position', [0, 0, 800, 500]);
    set(gcf,'color','white') 
    hold on

    % Number of rows
    nrows = 1;

    % w and h of each axis in normalized units
    axisw = 0.10;
    axish = (1 / nrows) * 0.85;
    
    % lets add some white space to give the figure more structure
    space = zeros(51,1);

    pairs_titles = {'w-w', 'n-n', '   ', 'w-n', '   ', 'w-nw', 'n-nn'};
    
    pairs_lh = { w_w,   n_n, space,  w_n, space,   w_nw,  n_nn};
    pairs_rh = { w_w_rh, n_n_rh, space, w_n_rh, space, w_nw_rh, n_nn_rh};

    axis_pos = [0 0.22 0.375 0.5 0.6250 0.75  0.875];

    %% make plots - seperate for the left and right hemisphere
    % Let's create the LEFT hemisphere plot first

     for p= 1:length(pairs_lh)
        axisl = axis_pos(p);
        
        if p ==1
          subplot('position', [axisl, 0.1, axisw+0.09, axish])
        else
           subplot('position', [axisl, 0.1, axisw, axish])
        end
   
        % boxplots
        boxplot(pairs_lh{p},group, 'Labels',{' 5-9', '10-12', '  22-26'}, 'Widths', 0.9,'Symbol', 'k.');
        hold on
        t_lh = title(sprintf(pairs_titles{p}));
        
        % adjust title position
        set(t_lh, 'Position', [2 -0.28 0]);
        
        box off
        % Color the boxes in the colors from our color scheme.
        mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

        b = findobj(gca,'Tag','Box');
        for j=1:length(b)
            patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
        end

        if p ~= 1
            set(gca, 'YColor', [1 1 1])
            set(gca, 'YTicklabel','')
        end
         if p == 1
             ylabel('Correlation');
        end
        
        % make the median lines nicer
        lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
        set(lines, 'Color', 'k');
        set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

        if p ~= 3 && p ~= 5 
            % add zero line but only for plots with data (not for spacings)
            r =refline(0,0);
            set(r,'Color',[0.5,0.5,0.5]);
            set(r,'LineStyle','-');
        else
            r =refline(0,0);
            set(r,'Color',[1,1,1]);
            set(r,'LineStyle','-');
        end

        % make axis fixed and look better
        ylim([-0.2 0.8]);
        xlim([0 4]);
      
        set(gca, 'TickLength', [0 0]);
        set (gca, 'box' , 'off')
        set(gca,'XTicklabel', []);
        set(gca, 'XColor', [1 1 1])
        hold on
     end

 %overall title

axes( 'Position', [0, 0, 1, 0.95] ) ;
set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) ;
text( 0.55, 0.965, sprintf('Left %s VTC', partition), 'FontSize', 11', 'FontWeight', 'Bold', ...
  'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom') ;

set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontName'), 'FontSize', 14)
hold off

figurename = sprintf('Fig_3_Boxplot_%s_correlations_wordsnumbers_others_lh', partition);
print(fullfile(ResultsDir, figurename), '-dpng', '-r600')


    %% other preparations for plotting. matlab gives subplots different sizes, 
    %when there are many of them. we dont want that
    figure('Position', [0, 0, 800, 500]);

  
    %% Now create the RIGHT hemisphere plot

     for r= 1:length(pairs_rh)

        axisl = axis_pos(r);
        
        if r ==1
          subplot('position', [axisl, 0.1, axisw+0.09, axish])
        else
           subplot('position', [axisl, 0.1, axisw, axish])
        end

        ylim([-0.2 0.75]);
        hold on
        set(gcf,'color','white') % background color white
        
        % boxplots
        boxplot(pairs_rh{r},group, 'Labels',{' 5-9', '10-12', '  22-26'}, 'Widths', 0.9,'Symbol', 'k.');
        t_rh = title(sprintf(pairs_titles{r}));
        
        % adjust title position
        set(t_rh, 'Position', [2 -0.28 0]);
        
        box off
        % Color the boxes in the colors from our color scheme.
        mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

        b = findobj(gca,'Tag','Box');
        for j=1:length(b)
            patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
        end

        if r ~= 1
            set(gca, 'YColor', [1 1 1])
            set(gca, 'YTicklabel','')
        end
         if r == 1
             ylabel('Correlation');
        end
        
        % make median lines look better
        lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
        set(lines, 'Color', 'k');
        set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

        if r ~= 3 && r ~= 5 
            %add zero line but only for plots with data (not spacings)
            r =refline(0,0);
            set(r,'Color',[0.5,0.5,0.5]);
            set(r,'LineStyle','-');
         else
            r =refline(0,0);
            set(r,'Color',[1,1,1]);
            set(r,'LineStyle','-');
        end

        % make axis fixed and look better
        ylim([-0.2 0.8]);
        xlim([0 4]);
        set(gca, 'TickLength', [0 0]);
        set (gca, 'box' , 'off')
        set(gca,'XTicklabel', []);
        set(gca, 'XColor', [1 1 1])
        hold on
     end

 %overall title
axes( 'Position', [0, 0, 1, 0.95] ) ;
set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) 

text( 0.55, 0.965, sprintf('Right %s VTC', partition), 'FontSize', 11', 'FontWeight', 'Bold', ...
  'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom') ;
  
set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontName'), 'FontSize', 14)

figurename = sprintf('Fig_3_Boxplot_%s_correlations_wordsnumbers_others_rh', partition);
print(fullfile(ResultsDir,figurename), '-dpng', '-r600')




end


end