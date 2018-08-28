% Plot character classification for different percentages of voxels (from
% 10% to 100% of voxels) for voxels sorted by character-selectivity, that is by their t-values (here
% called selective sorting) or sorted by their absolute t-values (called absolute sorting).

function Fig_4e_4f(sorting)

contrast_name = 'chars';

if strcmp(sorting, 'selective')
    DataDir='./data/lateral_VTC/selectivity_analyses/chars_selective_voxels_percent';
elseif strcmp(sorting, 'absolute')
    DataDir= './data/lateral_VTC/selectivity_analyses/chars_absolute_voxels_percent';
end

FunctionsDir = './functions';
addpath(FunctionsDir)
    
ResultsDir = './figures';

% data are stored in matrices with the following format:
% number of domains (5) x sessions x voxel numbers
% (10, 20 , 30, 40, 50, 60, 70, 80, 90, 100 % of voxels)

% we plot the data for 10 different levels of voxel umbers ranging from 10%
% to 100% of voxels. Increasing in steps of 10.
nr_voxel_percent = 10;

%% get data - young children
load(fullfile(DataDir, 'correctSO_avRuns_lh_youngc_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctSO_avRuns_rh_youngc_inplane_3_Runs_z_topvoxels.mat'))

youngc_lh = lh_correctSO_avRuns_all(5,:,:);
youngc_rh = rh_correctSO_avRuns_all(5,:,:);

youngc_rh = reshape(youngc_rh,[length(youngc_rh) nr_voxel_percent]);
youngc_lh = reshape(youngc_lh,[length(youngc_lh) nr_voxel_percent]);

clearvars lh_correctSO_avRuns_all rh_correctSO_avRuns_all

%% older children
load(fullfile(DataDir,'correctSO_avRuns_lh_olderc_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctSO_avRuns_rh_olderc_inplane_3_Runs_z_topvoxels.mat'))

olderc_lh = lh_correctSO_avRuns_all(5,:,:);
olderc_rh = rh_correctSO_avRuns_all(5,:,:);

olderc_rh = reshape(olderc_rh,[length(olderc_rh) nr_voxel_percent]);
olderc_lh = reshape(olderc_lh,[length(olderc_lh) nr_voxel_percent]);

clearvars lh_correctSO_avRuns_all rh_correctSO_avRuns_all

%% adults
load(fullfile(DataDir,'correctSO_avRuns_lh_adults_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctSO_avRuns_rh_adults_inplane_3_Runs_z_topvoxels.mat'))

adults_lh = lh_correctSO_avRuns_all(5,:,:);
adults_rh = rh_correctSO_avRuns_all(5,:,:);

adults_rh = reshape(adults_rh,[length(adults_rh) nr_voxel_percent]);
adults_lh = reshape(adults_lh,[length(adults_lh) nr_voxel_percent]);

clearvars lh_correctSO_avRuns_all rh_correctSO_avRuns_all

%% prepare for plotting

voxel_nr = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
voxel_labels = {'10', '20', '30', '40', '50', '60', '70', '80', '90','100'};
hemis = {'Left lateral VTC', 'Right lateral VTC'};


youngc_both ={youngc_lh, youngc_rh};
olderc_both={olderc_lh, olderc_rh};
adults_both={adults_lh, adults_rh};

%% plotting

% general plot setting
figure('Position', [50, 50, 800, 600],'Color','w');

for c= 1:length(hemis)
    % two subplots: one for lh and one for rh (NOTE: rh data is now in the
    % supplements. Fig S4e and S4f).
    subplot(1,2,c)
    hold on
    errorbar3(voxel_nr, mean(adults_both{c},1), (std(adults_both{c})/sqrt(length(adults_both{c}))),1,[ 1 .5*1.5 .477*1.5])%[0.98 0.5 0.447])
    errorbar3(voxel_nr, mean(olderc_both{c},1), (std(olderc_both{c})/sqrt(length(olderc_both{c}))),1,[.11*1.5 .56*1.5 1]);%[0.11 0.56 1])
    errorbar3(voxel_nr, mean(youngc_both{c},1), (std(youngc_both{c})/sqrt(length(youngc_both{c}))),1,[1.2*143/255 1.1*197/255 1])%[143/255 197/255 223/255])
    plot(voxel_nr, zeros(size(voxel_nr)),'LineWidth',1,'Color',[0 0 0]);
    plot(voxel_nr, mean(adults_both{c},1),'LineWidth',3,'Color',[0.98 0.5 0.447]);
    plot(voxel_nr, mean(olderc_both{c},1),'LineWidth',3,'Color',[0.11 0.56 1]);
    plot(voxel_nr, mean(youngc_both{c},1),'LineWidth',3,'Color',[143/255 190/255 223/255]);
    ylim([0 1]);
    xlim([0 100])
    hold off
  
    set(gca,'XTickLabel',voxel_labels)
    % plot axis only for plots on the left

    set(gca,'YTicklabel', [0 10 20 30 40 50 60 70 80 90 100],'FontSize',14 )
    ylabel({'Character classification [% correct]'},'FontSize',14)

    set(gca,'xTick', [20, 40, 60, 80, 100], 'XTicklabel',{'20', '40', '60', '80','100'},'FontSize',14);
    set(gca, 'Ticklength', [0 0])
    title(hemis{c},'FontSize', 14)
    
    % indicate chance level
    r = refline([0 0.2]);
    set(r,'Color',[0.5,0.5,0.5])
    set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
    
end



% plot overall legend
hL=legend ({'22-28','10-12','5-9'}, 'Orientation','vertical');
if strcmp(sorting, 'selective')
    newPosition = [0.85 0.75 0.01 0.1];
elseif strcmp(sorting, 'absolute')
    newPosition = [0.85 0.35 0.01 0.1];
end
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits, 'LineWidth', 3 );
set(hL, 'box', 'off')

if strcmp(sorting, 'selective')
    text(-115, -0.1, sprintf('%% of most selective voxels (contrast: %s vs all)', contrast_name), 'FontSize', 14)
elseif strcmp(sorting, 'absolute')
    text(-130, -0.1, sprintf('%% of voxels sorted by absolute t-values (contrast: %s vs all)', contrast_name),'FontSize', 14)
end


if strcmp(sorting, 'selective')
    figure_title = sprintf('Fig_4e_S4e_Classifier_line_wta_chars_vs_all_percent_%s',sorting);
elseif strcmp(sorting, 'absolute')
    figure_title = sprintf('Fig_4f_S4f_Classifier_line_wta_chars_vs_all_percent_%s',sorting);
end

print(fullfile(ResultsDir, figure_title), '-dpng', '-r900')



end