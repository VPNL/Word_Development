%% Plot classification for characters for different selectivity levels of voxels (all voxels, character-selective voxels and non-character-selective voxels).


function Fig_4d


 DataDir_all='./data/lateral_VTC/selectivity_analyses';
 DataDir_highChars = './data/lateral_VTC/selectivity_analyses/chars_selectivity';
 DataDir_nohighChars = './data/lateral_VTC/selectivity_analyses/no_chars_selectivity';
 ResultsDir = './figures';

FunctionsDir = './functions';
addpath(FunctionsDir)

selectivity = {'all', 'no-high-chars', 'high-chars'};


for s= 1:length(selectivity)
    sel = selectivity{s};
    if strcmp(sel, 'all')
        DataDir = DataDir_all;
    elseif strcmp(sel, 'no-high-chars')
        DataDir = DataDir_nohighChars;
    elseif strcmp(sel, 'high-chars')
        DataDir = DataDir_highChars;
    end
    
    %% get data
    % LH

    file_list_lh=dir(fullfile(DataDir,'mean_correctSO_lh*_lateral_*_inplane_3_Runs_z*.mat'));

    for f=1:length(file_list_lh)
        filename = file_list_lh(f,1).name;
        filename = fullfile(DataDir, filename);
        load(filename)
        
        
        if strcmp(filename((length(DataDir)+32):(length(DataDir)+37)), 'adults')
            lh_adults = mean_lh_correctSO_avRuns;
            clearvars mean_lh_correctSO_avRuns
        elseif strcmp(filename((length(DataDir)+32):(length(DataDir)+37)), 'olderc')
            lh_olderc = mean_lh_correctSO_avRuns;
            clearvars mean_lh_correctSO_avRuns
        elseif strcmp(filename((length(DataDir)+32):(length(DataDir)+37)), 'youngc')
            lh_youngc = mean_lh_correctSO_avRuns;
            clearvars mean_lh_correctSO_avRuns
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
        elseif strcmp( filename_voxels(end-9:end-4), 'youngc')
            nr_voxels_youngc = nrselective_voxels;
            clearvars mnrselective_voxels
        end
        
    end
    
    % combine voxels numbers. voxels from the rh are in first column and
    % from the lh in the second column. 
    % across hemis:
    nr_voxels_all = cat(1,mean(nr_voxels_youngc,2), mean(nr_voxels_olderc,2), mean(nr_voxels_adults,2));
    mean_nr_voxels = mean(nr_voxels_all)
    sd_nr_voxels = std(nr_voxels_all);
    
    % lh only: 
    nr_voxels_lh = cat(1,mean(nr_voxels_youngc(:,2)), mean(nr_voxels_olderc(:,2)), mean(nr_voxels_adults(:,2)));
    mean_nr_voxels_lh = mean(nr_voxels_lh);
    sd_nr_voxels_lh = std(nr_voxels_lh)
    

    %% PREPARE FOR PLOTTING
    % we only need the data for chars - these are in row 5
    group = [log(6.92) log(10.54) log(23.81)];

    % Chars are stored in the last row
    all_lh = [lh_youngc(5,:) lh_olderc(5,:) lh_adults(5,:)];

    
    % prepare data for bar graph;
    MeanAdultsChars_lh(s)=lh_adults(5,1); SemAdultsChars_lh(s)=lh_adults(5,3);
    MeanOCChars_lh(s)=lh_olderc(5,1);    SemOCChars_lh(s)=lh_olderc(5,3);
    MeanYCChars_lh(s)=lh_youngc(5,1);  SemYCChars_lh(s)=lh_youngc(5,3);

    if s==1
        childbaseline=all_lh(1)
    end    

end



%% plot bar graph LH

figure('Position', [250, 250, 250, 450],'Color',[ 1 1 1]);

group_yc = [0.6,1.4];
group_oc = [1.6,2.4];
group_ad = [2.6,3.4];


% plot selective and non selective voxels as bars 
Mean_lh_sel=[MeanYCChars_lh(1,2:3); MeanOCChars_lh(1,2:3); MeanAdultsChars_lh(1,2:3)];
SEM_lh_sel=[SemYCChars_lh(1,2:3); SemOCChars_lh(1,2:3); SemAdultsChars_lh(1,2:3)];

% we want to plot classification in all voxels 

yc_all_mean = repmat(MeanYCChars_lh(1,1),1,2);
yc_all_sem = repmat(SemYCChars_lh(1,1),1,2);

oc_all_mean = repmat(MeanOCChars_lh(1,1),1,2);
oc_all_sem = repmat(SemOCChars_lh(1,1),1,2);

ad_all_mean = repmat(MeanAdultsChars_lh(1,1),1,2);
ad_all_sem = repmat(SemAdultsChars_lh(1,1),1,2);

mycolors=[.7 .7  1; .1 .1 .3];

mybar(100*Mean_lh_sel, 100*SEM_lh_sel,[],[], mycolors);
 ylim([0 100]);
 box off
 set(gca,'XtickLabel',{'5-9' ,'10-12','22-28'})
ylabel('Character Classification [% correct]','FontSize',12);
xlabel('Age group [years]','FontSize',12);
title ('Left lateral VTC','FontSize',12)

hold on

a1 = errorbar3(group_yc, yc_all_mean*100, yc_all_sem*100,1,[ 0.8 .8 .8])
plot(group_yc, yc_all_mean*100,'LineWidth',2,'Color',[0 0 0 ]);

a2 = errorbar3(group_oc, oc_all_mean*100, oc_all_sem*100,1,[ 0.8 .8 .8])
plot(group_oc, oc_all_mean*100,'LineWidth',2,'Color',[0 0 0]);

a3 = errorbar3(group_ad, ad_all_mean*100, ad_all_sem*100,1,[ 0.8 .8 .8])
plot(group_ad, ad_all_mean*100,'LineWidth', 2,'Color',[0 0 0]);

alpha(a1,.5)
alpha(a2,.5)
alpha(a3,.5)



hold off

% save figure
figurename = sprintf('Fig_4d_Classifier_Chars_selectivity_levels_lh');
print(fullfile(ResultsDir,figurename), '-dpng', '-r600')



