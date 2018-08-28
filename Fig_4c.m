function Fig_4c

% Plot classification accuracy for different percentages of voxels. Voxels
% are sorted by their ABSOLUTE t-values (for the contrast: words-vs-all).

contrast_name = 'words';
DataDir='./data/lateral_VTC/selectivity_analyses/words_absolute_voxels_percent';
FunctionsDir = './functions';
addpath(FunctionsDir)
ResultsDir = './figures';


% data are stored in matrices with the following format:
% number of sessions x categories (10) x voxel numbers
% (10, 20 , 30, 40, 50, 60, 70, 80, 90, 100 % of voxels)

% we only need words (column 9)

% we have ten levels of voxels percentages from 10 to 100% increasing in
% steps of 10.
nr_voxel_percent = 10;


%% get data - young children

load(fullfile(DataDir,'correctC_lh_youngc_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctC_rh_youngc_inplane_3_Runs_z_topvoxels.mat'))

youngc_lh = lh_correctC_avRuns_all(:,9,:);
youngc_rh = rh_correctC_avRuns_all(:,9,:);

youngc_rh = reshape(youngc_rh,[length(youngc_rh) nr_voxel_percent]);
youngc_lh = reshape(youngc_lh,[length(youngc_lh) nr_voxel_percent]);

clearvars lh_correctC_avRuns_all rh_correctC_avRuns_all

%% get data  - older children
load(fullfile(DataDir,'correctC_lh_olderc_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctC_rh_olderc_inplane_3_Runs_z_topvoxels.mat'))

olderc_lh = lh_correctC_avRuns_all(:,9,:);
olderc_rh = rh_correctC_avRuns_all(:,9,:);

olderc_lh = reshape(olderc_lh,[length(olderc_lh) nr_voxel_percent]);
olderc_rh = reshape(olderc_rh,[length(olderc_rh) nr_voxel_percent]);

clearvars lh_correctC_avRuns_all rh_correctC_avRuns_all

%% get data - adults
load(fullfile(DataDir,'correctC_lh_adults_inplane_3_Runs_z_topvoxels.mat'))
load(fullfile(DataDir,'correctC_rh_adults_inplane_3_Runs_z_topvoxels.mat'))

adults_lh = lh_correctC_avRuns_all(:,9,:);
adults_rh = rh_correctC_avRuns_all(:,9,:);

adults_lh = reshape(adults_lh,[length(adults_lh) nr_voxel_percent]);
adults_rh = reshape(adults_rh,[length(adults_rh) nr_voxel_percent]);
clearvars lh_correctC_avRuns_all rh_correctC_avRuns_all

%% PREPARE FOR PLOTTING


voxel_nr = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100];
voxel_labels = {'10', '20', '30', '40', '50', '60', '70', '80', '90','100'};
hemis = {'Left lateral VTC', 'Right lateral VTC'};

youngc_both ={youngc_lh, youngc_rh};
olderc_both={olderc_lh, olderc_rh};
adults_both={adults_lh, adults_rh};


%% plotting


% NOTE: data of the right hemisphere, which is shown on the
% right side of the plot made by this script is now in the supplements (Fig S4c).

% general plot setting
f2=figure('Position', [50, 50, 800, 600],'Color','w');

for c= 1:length(hemis)
    % two subplots: one for lh and one for rh
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
    if c==1
        set(gca,'YTicklabel', [0 10 20 30 40 50 60 70 80 90 100],'FontSize',14 )
         ylabel({'Word classification [% correct]'},'FontSize',16)
    else
        set(gca,'ytick',[]);
        set(gca,'ycolor',[1 1 1])
    end
    set(gca,'xTick', [20, 40, 60, 80, 100], 'XTicklabel',{'20', '40', '60', '80','100'},'FontSize',14);
    set(gca, 'Ticklength', [0 0])
    title(hemis{c},'FontSize', 14)
    
    % indicate chance level
    r = refline([0 0.1]);
    set(r,'Color',[0.5,0.5,0.5])
    set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
    
end


% plot overall legend
hL=legend ({'22-28','10-12','5-9'}, 'Orientation','vertical');
newPosition = [0.85 0.75 0.01 0.1];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits, 'LineWidth', 3 );
set(hL, 'box', 'off')
text(-140, -0.1, sprintf('%% of voxels sorted by absolute t-values (contrast: %s vs all)', contrast_name),'FontSize',14)

%save plot - NOTE: data of the right hemisphere, which is shown on the
%right side of the plot here is now in the supplements (Fig S4c).
set(f2, 'PaperPositionMode', 'auto')
filename = sprintf('Fig_4c_S4c_Classifier_wta_%s_percent_abs_voxels', contrast_name);
print(fullfile(ResultsDir, filename), '-dpng', '-r900');


end