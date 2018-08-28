% Plot correlations between WRMTword score and the classifier performance
% for characters in 
% a) only the voxels with a positive t value (out of the  30% most distinctive voxels) and 
% b) only the voxels with a negative t- value (out of the  30% most distinctive voxels)


function Fig_5d_5e

    DataDir = './data/lateral_VTC/correlations_with_behavior';
  
    % directory for plots 
    ResultsDir = './figures';


%% Load data.


% results from voxels with positive t-values (out of the 30% most
% distinctive voxels)
load(fullfile(DataDir, 'data_wta_behave_corr_combined_pos_chars_vs_all'));
table_high_chars_pos = combined_wta_behave;
clearvars combined_wta_behave

% results from voxels with negative t-values (out of the 30% most
% distinctive voxels)
load(fullfile(DataDir, 'data_wta_behave_corr_combined_neg_chars_vs_all'));
table_all_voxels_neg = combined_wta_behave;
clearvars combined_wta_behave


%% Plot data

% In each panel we want to plot the WRMTword score and the classification
% for characters in left lateral VTC in the corresponding voxels.

tables = {table_high_chars_pos, table_all_voxels_neg};


for t = 1:length(tables)
    
    if t ==1
        pref = 'pos';
    elseif t == 2
        pref = 'neg';
    end

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
    
    
    % select data based on hemisphere. We need the lh data
     wtachars_nonan = wtachars_lh_nonan;

    
    group_num = cat(1, repmat([1], length(find(strcmp(group_nonan, 'youngc'))),1),...
        repmat([2], length(find(strcmp(group_nonan, 'olderc'))),1),...
        repmat([3], length(find(strcmp(group_nonan, 'adults'))),1));
  
    figure('Position', [0, 0, 350, 450]);
    
    
    hold on

    scatter(wtachars_nonan,WRMTwords_nonan, 45, group_num, 'filled') 
    set(gcf,'color','white') % background color white
    set(gca, 'TickLength', [0 0.1])
   
    %add colorbar
    cmap = [[0.48 0.80 0.98];[0.11 0.46 .8];[0.98 0.5 0.447]];             
     colormap(cmap); 

    % compute the correlation 
    [rword, pword] = corrcoef(wtachars_nonan',WRMTwords_nonan');
    
      % also compute the correlation corrected for age (partial corr)
    [rc, pc] = partialcorr(wtachars_nonan', WRMTwords_nonan', age_nonan');
  
    
    % and add correlation lines.
    newline =  lsline; 

    
    if pword(1,2) < .05
        if pword(1,2) < .001
            text(0.03, 15, sprintf('\nr = %.2f\np < 0.001', rword(1,2)), 'Color', 'k'); 
        else
            text(0.03, 15, sprintf('\nr = %.2f\np = %.3f', rword(1,2), pword(1,2)),'Color', 'k'); 
        end
        % black line when correlation is significant
        set(newline(1),'LineWidth',4, 'Color', 'k')      
        
    else
        text(0.03, 15, sprintf('\nr = %.2f\np = %.2f', rword(1,2), pword(1,2)),'Color',[0.6 0.6 0.6]); 
        % make it a gray line when not significant
        set(newline(1),'LineWidth',2, 'LineStyle', '--','Color', [.6 .6 .6])  
    end
    % 
    if pc < .05
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
    

    hold off
   
    set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
    set(findall(gcf, '-property', 'FontSize'), 'FontSize', 12);
    set(gcf, 'PaperPositionMode', 'auto')
    if strcmp(pref, 'pos')
        fig_title = 'Fig_5d_Scatterplot_WTA_chars_lh_pos30_WRMTword';
    elseif strcmp(pref, 'neg')
        fig_title = 'Fig_5e_Scatterplot_WTA_chars_lh_neg30_WRMTword';
    end
    print(fullfile(ResultsDir, fig_title), '-dpng', '-r800')

       
end




end
