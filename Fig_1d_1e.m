% Plots the number of all voxels and of word-selective voxels in lateral and medial vtc.
% Please use Matlab version 2014a or newer.

function Fig_1d_1e

lateral_vtc_dataDir = './data/lateral_VTC';
medial_vtc_dataDir = './data/medial_VTC';

ResultsDir = './figures';

%% Lets plot the number of word-selective voxels first. 
%  load lateral data.

% get adult data lateral
load(fullfile(lateral_vtc_dataDir,'nr_high-word_voxels_adults.mat'));
nr_voxels_adults_lateral = nrselective_voxels;
clearvars nrselective_voxels

% older children lateral
load(fullfile(lateral_vtc_dataDir,'nr_high-word_voxels_olderc.mat'));
nr_voxels_olderc_lateral = nrselective_voxels;
clearvars nrselective_voxels

% young children lateral
load(fullfile(lateral_vtc_dataDir,'nr_high-word_voxels_youngc.mat'));
nr_voxels_youngc_lateral = nrselective_voxels;
clearvars nrselective_voxels

%% load medial data

% get adult data 
load(fullfile(medial_vtc_dataDir,'nr_high-word_voxels_adults.mat'));
nr_voxels_adults_medial = nrselective_voxels;
clearvars nrselective_voxels

% older children 
load(fullfile(medial_vtc_dataDir,'nr_high-word_voxels_olderc.mat'));
nr_voxels_olderc_medial = nrselective_voxels;
clearvars nrselective_voxels

% young children 
load(fullfile(medial_vtc_dataDir,'nr_high-word_voxels_youngc.mat'));
nr_voxels_youngc_medial = nrselective_voxels;
clearvars nrselective_voxels

%% prepare for plotting

lateral_high_word = cat(1,mean(nr_voxels_youngc_lateral,2), mean(nr_voxels_olderc_lateral,2), mean(nr_voxels_adults_lateral,2));
medial_high_word = cat(1, mean(nr_voxels_youngc_medial,2),  mean(nr_voxels_olderc_medial,2), mean(nr_voxels_adults_medial,2));
group = cat(1, repmat([1], length(nr_voxels_youngc_lateral),1), repmat([2], length(nr_voxels_olderc_lateral),1), repmat([3], length(nr_voxels_adults_lateral),1));


%% let's make a plot

figure('Position', [0, 0, 600, 500]);

% lateral vtc
subplot(1,2,1)
set(gcf,'color','white') % background color white
box off

% boxplots
boxplot(lateral_high_word,group,'Labels',{'5-9 ', '10-12 ', '  22-28'},'Widths', 0.9,'Symbol', 'k.');
title('Lateral VTC')

% Color the boxes in the colors from our color scheme.
mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

b = findobj(gca,'Tag','Box');
for j=1:length(b)
    patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
end

% make the median lines look better
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');
set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

ylim([0 200]); 
ylabel('number of word-selective functional voxels','FontSize',12 ); 
set(gca, 'TickLength', [0 0]);
set (gca, 'box' , 'off')
    

%% create a similar plot for medial vtc data

subplot(1,2,2)
set(gcf,'color','white') % background color white
box off

% boxplots
boxplot(medial_high_word,group,'Labels',{' 5-9 ', '10-12', '  22-28'},'Widths', 0.9,'Symbol', 'k.');
title('Medial VTC')

% Color the boxes in the colors from our color scheme.
mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

b = findobj(gca,'Tag','Box');
for j=1:length(b)
    patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
end

set(gca, 'TickDir', 'out' )
set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])

%make median lines look better
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');
set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

ylim([0 200]); 
ylabel('number of selective voxels','FontSize',12 ); 
set(gca, 'TickLength', [0 0]);
set (gca, 'box' , 'off')



%% save figure
set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 12)

print(fullfile(ResultsDir,'Fig_1e_Boxplot_nr_highly_selective_voxels'), '-dpng', '-r600')
savefig(fullfile(ResultsDir,'Fig_1e_Boxplot_nr_highly_selective_voxels'));


