function Fig_2
% Plot the classification performance for characters, pseudowords and
% numbers in lateral and medial VTC and in the left and right hemisphere.


% Create path to data directory and to save the figure.
lateral_vtc_dataDir='./data/lateral_VTC';
medial_vtc_dataDir= './data/medial_VTC';
ResultsDir = './figures';


%% LH get data
% load data for adults.
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_lh_lateral_adults_inplane_3_Runs_z.mat'))
adults_lateral_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

% load data for older children
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_lh_lateral_olderc_inplane_3_Runs_z.mat'))
olderc_lateral_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

% load data for younger children
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_lh_lateral_youngc_inplane_3_Runs_z.mat'))
youngc_lateral_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

% medial VTC: adults
load(fullfile(medial_vtc_dataDir, 'mean_correctSO_lh_medial_adults_inplane_3_Runs_z.mat'))
adults_medial_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

% older children
load(fullfile(medial_vtc_dataDir,'mean_correctSO_lh_medial_olderc_inplane_3_Runs_z.mat'))
olderc_medial_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

% young children
load(fullfile(medial_vtc_dataDir,'mean_correctSO_lh_medial_youngc_inplane_3_Runs_z.mat'))
youngc_medial_lh = mean_lh_correctSO_avRuns;
clearvars  mean_lh_correctSO_avRuns

%% Rh get data
% load data for adults.
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_rh_lateral_adults_inplane_3_Runs_z.mat'))
adults_lateral_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

% load data for older children
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_rh_lateral_olderc_inplane_3_Runs_z.mat'))
olderc_lateral_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

% load data for younger children
load(fullfile(lateral_vtc_dataDir,'mean_correctSO_rh_lateral_youngc_inplane_3_Runs_z.mat'))
youngc_lateral_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

% medial
load(fullfile(medial_vtc_dataDir,'mean_correctSO_rh_medial_adults_inplane_3_Runs_z.mat'))
adults_medial_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctSO_rh_medial_olderc_inplane_3_Runs_z.mat'))
olderc_medial_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctSO_rh_medial_youngc_inplane_3_Runs_z.mat'))
youngc_medial_rh = mean_rh_correctSO_avRuns;
clearvars  mean_rh_correctSO_avRuns

%% combine data for plotting

% We have three groups and want to display the age group on the x axis.
% Youngest children should be on the left. We take the mean of each age groups' age
% and plot it on a log scale.
group = [log(6.92) log(10.54) log(23.81)];

% means: column 1(youngc), column 4 (olderc) and 7 (adults)
% std :  column 2 (youngc), column 5 (olderc) and 8 (adults)
% se :   column 3 (youngc), column 6 (olderc) and 9 (adults)
lh_lateral = cat(2, youngc_lateral_lh, olderc_lateral_lh, adults_lateral_lh);
rh_lateral = cat(2, youngc_lateral_rh, olderc_lateral_rh, adults_lateral_rh);

lh_medial =  cat(2, youngc_medial_lh, olderc_medial_lh, adults_medial_lh);
rh_medial =  cat(2, youngc_medial_rh, olderc_medial_rh, adults_medial_rh);

% Domains are saved as rows. So far, they are saved in the following order:
% " faces (1), bodies (2), objects (3), places (4) , chars (5)". We need
% only the data for characters for this plot.

category = 'Characters';
groupnames = { '5-9' '     10-12' '   22-28'};

%% Plot (a) characters
figure('Position', [100, 100, 1000, 800]);
box off
set(gcf,'color','w');

% lateral VTC

subplot(2,3,1)
errorbar(group, lh_lateral((5), [1 4 7]), lh_lateral((5), [3 6 9]), 'k','LineWidth',2.5)
hold on
% let's plot the right hemisphere into the same plots
errorbar(group, rh_lateral((5), [1 4 7]), rh_lateral((5), [3 6 9]), 'Color', [0.6 0.6 0.6],'LineWidth',2.5)
box off
ylim([0 1]);
xlim([1.5 log(35)])
set(gca,'XTick', [log(6.92) log(10.54) log(23.81)],'XTickLabel',groupnames, 'FontSize',8)
set(gca, 'YTicklabel', [0 20 40 60 80 100],'FontSize',12 )
set(gca, 'Ticklength', [0 0])
ylabel({'Classification [% correct]'},'FontSize',12)
xlabel('Age [years, log scale]')
title(category,'FontSize', 12)

