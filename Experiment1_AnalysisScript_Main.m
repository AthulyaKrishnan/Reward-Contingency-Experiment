clearvars
basic_path = pwd;
logfile_path = strcat(basic_path, '\logFiles');
cd(logfile_path);
allfiles = dir(logfile_path);
allfiles = {allfiles(:).name};
allfiles = allfiles(3:length(allfiles))';

% define tables for group average - each row participant

gp_avg_RTs = table();

% define tables for group acc - each row participant
gp_avg_Acc = table();

%  group reward points
gp_avg_Reward_points = table();

% EI
gp_EI_High_Contingency_RT = table();
gp_EI_High_Contingency_Acc = table();

% Ratio based EI
gp_Ratio_RT = table();
gp_Ratio_Acc = table();

% main loop

RT = [];
acc = [];
valence_order = [];
reward_order = [];
contigency_order = [];
gender_order = [];
identity_order = [];
target_order = [];
targetPos_order = [];
success=[];


%% main loop

    for part = 1:48
      if  part == 33 
            text='Skipping'; % Exclusion reason mentioned in manuscript
      else 
           
        gender_tab = readtable(fullfile(basic_path,'CRD4_Demographics.xlsx'));
        gender = gender_tab(part,3);

        curr_gender =  gender{1,1}; % its a cell array

        % if curr_gender == 2
          
        if part<10
            pid = num2str(part);
            pfiles = ~cellfun('isempty',strfind(allfiles, strcat('CRD40',pid)));
            all_pfiles = allfiles(pfiles);
            partID = strcat('CRD40',pid);
        else 
            pid = num2str(part);
            pfiles = ~cellfun('isempty',strfind(allfiles, strcat('CRD4',pid)));
            all_pfiles = allfiles(pfiles); 
            partID = strcat('CRD4',pid);
        end 

        %% Getting log files for every blockes defined above. 
        logfile1 = all_pfiles{3,:};
        file1 = load(logfile1,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile2 = all_pfiles{4,:};
        file2 = load(logfile2,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile3 = all_pfiles{5,:};
        file3 = load(logfile3,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile4 = all_pfiles{6,:};
        file4 = load(logfile4,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');
 
        logfile5 = all_pfiles{7,:};
        file5 = load(logfile5,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile6 = all_pfiles{8,:};
        file6 = load(logfile6,'accuracy','RT','EmoOrder','RewardOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        
    
        
        % concatenating all the files variables into one. This will be values
        % per block
        

        RT = cat(1, file1.RT(:),file2.RT(49:96)',file3.RT(97:144)',file4.RT(145:192)',file5.RT(193:240)',file6.RT(241:288)');
        acc = cat(1, file1.accuracy(:),file2.accuracy(49:96)',file3.accuracy(97:144)',file4.accuracy(145:192)',file5.accuracy(193:240)',file6.accuracy(241:288)');
        valence_order = cat(1, file1.EmoOrder(1:48,:),file2.EmoOrder(49:96,:),file3.EmoOrder(97:144,:),file4.EmoOrder(145:192,:),file5.EmoOrder(193:240,:),file6.EmoOrder(241:288,:));
        reward_order =  cat(1, file1.RewardOrder(1:48,:),file2.RewardOrder(49:96,:),file3.RewardOrder(97:144,:),file4.RewardOrder(145:192,:),file5.RewardOrder(193:240,:),file6.RewardOrder(241:288,:));
        contigency_order = cat(1, file1.ContingencyOrder(1:48,:),file2.ContingencyOrder(49:96,:),file3.ContingencyOrder(97:144,:),file4.ContingencyOrder(145:192,:),file5.ContingencyOrder(193:240,:),file6.ContingencyOrder(241:288,:));
        target_order =  cat(1, file1.TargetLetterOrder(1:48,:),file2.TargetLetterOrder(49:96,:),file3.TargetLetterOrder(97:144,:),file4.TargetLetterOrder(145:192,:),file5.TargetLetterOrder(193:240,:),file6.TargetLetterOrder(241:288,:));
        targetPos_order =  cat(1, file1.TargetPositionOrder(1:48,:),file2.TargetPositionOrder(49:96,:),file3.TargetPositionOrder(97:144,:),file4.TargetPositionOrder(145:192,:),file5.TargetPositionOrder(193:240,:),file6.TargetPositionOrder(241:288,:));
        identity_order = cat(1,file1.IdentityOrder(1:48,:),file2.IdentityOrder(49:96,:),file3.IdentityOrder(97:144,:),file4.IdentityOrder(145:192,:),file5.IdentityOrder(193:240,:),file6.IdentityOrder(241:288,:));
        success = cat(1,file1.success(:), file2.success(49:96)', file3.success(97:144)', file4.success(145:192)', file5.success(193:240)', file6.success(241:288)');
        criterion = file1.criterion;
        
   
        %% Reward Points 

        if part == 3 
    
        HR_HC_reward_rate = sum(file6.HR_HC_success)/60;
        HR_LC_reward_rate = sum(file6.HR_LC_success)/60;
        LR_HC_reward_rate = sum(file6.LR_HC_success)/60;
        LR_LC_reward_rate = sum(file6.LR_LC_success)/60;

        % Success Rate

        success_HR_HC_Pos_rate = sum(success(contigency_order==1 & valence_order==1 & reward_order==1))/20;
        success_HR_HC_Neu_rate = sum(success(contigency_order==1 & valence_order==2 & reward_order==1))/20;
        success_HR_HC_Neg_rate = sum(success(contigency_order==1 & valence_order==3 & reward_order==1))/20;


        success_LR_HC_Pos_rate = sum(success(contigency_order==1 & valence_order==1 & reward_order==2))/20;
        success_LR_HC_Neu_rate = sum(success(contigency_order==1 & valence_order==2 & reward_order==2))/20;
        success_LR_HC_Neg_rate = sum(success(contigency_order==1 & valence_order==3 & reward_order==2))/20;

        else 

        HR_HC_reward_rate = sum(file6.HR_HC_success)/72;
        HR_LC_reward_rate = sum(file6.HR_LC_success)/72;
        LR_HC_reward_rate = sum(file6.LR_HC_success)/72;
        LR_LC_reward_rate = sum(file6.LR_LC_success)/72;

        % Success Rate

        success_HR_HC_Pos_rate = sum(success(contigency_order==1 & valence_order==1 & reward_order==1))/24;
        success_HR_HC_Neu_rate = sum(success(contigency_order==1 & valence_order==2 & reward_order==1))/24;
        success_HR_HC_Neg_rate = sum(success(contigency_order==1 & valence_order==3 & reward_order==1))/24;


        success_LR_HC_Pos_rate = sum(success(contigency_order==1 & valence_order==1 & reward_order==2))/24;
        success_LR_HC_Neu_rate = sum(success(contigency_order==1 & valence_order==2 & reward_order==2))/24;
        success_LR_HC_Neg_rate = sum(success(contigency_order==1 & valence_order==3 & reward_order==2))/24;

        end 

        % Mean Reward points
        
        mean_success_HR_HC_Pos_rate = mean(success_HR_HC_Pos_rate);
        mean_success_HR_HC_Neu_rate = mean(success_HR_HC_Neu_rate);
        mean_success_HR_HC_Neg_rate = mean(success_HR_HC_Neg_rate);


        mean_success_LR_HC_Pos_rate = mean(success_LR_HC_Pos_rate);
        mean_success_LR_HC_Neu_rate = mean(success_LR_HC_Neu_rate);
        mean_success_LR_HC_Neg_rate = mean(success_LR_HC_Neg_rate);


        mean_HR_HC_reward_rate = mean(HR_HC_reward_rate);
        mean_HR_LC_reward_rate = mean(HR_LC_reward_rate);
        mean_LR_HC_reward_rate = mean(LR_HC_reward_rate);
        mean_LR_LC_reward_rate = mean(LR_LC_reward_rate);


         
        %% take average for each condition

        % RT
        avgRT = mean(RT);
      
        % Accuracy
        avgAcc = mean(acc);
       
        %% define conditionwise variables 

        %%%% RT %%%%

        % HR_HC
        pos_RT_HR_HC = RT(valence_order == 1 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neu_RT_HR_HC = RT(valence_order == 2 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neg_RT_HR_HC = RT(valence_order == 3 & reward_order == 1 & contigency_order == 1 & acc == 1);

        % HR_LC
        pos_RT_HR_LC = RT(valence_order == 1 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neu_RT_HR_LC = RT(valence_order == 2 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neg_RT_HR_LC = RT(valence_order == 3 & reward_order == 1 & contigency_order == 2 & acc == 1);

        % LR_HC
        pos_RT_LR_HC = RT(valence_order == 1 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neu_RT_LR_HC = RT(valence_order == 2 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neg_RT_LR_HC = RT(valence_order == 3 & reward_order == 2 & contigency_order == 1 & acc == 1);

        % LR_LC
        pos_RT_LR_LC = RT(valence_order == 1 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neu_RT_LR_LC = RT(valence_order == 2 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neg_RT_LR_LC = RT(valence_order == 3 & reward_order == 2 & contigency_order == 2 & acc == 1);


        %%%% Accuracy %%%%

        % HR_HC
        pos_Acc_HR_HC = acc(valence_order == 1 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neu_Acc_HR_HC = acc(valence_order == 2 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neg_Acc_HR_HC = acc(valence_order == 3 & reward_order == 1 & contigency_order == 1 & acc == 1);

        % HR_LC
        pos_Acc_HR_LC = acc(valence_order == 1 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neu_Acc_HR_LC = acc(valence_order == 2 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neg_Acc_HR_LC = acc(valence_order == 3 & reward_order == 1 & contigency_order == 2 & acc == 1);

        % LR_HC
        pos_Acc_LR_HC = acc(valence_order == 1 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neu_Acc_LR_HC = acc(valence_order == 2 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neg_Acc_LR_HC = acc(valence_order == 3 & reward_order == 2 & contigency_order == 1 & acc == 1);
        
        % LR_LC
        pos_Acc_LR_LC = acc(valence_order == 1 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neu_Acc_LR_LC = acc(valence_order == 2 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neg_Acc_LR_LC = acc(valence_order == 3 & reward_order == 2 & contigency_order == 2 & acc == 1);


        %% remove conditiowise outliers and take average again and plot

        % HR_HC
        posMax_HR_HC = mean(pos_RT_HR_HC)+3*std(pos_RT_HR_HC);
        posMin_HR_HC = mean(pos_RT_HR_HC)-3*std(pos_RT_HR_HC);
        neuMax_HR_HC = mean(neu_RT_HR_HC)+3*std(neu_RT_HR_HC);
        neuMin_HR_HC = mean(neu_RT_HR_HC)-3*std(neu_RT_HR_HC);
        negMax_HR_HC = mean(neg_RT_HR_HC)+3*std(neg_RT_HR_HC);
        negMin_HR_HC = mean(neg_RT_HR_HC)-3*std(neg_RT_HR_HC);
     
        % HR_LC
        posMax_HR_LC = mean(pos_RT_HR_LC)+3*std(pos_RT_HR_LC);
        posMin_HR_LC = mean(pos_RT_HR_LC)-3*std(pos_RT_HR_LC);
        neuMax_HR_LC = mean(neu_RT_HR_LC)+3*std(neu_RT_HR_LC);
        neuMin_HR_LC = mean(neu_RT_HR_LC)-3*std(neu_RT_HR_LC);
        negMax_HR_LC = mean(neg_RT_HR_LC)+3*std(neg_RT_HR_LC);
        negMin_HR_LC = mean(neg_RT_HR_LC)-3*std(neg_RT_HR_LC);

        % LR_HC
        posMax_LR_HC = mean(pos_RT_LR_HC)+3*std(pos_RT_LR_HC);
        posMin_LR_HC = mean(pos_RT_LR_HC)-3*std(pos_RT_LR_HC);
        neuMax_LR_HC = mean(neu_RT_LR_HC)+3*std(neu_RT_LR_HC);
        neuMin_LR_HC = mean(neu_RT_LR_HC)-3*std(neu_RT_LR_HC);
        negMax_LR_HC = mean(neg_RT_LR_HC)+3*std(neg_RT_LR_HC);
        negMin_LR_HC = mean(neg_RT_LR_HC)-3*std(neg_RT_LR_HC);

        % LR_LC
        posMax_LR_LC = mean(pos_RT_LR_LC)+3*std(pos_RT_LR_LC);
        posMin_LR_LC = mean(pos_RT_LR_LC)-3*std(pos_RT_LR_LC);
        neuMax_LR_LC = mean(neu_RT_LR_LC)+3*std(neu_RT_LR_LC);
        neuMin_LR_LC = mean(neu_RT_LR_LC)-3*std(neu_RT_LR_LC);
        negMax_LR_LC = mean(neg_RT_LR_LC)+3*std(neg_RT_LR_LC);
        negMin_LR_LC = mean(neg_RT_LR_LC)-3*std(neg_RT_LR_LC);

     
        % removal of outlier

        outlier = [];

         for z=1:288
               if ((valence_order(z) == 1) && (reward_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_HR_HC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_HR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (reward_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> neuMax_HR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_HR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (reward_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> negMax_HR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_HR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 1) && (reward_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> posMax_HR_LC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_HR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (reward_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> neuMax_HR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_HR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (reward_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> negMax_HR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_HR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 1) && (reward_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_LR_HC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_LR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (reward_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> neuMax_LR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_LR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (reward_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> negMax_LR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_LR_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

               elseif ((valence_order(z) == 1) && (reward_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_LR_LC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_LR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (reward_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> neuMax_LR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_LR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (reward_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> negMax_LR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_LR_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               else 
                   outlier(z)=0;
               end
         end

        % when no response is made, the accuracy is 0
        RT(acc==0 | (outlier)' ==1)=[]; % when incorrect response is made, the RT is taken as nil
        valence_order(acc==0 | outlier'==1)=[]; % info order taken as nil when incorrect responses are made
        reward_order(acc==0 | outlier'==1)=[];
        contigency_order(acc==0 | outlier'==1)=[];
        target_order(acc==0 | outlier'==1)=[];
        targetPos_order(acc==0 | outlier'==1)=[];
        identity_order(acc==0 | outlier'==1)=[]; % Accuracy is nil when incorrect responses are made
        acc(acc==0 | outlier'==1)=[];


        %% append conditionwise values to the group avg table  

        %%%% RT %%%%

        % HR_HC
        pos_RT_HR_HC = RT(valence_order == 1 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neu_RT_HR_HC = RT(valence_order == 2 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neg_RT_HR_HC = RT(valence_order == 3 & reward_order == 1 & contigency_order == 1 & acc == 1);

        % HR_LC
        pos_RT_HR_LC = RT(valence_order == 1 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neu_RT_HR_LC = RT(valence_order == 2 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neg_RT_HR_LC = RT(valence_order == 3 & reward_order == 1 & contigency_order == 2 & acc == 1);

        % LR_HC
        pos_RT_LR_HC = RT(valence_order == 1 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neu_RT_LR_HC = RT(valence_order == 2 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neg_RT_LR_HC = RT(valence_order == 3 & reward_order == 2 & contigency_order == 1 & acc == 1);

        % LR_LC
        pos_RT_LR_LC = RT(valence_order == 1 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neu_RT_LR_LC = RT(valence_order == 2 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neg_RT_LR_LC = RT(valence_order == 3 & reward_order == 2 & contigency_order == 2 & acc == 1);


        %%%% Accuracy %%%%

        % HR_HC
        pos_Acc_HR_HC = acc(valence_order == 1 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neu_Acc_HR_HC = acc(valence_order == 2 & reward_order == 1 & contigency_order == 1 & acc == 1);
        neg_Acc_HR_HC = acc(valence_order == 3 & reward_order == 1 & contigency_order == 1 & acc == 1);

        % HR_LC
        pos_Acc_HR_LC = acc(valence_order == 1 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neu_Acc_HR_LC = acc(valence_order == 2 & reward_order == 1 & contigency_order == 2 & acc == 1);
        neg_Acc_HR_LC = acc(valence_order == 3 & reward_order == 1 & contigency_order == 2 & acc == 1);

        % LR_HC
        pos_Acc_LR_HC = acc(valence_order == 1 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neu_Acc_LR_HC = acc(valence_order == 2 & reward_order == 2 & contigency_order == 1 & acc == 1);
        neg_Acc_LR_HC = acc(valence_order == 3 & reward_order == 2 & contigency_order == 1 & acc == 1);
        
        % LR_LC
        pos_Acc_LR_LC = acc(valence_order == 1 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neu_Acc_LR_LC = acc(valence_order == 2 & reward_order == 2 & contigency_order == 2 & acc == 1);
        neg_Acc_LR_LC = acc(valence_order == 3 & reward_order == 2 & contigency_order == 2 & acc == 1);


        %% conditionwise mean value

        %%%% RT %%%%

        % HR_HC
        pos_avgRT_HR_HC = mean(pos_RT_HR_HC);
        neu_avgRT_HR_HC = mean(neu_RT_HR_HC);
        neg_avgRT_HR_HC = mean(neg_RT_HR_HC);
       
        % HR_LC
        pos_avgRT_HR_LC = mean(pos_RT_HR_LC);
        neu_avgRT_HR_LC = mean(neu_RT_HR_LC);
        neg_avgRT_HR_LC = mean(neg_RT_HR_LC);

        % LR_HC
        pos_avgRT_LR_HC = mean(pos_RT_LR_HC);
        neu_avgRT_LR_HC = mean(neu_RT_LR_HC);
        neg_avgRT_LR_HC = mean(neg_RT_LR_HC);

        % LR_LC
        pos_avgRT_LR_LC = mean(pos_RT_LR_LC);
        neu_avgRT_LR_LC = mean(neu_RT_LR_LC);
        neg_avgRT_LR_LC = mean(neg_RT_LR_LC);
        
        % High Reward Emotional Index
        EI_pos_HR_RT = pos_avgRT_HR_HC - neu_avgRT_HR_HC;
        EI_neg_HR_RT = neg_avgRT_HR_HC - neu_avgRT_HR_HC;

        % Low Reward Emotional Index
        EI_pos_LR_RT = pos_avgRT_LR_HC - neu_avgRT_LR_HC;
        EI_neg_LR_RT = neg_avgRT_LR_HC - neu_avgRT_LR_HC;

        % Ratio based emotional distraction index

        % HR_HC
        EI_pos_ratioRT_HR_HC = pos_avgRT_HR_HC/neu_avgRT_HR_HC;
        EI_neg_ratioRT_HR_HC = neg_avgRT_HR_HC/neu_avgRT_HR_HC;

        % LR_HC
        EI_pos_ratioRT_LR_HC = pos_avgRT_LR_HC/neu_avgRT_LR_HC;
        EI_neg_ratioRT_LR_HC = neg_avgRT_LR_HC/neu_avgRT_LR_HC;

        % HR_LC
        EI_pos_ratioRT_HR_LC = pos_avgRT_HR_LC/neu_avgRT_HR_LC;
        EI_neg_ratioRT_HR_LC = neg_avgRT_HR_LC/neu_avgRT_HR_LC;

        % LR_LC
        EI_pos_ratioRT_LR_LC = pos_avgRT_LR_LC/neu_avgRT_LR_LC;
        EI_neg_ratioRT_LR_LC = neg_avgRT_LR_LC/neu_avgRT_LR_LC;

       
        %%%% Accuracy %%%%

        if part == 3 

        % HR_HC
        pos_avgAcc_HR_HC = sum(pos_Acc_HR_HC)/20;
        neu_avgAcc_HR_HC = sum(neu_Acc_HR_HC)/20;
        neg_avgAcc_HR_HC = sum(neg_Acc_HR_HC)/20;

        % HR_LC
        pos_avgAcc_HR_LC = sum(pos_Acc_HR_LC)/20;
        neu_avgAcc_HR_LC = sum(neu_Acc_HR_LC)/20;
        neg_avgAcc_HR_LC = sum(neg_Acc_HR_LC)/20;

        % LR_HC
        pos_avgAcc_LR_HC = sum(pos_Acc_LR_HC)/20;
        neu_avgAcc_LR_HC = sum(neu_Acc_LR_HC)/20;
        neg_avgAcc_LR_HC = sum(neg_Acc_LR_HC)/20;

        % LR_LC
        pos_avgAcc_LR_LC = sum(pos_Acc_LR_LC)/20;
        neu_avgAcc_LR_LC = sum(neu_Acc_LR_LC)/20;
        neg_avgAcc_LR_LC = sum(neg_Acc_LR_LC)/20;
        
        else 

        % HR_HC
        pos_avgAcc_HR_HC = sum(pos_Acc_HR_HC)/24;
        neu_avgAcc_HR_HC = sum(neu_Acc_HR_HC)/24;
        neg_avgAcc_HR_HC = sum(neg_Acc_HR_HC)/24;

        % HR_LC
        pos_avgAcc_HR_LC = sum(pos_Acc_HR_LC)/24;
        neu_avgAcc_HR_LC = sum(neu_Acc_HR_LC)/24;
        neg_avgAcc_HR_LC = sum(neg_Acc_HR_LC)/24;

        % LR_HC
        pos_avgAcc_LR_HC = sum(pos_Acc_LR_HC)/24;
        neu_avgAcc_LR_HC = sum(neu_Acc_LR_HC)/24;
        neg_avgAcc_LR_HC = sum(neg_Acc_LR_HC)/24;

        % LR_LC
        pos_avgAcc_LR_LC = sum(pos_Acc_LR_LC)/24;
        neu_avgAcc_LR_LC = sum(neu_Acc_LR_LC)/24;
        neg_avgAcc_LR_LC = sum(neg_Acc_LR_LC)/24;
        
        end 

        % High Reward Emotional Index
        EI_pos_HR_Acc = neu_avgAcc_HR_HC - pos_avgAcc_HR_HC;
        EI_neg_HR_Acc = neu_avgAcc_HR_HC - neg_avgAcc_HR_HC;

        % Low Reward Emotional Index
        EI_pos_LR_Acc = neu_avgAcc_LR_HC - pos_avgAcc_LR_HC ;
        EI_neg_LR_Acc = neu_avgAcc_LR_HC - neg_avgAcc_LR_HC ;

        % Ratio based emotional distraction index

        % HR_HC
        EI_pos_ratioAcc_HR_HC = pos_avgAcc_HR_HC/neu_avgAcc_HR_HC;
        EI_neg_ratioAcc_HR_HC = neg_avgAcc_HR_HC/neu_avgAcc_HR_HC;

        % LR_HC
        EI_pos_ratioAcc_LR_HC = pos_avgAcc_LR_HC/neu_avgAcc_LR_HC;
        EI_neg_ratioAcc_LR_HC = neg_avgAcc_LR_HC/neu_avgAcc_LR_HC;

        % HR_LC
        EI_pos_ratioAcc_HR_LC = pos_avgAcc_HR_LC/neu_avgAcc_HR_LC;
        EI_neg_ratioAcc_HR_LC = neg_avgAcc_HR_LC/neu_avgAcc_HR_LC;

        % LR_LC
        EI_pos_ratioAcc_LR_LC = pos_avgAcc_LR_LC/neu_avgAcc_LR_LC;
        EI_neg_ratioAcc_LR_LC = neg_avgAcc_LR_LC/neu_avgAcc_LR_LC;

           
        %% group average



        gp_avg_RTs = [gp_avg_RTs;table(pos_avgRT_HR_HC, neu_avgRT_HR_HC, neg_avgRT_HR_HC,...
                        pos_avgRT_LR_HC, neu_avgRT_LR_HC, neg_avgRT_LR_HC,...
                        pos_avgRT_HR_LC, neu_avgRT_HR_LC, neg_avgRT_HR_LC,...
                        pos_avgRT_LR_LC, neu_avgRT_LR_LC, neg_avgRT_LR_LC)];

                        
                                                        
        gp_avg_Acc = [gp_avg_Acc;table(pos_avgAcc_HR_HC, neu_avgAcc_HR_HC, neg_avgAcc_HR_HC,...
                        pos_avgAcc_LR_HC, neu_avgAcc_LR_HC, neg_avgAcc_LR_HC,...
                        pos_avgAcc_HR_LC, neu_avgAcc_HR_LC, neg_avgAcc_HR_LC,...
                        pos_avgAcc_LR_LC, neu_avgAcc_LR_LC, neg_avgAcc_LR_LC)];
                           
        
        gp_avg_Reward_points = [gp_avg_Reward_points; table(HR_HC_reward_rate,...
            LR_HC_reward_rate,HR_LC_reward_rate,LR_LC_reward_rate)];
        
       
        gp_EI_High_Contingency_RT = [gp_EI_High_Contingency_RT; table(EI_pos_HR_RT, EI_neg_HR_RT, EI_pos_LR_RT,...
            EI_neg_LR_RT)];

        gp_EI_High_Contingency_Acc = [gp_EI_High_Contingency_Acc; table(EI_pos_HR_Acc, EI_neg_HR_Acc, EI_pos_LR_Acc,...
            EI_neg_LR_Acc)];
      
        gp_Ratio_RT = [gp_Ratio_RT; table(EI_pos_ratioRT_HR_HC, EI_neg_ratioRT_HR_HC,...
            EI_pos_ratioRT_LR_HC, EI_neg_ratioRT_LR_HC,...
            EI_pos_ratioRT_HR_LC, EI_neg_ratioRT_HR_LC,...
            EI_pos_ratioRT_LR_LC, EI_neg_ratioRT_LR_LC)];

        gp_Ratio_Acc = [gp_Ratio_Acc; table(EI_pos_ratioAcc_HR_HC, EI_neg_ratioAcc_HR_HC,...
            EI_pos_ratioAcc_LR_HC, EI_neg_ratioAcc_LR_HC,...
            EI_pos_ratioAcc_HR_LC, EI_neg_ratioAcc_HR_LC,...
            EI_pos_ratioAcc_LR_LC, EI_neg_ratioAcc_LR_LC)];

   
        end

       %end
        

    end
    
    
    %% plotting
        
        % RT
        
        gp_pos_avgRT_HR_HC = mean(gp_avg_RTs.pos_avgRT_HR_HC);
        gp_neu_avgRT_HR_HC = mean(gp_avg_RTs.neu_avgRT_HR_HC);
        gp_neg_avgRT_HR_HC = mean(gp_avg_RTs.neg_avgRT_HR_HC);
        
        gp_pos_avgRT_HR_LC = mean(gp_avg_RTs.pos_avgRT_HR_LC);
        gp_neu_avgRT_HR_LC = mean(gp_avg_RTs.neu_avgRT_HR_LC);
        gp_neg_avgRT_HR_LC = mean(gp_avg_RTs.neg_avgRT_HR_LC);
        
        gp_pos_avgRT_LR_HC = mean(gp_avg_RTs.pos_avgRT_LR_HC);
        gp_neu_avgRT_LR_HC = mean(gp_avg_RTs.neu_avgRT_LR_HC);
        gp_neg_avgRT_LR_HC = mean(gp_avg_RTs.neg_avgRT_LR_HC);
        
        gp_pos_avgRT_LR_LC = mean(gp_avg_RTs.pos_avgRT_LR_LC);
        gp_neu_avgRT_LR_LC = mean(gp_avg_RTs.neu_avgRT_LR_LC);
        gp_neg_avgRT_LR_LC = mean(gp_avg_RTs.neg_avgRT_LR_LC);

        % plot1
        RT = [gp_pos_avgRT_HR_HC, gp_neu_avgRT_HR_HC, gp_neg_avgRT_HR_HC;...
                        gp_pos_avgRT_LR_HC, gp_neu_avgRT_LR_HC, gp_neg_avgRT_LR_HC;...
                        gp_pos_avgRT_HR_LC, gp_neu_avgRT_HR_LC, gp_neg_avgRT_HR_LC;...
                        gp_pos_avgRT_LR_LC, gp_neu_avgRT_LR_LC, gp_neg_avgRT_LR_LC];
        
       
        % Plotting the graphs

        figure;
        b=bar(RT*1000);

        hold on

        % Get handle to the bar plot
        h = gca; % Get current axes
        bars = h.Children; % Get children of axes (should be the bars)
        
        bdat =  bars.XData;
        boff = bars.XOffset;

        % Get center coordinates of bars
        x_centers = bdat + boff;
        % text(x_centers, ydt(k1,:), sprintfc('%.1f', ydt(k1,:)), 'HorizontalAlignment','center', 'VerticalAlignment','bottom', 'FontSize',8, 'Color','k')
        X = cat(2,gp_avg_RTs.pos_avgRT_HR_HC, gp_avg_RTs.neu_avgRT_HR_HC, gp_avg_RTs.neg_avgRT_HR_HC,...
                        gp_avg_RTs.pos_avgRT_LR_HC, gp_avg_RTs.neu_avgRT_LR_HC, gp_avg_RTs.neg_avgRT_LR_HC,...
                        gp_avg_RTs.pos_avgRT_HR_LC, gp_avg_RTs.neu_avgRT_HR_LC, gp_avg_RTs.neg_avgRT_HR_LC,...
                        gp_avg_RTs.pos_avgRT_LR_LC, gp_avg_RTs.neu_avgRT_LR_LC, gp_avg_RTs.neg_avgRT_LR_LC);
                        % cat(2 %% dimension)one or two dimension, we hav chosen 2 dimension
        [nSubj, nCond] = size(X); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
        corr_fac =sqrt((nCond)/(nCond-1));

        Y = X - repmat(mean(X,2,'omitnan'),1,size(X,2)) + repmat(mean(mean(X,'omitnan')), size(X,1),size(X,2)); %%??
        Z = corr_fac * ( Y - repmat(mean(Y,'omitnan'), size(Y,1), 1)) + repmat(mean(Y,'omitnan'), size(Y,1), 1);
        RT_avg_stderr = std(Z,'omitnan')/sqrt(nSubj);
        xBar1 = cell2mat(get(b,'XData'))' + [b.XOffset]; %??????
        stderr=cat(1,RT_avg_stderr(1:3)*1000*1.96,RT_avg_stderr(4:6)*1000*1.96,RT_avg_stderr(7:9)*1000*1.96,...
            RT_avg_stderr(10:12)*1000*1.96); %???????
        errorbar(xBar1,RT*1000, stderr, 'k', 'linestyle', 'none','lineWidth', 1);

        title('RT');
        xlabel('Conditions');
        ylabel('Reaction Time(ms)');

        ylim([500 800]);

        set(gca, 'XTick',1:4, 'XTickLabels',{'High Reward Contingent','Low Reward Contingent','High Reward Non-Contingent','Low Reward Non-Contingent'});
        legend('Positive','Neutral','Negative');
        
            
        %% Accuracy
        
        gp_pos_avgAcc_HR_HC = mean(gp_avg_Acc.pos_avgAcc_HR_HC);
        gp_neu_avgAcc_HR_HC = mean(gp_avg_Acc.neu_avgAcc_HR_HC);
        gp_neg_avgAcc_HR_HC = mean(gp_avg_Acc.neg_avgAcc_HR_HC);
        
        gp_pos_avgAcc_HR_LC = mean(gp_avg_Acc.pos_avgAcc_HR_LC);
        gp_neu_avgAcc_HR_LC = mean(gp_avg_Acc.neu_avgAcc_HR_LC);
        gp_neg_avgAcc_HR_LC = mean(gp_avg_Acc.neg_avgAcc_HR_LC);
        
        gp_pos_avgAcc_LR_HC = mean(gp_avg_Acc.pos_avgAcc_LR_HC);
        gp_neu_avgAcc_LR_HC = mean(gp_avg_Acc.neu_avgAcc_LR_HC);
        gp_neg_avgAcc_LR_HC = mean(gp_avg_Acc.neg_avgAcc_LR_HC);
        
        gp_pos_avgAcc_LR_LC = mean(gp_avg_Acc.pos_avgAcc_LR_LC);
        gp_neu_avgAcc_LR_LC = mean(gp_avg_Acc.neu_avgAcc_LR_LC);
        gp_neg_avgAcc_LR_LC = mean(gp_avg_Acc.neg_avgAcc_LR_LC);
        
        % plot 1
        Acc= [gp_pos_avgAcc_HR_HC,  gp_neu_avgAcc_HR_HC,  gp_neg_avgAcc_HR_HC;...
                gp_pos_avgAcc_LR_HC, gp_neu_avgAcc_LR_HC,  gp_neg_avgAcc_LR_HC;...
                gp_pos_avgAcc_HR_LC, gp_neu_avgAcc_HR_LC,  gp_neg_avgAcc_HR_LC;...
                gp_pos_avgAcc_LR_LC, gp_neu_avgAcc_LR_LC,  gp_neg_avgAcc_LR_LC];
                

        % Plotting the graphs

        figure;
        b_acc=bar(Acc*100);

        hold on

        X_Acc = cat(2,gp_avg_Acc.pos_avgAcc_HR_HC, gp_avg_Acc.neu_avgAcc_HR_HC, gp_avg_Acc.neg_avgAcc_HR_HC,...
                        gp_avg_Acc.pos_avgAcc_LR_HC, gp_avg_Acc.neu_avgAcc_LR_HC, gp_avg_Acc.neg_avgAcc_LR_HC,...
                        gp_avg_Acc.pos_avgAcc_HR_LC, gp_avg_Acc.neu_avgAcc_HR_LC, gp_avg_Acc.neg_avgAcc_HR_LC,...
                        gp_avg_Acc.pos_avgAcc_LR_LC, gp_avg_Acc.neu_avgAcc_LR_LC, gp_avg_Acc.neg_avgAcc_LR_LC);
                        % cat(2 %% dimension)one or two dimension, we hav chosen 2 dimension

        [nSubj, nCond] = size(X_Acc); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
        corr_fac =sqrt((nCond)/(nCond-1));
 
        Y_Acc = X_Acc - repmat(mean(X_Acc,2,'omitnan'),1,size(X_Acc,2)) + repmat(mean(mean(X_Acc,'omitnan')), size(X_Acc,1),size(X_Acc,2)); %%??
        Z_Acc = corr_fac * ( Y_Acc - repmat(mean(Y_Acc,'omitnan'), size(Y_Acc,1), 1)) + repmat(mean(Y_Acc,'omitnan'), size(Y_Acc,1), 1);
        RT_avg_stderrAcc = std(Z_Acc,'omitnan')/sqrt(nSubj);
        xBar2 = cell2mat(get(b_acc,'XData'))' + [b_acc.XOffset]; %??????
        stderr_Acc=cat(1,RT_avg_stderrAcc(1:3)*100*1.96,RT_avg_stderrAcc(4:6)*100*1.96,...
            RT_avg_stderrAcc(7:9)*100*1.96, RT_avg_stderrAcc(10:12)*100*1.96);%???????
        errorbar(xBar2, Acc*100, stderr_Acc, 'k', 'linestyle', 'none','lineWidth', 1);

        title('Accuracy');
        xlabel('Conditions');
        ylabel('Accuracy(%)');

        ylim([50 100]);

        set(gca, 'XTick',1:4, 'XTickLabels',{'High Reward Contingent','Low Reward Contingent','High Reward Non-Contingent','Low Reward Non-Contingent'});
        legend('Positive','Neutral','Negative');
        
    %% Reward Points

        gp_avg_HR_HC_reward_point = mean(gp_avg_Reward_points.HR_HC_reward_rate);
        gp_avg_LR_HC_reward_point = mean(gp_avg_Reward_points.LR_HC_reward_rate);
        gp_avg_HR_LC_reward_point = mean(gp_avg_Reward_points.HR_LC_reward_rate);
        gp_avg_LR_LC_reward_point = mean(gp_avg_Reward_points.LR_LC_reward_rate);
        
    
        Reward_Points = [gp_avg_HR_HC_reward_point, gp_avg_HR_LC_reward_point,...
            gp_avg_LR_HC_reward_point,gp_avg_LR_LC_reward_point];


    figure;
    b=bar(Reward_Points*100);

    hold on
    
    X = cat(2,gp_avg_Reward_points.HR_HC_reward_rate, gp_avg_Reward_points.HR_LC_reward_rate,...
                    gp_avg_Reward_points.LR_HC_reward_rate, gp_avg_Reward_points.LR_LC_reward_rate, gp_avg_RTs.neg_avgRT_LR_HC);
               
    [nSubj, nCond] = size(X); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
    corr_fac =sqrt((nCond)/(nCond-1));


    Y = X - repmat(mean(X,2,'omitnan'),1,size(X,2)) + repmat(mean(mean(X,'omitnan')), size(X,1),size(X,2)); %%??
    Z = corr_fac * ( Y - repmat(mean(Y,'omitnan'), size(Y,1), 1)) + repmat(mean(Y,'omitnan'), size(Y,1), 1);
    RP_avg_stderr = std(Z,'omitnan')/sqrt(nSubj);
    xBar1 = get(b,'XData')' + [b.XOffset]; %??????
    stderr=cat(1,RP_avg_stderr(1)*100*1.96,RP_avg_stderr(2)*100*1.96,RP_avg_stderr(3)*100*1.96, RP_avg_stderr(4)*100*1.96); %???????
    errorbar(xBar1,Reward_Points*100, stderr, 'k', 'linestyle', 'none','lineWidth', 1);


    title('Reward Points');
    xlabel('Conditions');
    ylabel('Reward Points(%)');

    ylim([50 100]);

    set(gca, 'XTick',1:4, 'XTickLabels',{'High Reward Contingent','High Reward Non-Contingent','Low Reward Contingent','Low Reward Non-Contingent'});
       