%% Now make a similar plot but for all voxels in lateral and medial vtc.
% lateral vtc

load(fullfile(lateral_vtc_dataDir,'nr_all_voxels_adults.mat'));
nr_all_voxels_adults_lateral = nrselective_voxels;
clearvars nrselective_voxels

load(fullfile(lateral_vtc_dataDir,'nr_all_voxels_olderc.mat'));
nr_all_voxels_olderc_lateral = nrselective_voxels;
clearvars nrselective_voxels

load(fullfile(lateral_vtc_dataDir,'nr_all_voxels_youngc.mat'));
nr_all_voxels_youngc_lateral = nrselective_voxels;
clearvars nrselective_voxels

% medial vtc
load(fullfile(medial_vtc_dataDir,'nr_all_voxels_adults.mat'));
nr_all_voxels_adults_medial = nrselective_voxels;
clearvars nrselective_voxels

load(fullfile(medial_vtc_dataDir,'nr_all_voxels_olderc.mat'));
nr_all_voxels_olderc_medial = nrselective_voxels;
clearvars nrselective_voxels

load(fullfile(medial_vtc_dataDir, 'nr_all_voxels_youngc.mat'));
nr_all_voxels_youngc_medial = nrselective_voxels;
clearvars nrselective_voxels


%% prepare for plotting

lateral_all = cat(1,mean(nr_all_voxels_youngc_lateral,2), mean(nr_all_voxels_olderc_lateral,2), mean(nr_all_voxels_adults_lateral,2));
medial_all = cat(1, mean(nr_all_voxels_youngc_medial,2),  mean(nr_all_voxels_olderc_medial,2), mean(nr_all_voxels_adults_medial,2));
group = cat(1, repmat([1], length(nr_all_voxels_youngc_lateral),1), repmat([2], length(nr_all_voxels_olderc_lateral),1), repmat([3], length(nr_all_voxels_adults_lateral),1));

%% plot figure 2

figure('Position', [0, 0, 600, 500]);

% lateral vtc
subplot(1,2,1)
set(gcf,'color','white') % background color white
box off

% boxplots
boxplot(lateral_all,group,'Labels',{'5-9', ' 10-12  ', '   22-28'},'Widths', 0.9,'Symbol', 'k.');
title('Lateral VTC')

% Color the boxes in the colors from our color scheme.
mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

b = findobj(gca,'Tag','Box');
for j=1:length(b)
    patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
end

% make median lines look better
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');
set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

ylim([0 1400]); 
ylabel('number of functional voxels','FontSize',12 ); 
set(gca, 'TickLength', [0 0]);
set (gca, 'box' , 'off')

%% add medial vtc

subplot(1,2,2)
set(gcf,'color','white') % background color white
box off

% boxplots
boxplot(medial_all,group,'Labels',{' 5-9 ', '10-12  ', '  22-28'},'Widths', 0.9,'Symbol', 'k.');
title('Medial VTC')

% Color the boxes in the colors from our color scheme.
mycolors = [0.98 0.5 0.447; 0.11 0.56 1; 143/255 197/255 223/255];

b = findobj(gca,'Tag','Box');
for j=1:length(b)
    patch(get(b(j),'XData'),get(b(j),'YData'),mycolors(j, :),'FaceAlpha',.7);
end

set(gca, 'TickDir', 'out' )
set(gca,'ytick',[]);
set(gca,'ycolor',[1 1 1])
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 14)


%make median lines look better
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', 'k');
set(findobj(gcf, 'LineStyle', '--'), 'LineStyle', '-');

ylim([0 1400]); 
ylabel('number of functional voxels','FontSize',12 ); 
set(gca, 'TickLength', [0 0]);
set (gca, 'box' , 'off')

%% save plot 2

set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 12)
print(fullfile(ResultsDir,'Fig_1d_Boxplot_nr_of_voxels'), '-dpng', '-r600')
savefig(fullfile(ResultsDir,'Fig_1d_Boxplot_nr_of_voxels'));




end