% indicate chance level
r = refline([0 0.2]);
set(r,'Color',[0.5,0.5,0.5])
set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')


% plot character classification in
% medial VTC

subplot(2,3, 4)
errorbar(group, lh_medial((5), [1 4 7]), lh_medial((5), [3 6 9]), 'k', 'LineWidth', 2.5)
ylim([0 1]);
xlim([1.5 log(35)])
set(gca,'XTick', [log(6.92) log(10.54) log(23.81)], 'XTickLabel',groupnames, 'FontSize',8)
set(gca,'YTicklabel', [0 20 40 60 80 100],'FontSize',12 )
set(gca, 'Ticklength', [0 0])
box off
hold on
errorbar(group, rh_medial((5), [1 4 7]), rh_medial((5), [3 6 9]), 'Color', [0.6 0.6 0.6], 'LineWidth', 2.5)
ylabel({'Classification [% correct]'},'FontSize',12)
xlabel('Age [years, log scale]','FontSize',12)
% indicate chance level
r = refline([0 0.2]);
set(r,'Color',[0.5,0.5,0.5])
set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')

% plot overall legend
hL=legend ({'lh', 'rh'}, 'Orientation','horizontal');


newPosition = [0.2 0.50 0.1 0.2];
newUnits = 'normalized';
set(hL,'Position', newPosition,'Units', newUnits, 'LineWidth', 2 );
set(hL, 'box', 'off')

axes( 'Position', [0, 0, 0.2, 1] ) ;
set( gca, 'Color', 'None', 'XColor', 'White', 'YColor', 'White' ) ;
text( 0.2, 0.28, 'Medial VTC', 'FontSize', 12', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom','rotation',90) ;

text( 0.2, 0.76, 'Lateral VTC', 'FontSize', 12', 'FontWeight', 'Bold', ...
    'HorizontalAlignment', 'center', 'VerticalAlignment', 'Bottom','rotation',90 ) ;


%% plot (b) words/numbers (character types)

% get data - LH
%load data for adults.
load(fullfile(lateral_vtc_dataDir,'mean_correctC_lh_lateral_adults_inplane_3_Runs_z.mat'))
adults_lateral_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

% load data for older children
load(fullfile(lateral_vtc_dataDir,'mean_correctC_lh_lateral_olderc_inplane_3_Runs_z.mat'))
olderc_lateral_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

% load data for younger children
load(fullfile(lateral_vtc_dataDir,'mean_correctC_lh_lateral_youngc_inplane_3_Runs_z.mat'))
youngc_lateral_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

% load the same data in medial vtc
load(fullfile(medial_vtc_dataDir,'mean_correctC_lh_medial_adults_inplane_3_Runs_z.mat'))
adults_medial_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctC_lh_medial_olderc_inplane_3_Runs_z.mat'))
olderc_medial_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctC_lh_medial_youngc_inplane_3_Runs_z.mat'))
youngc_medial_lh = mean_lh_correctC_avRuns';
clearvars  mean_lh_correctC_avRuns

%% RH
% load data for adults.
load(fullfile(lateral_vtc_dataDir,'mean_correctC_rh_lateral_adults_inplane_3_Runs_z.mat'))
adults_lateral_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

% load data for older children
load(fullfile(lateral_vtc_dataDir,'mean_correctC_rh_lateral_olderc_inplane_3_Runs_z.mat'))
olderc_lateral_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

% load data for younger children
load(fullfile(lateral_vtc_dataDir,'mean_correctC_rh_lateral_youngc_inplane_3_Runs_z.mat'))
youngc_lateral_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

%medial
load(fullfile(medial_vtc_dataDir,'mean_correctC_rh_medial_adults_inplane_3_Runs_z.mat'))
adults_medial_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctC_rh_medial_olderc_inplane_3_Runs_z.mat'))
olderc_medial_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

load(fullfile(medial_vtc_dataDir,'mean_correctC_rh_medial_youngc_inplane_3_Runs_z.mat'))
youngc_medial_rh = mean_rh_correctC_avRuns';
clearvars  mean_rh_correctC_avRuns

