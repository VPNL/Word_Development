function []= Fig_1c()
% Plot motion values (within run and between run values) as box plots (kids - 5-9 year olds, 10-12 year olds, and adults)

DataDir = './data/motion';
ResultsDir = './figures';

% load data.
load(fullfile(DataDir, 'kids_within.mat'));
load(fullfile(DataDir, 'kids_between.mat'));
load(fullfile(DataDir, 'okids_within.mat'));
load(fullfile(DataDir, 'okids_between.mat'));
load(fullfile(DataDir, 'adults_within.mat'));
load(fullfile(DataDir, 'adults_between.mat'));                


 
%% lets make a boxplot

 figure('Position', [0, 0, 600, 500]);
 set(gcf,'color','white') % background color white
 box off
 subplot(1,2,1); 
 groups =[repmat(1,1,length(kids_within)) repmat(2,1,length(okids_within)) repmat(3,1,length(adults_within))];
 x  = [kids_within okids_within adults_within];
 boxplot(x, groups, 'labels', {'5-9','10-12','   22-28'}, 'Widths', 0.9,'Symbol', 'k.');
 color= [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];
 
 % color boxes.
 h = findobj(gca,'Tag','Box');
 for j=1:length(h)
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.7);
 end
 title(['  Within-run motion '], 'FontSize', 10,'Fontweight', 'bold', 'Color', [0 0 0]);

 
 ylabel('motion (voxels)','FontSize',10);    
 ylim([0 2.3]); 
 ah=gca;
 set(ah, 'Fontsize', 10);
 lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
 set(lines, 'Color', 'k');
 set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');
 set(gca, 'TickLength', [0 0]);
 set (gca, 'box' , 'off')
 
% let's add a line indicating the selection criteria (motion should be less
% than 2.1 voxels).
 r = refline([0 2.1]);
 set(r,'Color',[0.5,0.5,0.5], 'LineStyle', ':');

 hold on
 
 % subplot for between-run motion 
 subplot(1,2,2); hold;
 groups =[repmat(1,1,length(kids_between)) repmat(2,1,length(okids_between)) repmat(3,1,length(adults_between))];
 x  = [kids_between okids_between adults_between];
 boxplot(x, groups, 'labels', {'5-9','10-12','   22-28'},'Widths', 0.9,'Symbol', 'k.');
 set (gca, 'box' , 'off')
 set(gca, 'TickLength', [0 0]);
 h = findobj(gca,'Tag','Box');
 for j=1:length(h)
     patch(get(h(j),'XData'),get(h(j),'YData'),color(j,:),'FaceAlpha',.7);
 end
 
 lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
 set(lines, 'Color', 'k');
 set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');
 
  % let's add a line indicating the selection criteria (see above)
 l = refline([0 2.1]);
 set(l,'Color',[0.5,0.5,0.5], 'LineStyle', ':');
 
 title(['  Between-run motion '], 'FontSize', 10,'Fontweight', 'bold', 'Color', [0 0 0]);
 ylabel('motion (voxels)','FontSize',10);    
 ylim([0 2.3]); 
 ah=gca;
 set(ah, 'Fontsize', 10);
 normAxes;
 set(gca, 'TickLength', [0 0]);
 
 hold off
 
%% save figure 

set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 12)

print(fullfile(ResultsDir, 'Fig_1c_Boxplot_motion'), '-dpng', '-r600')


 
end
