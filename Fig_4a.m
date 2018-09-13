%% Plot classification for words for different selectivity levels of voxels.


function Fig_4a

DataDir_all = './data/lateral_VTC/selectivity_analyses';
DataDir_high_word = './data/lateral_VTC/selectivity_analyses/word_selectivity';
DataDir_no_word = './data/lateral_VTC/selectivity_analyses/no_word_selectivity';
ResultsDir = './figures';

FunctionsDir = './functions';
addpath(FunctionsDir)

% We plot classification for words in a) all voxels (as lines), b) word-selective
% voxels, and c) non-word selective voxels
selectivity = {'all', 'no-high-word', 'high-word'};


for s= 1:length(selectivity)
    sel = selectivity{s};
    if strcmp(sel, 'all')
        DataDir = DataDir_all;
    elseif strcmp(sel, 'no-high-word')
        DataDir = DataDir_no_word;
    elseif strcmp(sel, 'high-word')
        DataDir = DataDir_high_word;
    end
    
    %% get data
    % LH
    file_list_lh=dir(fullfile(DataDir,'mean_correctC_lh_vtc_lateral_*_3_Runs_z_*.mat'));
    
    for f=1:length(file_list_lh)
        filename = file_list_lh(f,1).name;
        filename = fullfile(DataDir, filename);
        load(filename)
        
        if strcmp(filename((length(DataDir)+31):(length(DataDir)+36)), 'adults')
            lh_adults = mean_lh_correctC_avRuns;
            clearvars mean_lh_correctC_avRuns
        elseif strcmp(filename((length(DataDir)+31):(length(DataDir)+36)), 'olderc')
            lh_olderc = mean_lh_correctC_avRuns;
            clearvars mean_lh_correctC_avRuns
        elseif strcmp(filename((length(DataDir)+31):(length(DataDir)+36)), 'youngc')
            lh_youngc = mean_lh_correctC_avRuns;
            clearvars mean_lh_correctC_avRuns
        end
    end
    
    
    %% also get the number of voxels
    file_list_voxels=dir(fullfile(DataDir,'nr_*_voxels_*.mat'));
    
    for v = 1:length(file_list_voxels)
        filename_voxels = file_list_voxels(v,1).name;
        filename_voxels = fullfile(DataDir, filename_voxels);
        load(filename_voxels)
              
        if strcmp(filename_voxels(end-9:end-4), 'adults')
            nr_voxels_adults = nrselective_voxels;
            clearvars nrselective_voxels
        elseif strcmp(filename_voxels(end-9:end-4), 'olderc')
            nr_voxels_olderc = nrselective_voxels;
            clearvars nrselective_voxels
        elseif strcmp(filename_voxels(end-9:end-4), 'youngc')
            nr_voxels_youngc = nrselective_voxels;
            clearvars mnrselective_voxels
        end
        
    end
    
    % combine voxels numbers. voxels from the rh are in first column and
    % from the lh in the second column. we want to average across hemis. We
    % can add these numbers below the plot. Display the numbers, so we can
    % add these to the plot.
    nr_voxels_all = cat(1,mean(nr_voxels_youngc,2), mean(nr_voxels_olderc,2), mean(nr_voxels_adults,2));
    mean_nr_voxels = mean(nr_voxels_all)
    sd_nr_voxels = std(nr_voxels_all)
    
    nr_voxels_lh = cat(1,mean(nr_voxels_youngc(:,2)), mean(nr_voxels_olderc(:,2)), mean(nr_voxels_adults(:,2)));
    mean_nr_voxels_lh = mean(nr_voxels_lh)
    sd_nr_voxels_lh = std(nr_voxels_lh)
    
    
    
    
    %% PREPARE FOR PLOTTING

    % words are stored in the 9th column
    all_lh = [lh_youngc(:,9) lh_olderc(:,9) lh_adults(:,9)];
 
    % prepare data for bar graph; 
    MeanAdultsWords_lh(s)=lh_adults(1,9); SemAdultsWords_lh(s)=lh_adults(3,9);
    MeanOCWords_lh(s)=lh_olderc(1,9);    SemOCWords_lh(s)=lh_olderc(3,9);
    MeanYCWords_lh(s)=lh_youngc(1,9);  SemYCWords_lh(s)=lh_youngc(3,9);

    if s==1
        childbaseline=all_lh(1);
    end    
   
    
end


%% PLOT

% plot bar graph
figure('Position', [250, 250, 250, 450],'Color',[ 1 1 1]);

group_yc = [0.6,1.4];
group_oc = [1.6,2.4];
group_ad = [2.6,3.4];


% plot selective and non selective voxels as bars 
Mean_lh_sel=[MeanYCWords_lh(1,2:3); MeanOCWords_lh(1,2:3); MeanAdultsWords_lh(1,2:3)];
SEM_lh_sel=[SemYCWords_lh(1,2:3); SemOCWords_lh(1,2:3); SemAdultsWords_lh(1,2:3)];

% we want to plot classification in all voxels 
yc_all_mean = repmat(MeanYCWords_lh(1,1),1,2);
yc_all_sem = repmat(SemYCWords_lh(1,1),1,2);

oc_all_mean = repmat(MeanOCWords_lh(1,1),1,2);
oc_all_sem = repmat(SemOCWords_lh(1,1),1,2);

ad_all_mean = repmat(MeanAdultsWords_lh(1,1),1,2);
ad_all_sem = repmat(SemAdultsWords_lh(1,1),1,2);

mycolors=[.7 .7  1; .1 .1 .3];


mybar(100*Mean_lh_sel, 100*SEM_lh_sel,[],[], mycolors);
ylim([0 100]);
box off
set(gca,'XtickLabel',{'5-9' ,'10-12','22-28'})
ylabel('Word Classification [% correct]','FontSize',12);
xlabel('Age group [years]','FontSize',12);
title ('Left lateral VTC','FontSize',12)

hold on

a1 = errorbar3(group_yc, yc_all_mean*100, yc_all_sem*100,1,[ 0.8 .8 .8]);
plot(group_yc, yc_all_mean*100,'LineWidth',2,'Color',[0 0 0 ]);

a2 = errorbar3(group_oc, oc_all_mean*100, oc_all_sem*100,1,[ 0.8 .8 .8]);
plot(group_oc, oc_all_mean*100,'LineWidth',2,'Color',[0 0 0]);

a3 = errorbar3(group_ad, ad_all_mean*100, ad_all_sem*100,1,[ 0.8 .8 .8]);
plot(group_ad, ad_all_mean*100,'LineWidth', 2,'Color',[0 0 0]);

alpha(a1,.5)
alpha(a2,.5)
alpha(a3,.5)

hold off

%save figure
 figurename = sprintf('Fig_4a_Classifier_bar_words_selectivity_levels_lh_witherrorbar');
 print(fullfile(ResultsDir,figurename), '-dpng', '-r600')
end





