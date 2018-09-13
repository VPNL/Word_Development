% Plot correlations between WRMTword score and the classifier performance
% in 
% a) all lateral VTC voxels
% b) 30% most discriminative chars-selective voxels only
% c) lateral VTC minus the (30%) most discriminative chars-selective voxels and 




function Fig_5a_5b_5c


    DataDir = './data/lateral_VTC/correlations_with_behavior';

    % directory for plots 
    ResultsDir = './figures';
    hemi = 'lh'; 


%% Load data.

% results from 30% voxels voxels with highest classification (absolute t-val)
load(fullfile(DataDir, 'data_wta_behave_corr_combined_absolute-high-chars-30prcnt'));
table_high_chars_abs_30 = combined_wta_behave;
clearvars combined_wta_behave

% all voxels in lateral VTC -MINUS  those 30% 
load(fullfile(DataDir, 'data_wta_behave_corr_combined_no-high-chars-30prcnt-abs'));
table_all_voxels_minus = combined_wta_behave;
clearvars combined_wta_behave

% all voxels
load(fullfile(DataDir, 'data_wta_behave_corr_combined'));
table_all = combined_wta_behave;
clearvars combined_wta_behave


%% Plot data

% In each panel we want to plot the WRMTword score and the classification
% for characters in the respective voxels (all, most discriminative, all-minus most discriminative) of left lateral VTC.

tables = {table_all, table_high_chars_abs_30,  table_all_voxels_minus};


for t = 1:length(tables)

    wtachars_lh = [tables{t}.wtacharacters_lh];
    WRMTwords   = [tables{t}.WRMTword];
    group       = {tables{t}.group};
    age       = [tables{t}.age];

    % There are some missing values in the behavioral scores, which we cannot
    % plot
    
   WRMTwords_nonan   = WRMTwords(~isnan(WRMTwords));
   wtachars_lh_nonan = wtachars_lh(~isnan(WRMTwords));
   group_nonan       = group(~isnan(WRMTwords));
   age_nonan       = age(~isnan(WRMTwords));
    
    
    % select data based on hemi - we want to plot lh data here.
   wtachars_nonan = wtachars_lh_nonan;

    
    group_num = cat(1, repmat([1], length(find(strcmp(group_nonan, 'youngc'))),1),...
        repmat([2], length(find(strcmp(group_nonan, 'olderc'))),1),...
        repmat([3], length(find(strcmp(group_nonan, 'adults'))),1));

     
    if t == 1
        figure('Position', [0, 0, 1200, 450]);
    end
    
    subplot(1,3,t);
    hold on

    scatter(wtachars_nonan,WRMTwords_nonan, 45, group_num, 'filled') 
    set(gcf,'color','white') % background color white
    set(gca, 'TickLength', [0 0.1])
   
    %add colorbar
    cmap = [[0.48 0.80 0.98];[0.11 0.46 .8];[0.98 0.5 0.447]];         
    colormap(cmap); C = colorbar('eastoutside');
    newPosition = [0.92 0.4 0.01 0.3];
    set(C,'Position', newPosition);
    set(get(C,'title'),'string','age'); 
    C.Box = 'off';
    C.TicksMode = 'manual'; C.Ticks = [ 1.3 2 2.7];
    C.TickLength = 0; C.TickLabels = {'5-9', '10-12', '22-28'};

    % compute the correlation and display it in the figure, plot in black
    % when it is significant and in gray when it is not
    [rword, pword] = corrcoef(wtachars_nonan',WRMTwords_nonan');
    
     % also compute the correlation corrected for age
    [rc, pc] = partialcorr(wtachars_nonan', WRMTwords_nonan', age_nonan');
  
    % add correlation lines.
    newline =  lsline; 

    
    if pword(1,2) < .05
        if pword(1,2) < .001
            text(0.03, 15, sprintf('\nr = %.2f\np < 0.001', rword(1,2)), 'Color', 'k'); 
        else
            text(0.03, 15, sprintf('\nr = %.2f\np = %.3f', rword(1,2), pword(1,2)),'Color', 'k'); 
        end
        % black line when significant
        set(newline(1),'LineWidth',4, 'Color', 'k')      
        
    else
        text(0.03, 15, sprintf('\nr = %.2f\np = %.2f', rword(1,2), pword(1,2)),'Color',[0.6 0.6 0.6]); 
        % make it a grey line when not significant
        set(newline(1),'LineWidth',2, 'LineStyle', '--','Color', [.6 .6 .6])  
    end
    % 
    if pc < .016
        if pc < .001
            text(0.5, 15, sprintf('controlled for age\nr = %.2f\np < 0.001', rc), 'Color', 'k'); 
        else
            text(0.5, 15, sprintf('controlled for age\nr = %.2f\np = %.3f', rc, pc),'Color', 'k'); 
        end

    else
        text(0.5, 15, sprintf('controlled for age\nr = %.2f\np = %.2f', rc, pc),'Color',[0.6 0.6 0.6]); 
    end

    
    % Add y and x labels.
    ylim([0 100]); xlim([0 1]); 
    set(gca,'yTick', [0 20 40 60 80 100], 'YTicklabel', [0 20 40 60 80 100]);
    set(gca, 'xTick', [0 0.2 0.4 0.6 0.8 1],'XTicklabel', [0 20 40 60 80 100]);
   
    ylabel('WRMT word score [% correct]'); xlabel('Character classification [% correct]');
    
    if t ~= 1
        set(gca, 'YColor', [1 1 1])
        set(gca, 'YTicklabel','')
    end
    hold off
end
hold off



% save plot
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 12);
set(gcf, 'PaperPositionMode', 'auto')
fig_title = sprintf('Fig_5abc_Scatterplot_WTA_chars_%s_abs_nonabs_WRMTword', hemi);
print(fullfile(ResultsDir, fig_title), '-dpng', '-r800')


end