%% PREPARE FOR PLOTTING 
%
group = [log(6.92) log(10.54) log(23.81)]; % we use the same x axis as in the character classification plots.
numconds = 2;
category = {'Pseudowords' 'Numbers'};
groupnames = { '5-9' '10-12' '22-28'};

% categories will be in rows (1: words, 2: numbers), columns represent mean, sd and se
% of the three groups, so children column 1-3, olderc_ column 4-6, adults column 7-9
% with the first column in each group being the mean, followed by se, and by sd.
% Words and numbers are saved in the 9th and 10th row (respectively) in the
% loaded matrices.
wn_lateral_lh = cat(2, youngc_lateral_lh(9:10,:), olderc_lateral_lh(9:10,:), adults_lateral_lh(9:10,:));
wn_lateral_rh = cat(2, youngc_lateral_rh(9:10,:), olderc_lateral_rh(9:10,:), adults_lateral_rh(9:10,:));
wn_medial_lh  = cat(2, youngc_medial_lh(9:10,:),  olderc_medial_lh(9:10,:),  adults_medial_lh(9:10,:));
wn_medial_rh  = cat(2, youngc_medial_rh(9:10,:),  olderc_medial_rh(9:10,:),  adults_medial_rh(9:10,:));

%% plot
for c= 1:numconds
    
   subplot(2,3,1+c)
   %plot lh
   errorbar(group, wn_lateral_lh(c,[1 4 7]), wn_lateral_lh(c,[3 6 9]), 'k','LineWidth',2.5)
   hold on 
   % let's plot the right hemisphere into the same plots
   errorbar(group, wn_lateral_rh(c,[1 4 7]), wn_lateral_rh(c,[3 6 9]), 'Color', [0.6 0.6 0.6],'LineWidth',2.5)
   box off
   ylim([0 1]);
   xlim([1.5 log(35)])
   set(gca,'XTick', [log(6.92) log(10.54) log(23.81)],'XTickLabel',groupnames)
   set(gca,'YTicklabel', [0 20 40 60 80 100],'FontSize',9 )
   set(gca, 'Ticklength', [0 0])
   ylabel({'Classification [% correct]'},'FontSize',12)
   xlabel('Age [years, log scale]','FontSize',12)
   title(category{c},'FontSize', 12)

   % indicate chance level
    r = refline([0 0.1]);
   set(r,'Color',[0.5,0.5,0.5])
   set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
  
   % plot axis only for plots on the left
   if c > 1
        set(gca, 'TickDir', 'out' )
        set(gca,'ytick',[]);
        set(gca,'ycolor',[1 1 1])
   end
   hold off
end

%% medial data
for cm = 1:numconds
    subplot(2,3,4+cm)
    errorbar(group, wn_medial_lh(cm,[1 4 7]), wn_medial_lh(cm,[3 6 9]), 'k','LineWidth',2.5)
    hold on
    errorbar(group, wn_medial_rh(cm,[1 4 7]), wn_medial_rh(cm,[3 6 9]), 'Color', [0.6 0.6 0.6],'LineWidth',2.5)
    box off
    ylim([0 1]);
    xlim([1.5 log(35)])
    set(gca,'XTick', [log(6.92) log(10.54) log(23.81)],'XTickLabel',groupnames)
    set(gca, 'YTicklabel', [0 20 40 60 80 100],'FontSize',10)
    ylabel({'Classification [% correct]'},'FontSize',12)
    xlabel({'Age [years, log scale]'},'FontSize',12)
    set(gca, 'Ticklength', [0 0])
    % indicate chance level
    r = refline([0 0.1]);
    set(r,'Color',[0.5,0.5,0.5])
    set(get(get(r,'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
    box off
    % plot axis only for plots on the left
    if cm > 1
        %e.AlignVertexCenters ='on'
        set(gca, 'TickDir', 'out' )
        set(gca,'ytick',[]);
        set(gca,'ycolor',[1 1 1])
    end
end


% save figure with right settings
set(gcf, 'PaperPositionMode', 'auto')
set(findall(gcf, '-property', 'FontName'), 'FontName', 'Arial')
set(findall(gcf, '-property', 'FontSize'), 'FontSize', 11)


print(fullfile(ResultsDir,'Fig_2_chars_words_numbers_Classifier_linegraph_all_groups'), '-dpng', '-r900')
savefig(fullfile(ResultsDir,'Fig_2_chars_words_numbers_Classifier_linegraph_all_groups'))


end
