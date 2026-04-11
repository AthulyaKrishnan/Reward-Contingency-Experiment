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

%  group loss avoided points
gp_avg_loss_points = table();

% EI
gp_EI_High_Contingency = table();

gp_Contingency_acc = table();

% Ratio based EI
gp_Ratio_RT = table();
gp_Ratio_Acc = table();

% main loop

RT = [];
acc = [];
valence_order = [];
loss_order = [];
contigency_order = [];
identity_order = [];
target_order = [];
targetPos_order = [];
success=[];


%% main loop

    for part = 1:48

        gender_path = basic_path;
        gender_tab = readtable(fullfile(gender_path,'CRD7_Demographics.xlsx'));
        gender = gender_tab(part,3);
        curr_gender =  gender{1,1}; % its a cell array

       %if curr_gender == 2
          
        if part<10
            pid = num2str(part);
            pfiles = ~cellfun('isempty',strfind(allfiles, strcat('CRD70',pid)));
            all_pfiles = allfiles(pfiles);
            partID = strcat('CRD70',pid);
        else 
            pid = num2str(part);
            pfiles = ~cellfun('isempty',strfind(allfiles, strcat('CRD7',pid)));
            all_pfiles = allfiles(pfiles); 
            partID = strcat('CRD7',pid);
        end 

        %% Getting log files for every blockes defined above. 
        logfile1 = all_pfiles{3,:};
        file1 = load(logfile1,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile2 = all_pfiles{4,:};
        file2 = load(logfile2,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile3 = all_pfiles{5,:};
        file3 = load(logfile3,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile4 = all_pfiles{6,:};
        file4 = load(logfile4,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');
 
        logfile5 = all_pfiles{7,:};
        file5 = load(logfile5,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        logfile6 = all_pfiles{8,:};
        file6 = load(logfile6,'accuracy','RT','EmoOrder','LossOrder','ContingencyOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder','HR_HC_success', 'HR_LC_success', 'LR_HC_success', 'LR_LC_success', 'success', 'criterion');

        
    
        
        % concatenating all the files variables into one. This will be values
        % per block
        

        RT = cat(1, file1.RT(:),file2.RT(49:96)',file3.RT(97:144)',file4.RT(145:192)',file5.RT(193:240)',file6.RT(241:288)');
        acc = cat(1, file1.accuracy(:),file2.accuracy(49:96)',file3.accuracy(97:144)',file4.accuracy(145:192)',file5.accuracy(193:240)',file6.accuracy(241:288)');
        valence_order = cat(1, file1.EmoOrder(1:48,:),file2.EmoOrder(49:96,:),file3.EmoOrder(97:144,:),file4.EmoOrder(145:192,:),file5.EmoOrder(193:240,:),file6.EmoOrder(241:288,:));
        loss_order =  cat(1, file1.LossOrder(1:48,:),file2.LossOrder(49:96,:),file3.LossOrder(97:144,:),file4.LossOrder(145:192,:),file5.LossOrder(193:240,:),file6.LossOrder(241:288,:));
        contigency_order = cat(1, file1.ContingencyOrder(1:48,:),file2.ContingencyOrder(49:96,:),file3.ContingencyOrder(97:144,:),file4.ContingencyOrder(145:192,:),file5.ContingencyOrder(193:240,:),file6.ContingencyOrder(241:288,:));
        target_order =  cat(1, file1.TargetLetterOrder(1:48,:),file2.TargetLetterOrder(49:96,:),file3.TargetLetterOrder(97:144,:),file4.TargetLetterOrder(145:192,:),file5.TargetLetterOrder(193:240,:),file6.TargetLetterOrder(241:288,:));
        targetPos_order =  cat(1, file1.TargetPositionOrder(1:48,:),file2.TargetPositionOrder(49:96,:),file3.TargetPositionOrder(97:144,:),file4.TargetPositionOrder(145:192,:),file5.TargetPositionOrder(193:240,:),file6.TargetPositionOrder(241:288,:));
        identity_order = cat(1,file1.IdentityOrder(1:48,:),file2.IdentityOrder(49:96,:),file3.IdentityOrder(97:144,:),file4.IdentityOrder(145:192,:),file5.IdentityOrder(193:240,:),file6.IdentityOrder(241:288,:));
        success = cat(1,file1.success(:), file2.success(49:96)', file3.success(97:144)', file4.success(145:192)', file5.success(193:240)', file6.success(241:288)');
        criterion = file1.criterion;    

        %% Reward Points

        HL_HC_loss_points = sum(file6.HR_HC_success)/72;
        HL_LC_loss_points = sum(file6.HR_LC_success)/72;
        LL_HC_loss_points = sum(file6.LR_HC_success)/72;
        LL_LC_loss_points = sum(file6.LR_LC_success)/72;

        
        % Success Rate

        success_HL_HC_Pos_points = sum(success(contigency_order==1 & valence_order==1 & loss_order==1))/24;
        success_HL_HC_Neu_points = sum(success(contigency_order==1 & valence_order==2 & loss_order==1))/24;
        success_HL_HC_Neg_points = sum(success(contigency_order==1 & valence_order==3 & loss_order==1))/24;


        success_LL_HC_Pos_points = sum(success(contigency_order==1 & valence_order==1 & loss_order==2))/24;
        success_LL_HC_Neu_points = sum(success(contigency_order==1 & valence_order==2 & loss_order==2))/24;
        success_LL_HC_Neg_points = sum(success(contigency_order==1 & valence_order==3 & loss_order==2))/24;

         

        % Mean Reward points
        
        mean_success_HL_HC_Pos_points = mean(success_HL_HC_Pos_points);
        mean_success_HL_HC_Neu_points = mean(success_HL_HC_Neu_points);
        mean_success_HL_HC_Neg_points = mean(success_HL_HC_Neg_points);


        mean_success_LL_HC_Pos_points = mean(success_LL_HC_Pos_points);
        mean_success_LL_HC_Neu_points = mean(success_LL_HC_Neu_points);
        mean_success_LL_HC_Neg_points = mean(success_LL_HC_Neg_points);


        mean_HL_HC_reward_points = mean(HL_HC_loss_points);
        mean_HL_LC_reward_points = mean(HL_LC_loss_points);
        mean_LL_HC_reward_points = mean(LL_HC_loss_points);
        mean_LL_LC_reward_points = mean(LL_LC_loss_points);


         
        %% take average for each condition

        % RT
        avgRT = mean(RT);
      
        % Accuracy
        avgAcc = mean(acc);
       
        %% define conditionwise variables 

        %%%% RT %%%%

        % HL_HC
        pos_RT_HL_HC = RT(valence_order == 1 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neu_RT_HL_HC = RT(valence_order == 2 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neg_RT_HL_HC = RT(valence_order == 3 & loss_order == 1 & contigency_order == 1 & acc == 1);

        % HL_LC
        pos_RT_HL_LC = RT(valence_order == 1 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neu_RT_HL_LC = RT(valence_order == 2 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neg_RT_HL_LC = RT(valence_order == 3 & loss_order == 1 & contigency_order == 2 & acc == 1);

        % LL_HC
        pos_RT_LL_HC = RT(valence_order == 1 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neu_RT_LL_HC = RT(valence_order == 2 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neg_RT_LL_HC = RT(valence_order == 3 & loss_order == 2 & contigency_order == 1 & acc == 1);

        % LL_LC
        pos_RT_LL_LC = RT(valence_order == 1 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neu_RT_LL_LC = RT(valence_order == 2 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neg_RT_LL_LC = RT(valence_order == 3 & loss_order == 2 & contigency_order == 2 & acc == 1);


        %%%% Accuracy %%%%

        % HL_HC
        pos_Acc_HL_HC = acc(valence_order == 1 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neu_Acc_HL_HC = acc(valence_order == 2 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neg_Acc_HL_HC = acc(valence_order == 3 & loss_order == 1 & contigency_order == 1 & acc == 1);

        % HL_LC
        pos_Acc_HL_LC = acc(valence_order == 1 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neu_Acc_HL_LC = acc(valence_order == 2 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neg_Acc_HL_LC = acc(valence_order == 3 & loss_order == 1 & contigency_order == 2 & acc == 1);

        % LL_HC
        pos_Acc_LL_HC = acc(valence_order == 1 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neu_Acc_LL_HC = acc(valence_order == 2 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neg_Acc_LL_HC = acc(valence_order == 3 & loss_order == 2 & contigency_order == 1 & acc == 1);
        
        % LL_LC
        pos_Acc_LL_LC = acc(valence_order == 1 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neu_Acc_LL_LC = acc(valence_order == 2 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neg_Acc_LL_LC = acc(valence_order == 3 & loss_order == 2 & contigency_order == 2 & acc == 1);


        %% remove conditiowise outliers and take average again and plot

        % HL_HC
        posMax_HL_HC = mean(pos_RT_HL_HC)+3*std(pos_RT_HL_HC);
        posMin_HL_HC = mean(pos_RT_HL_HC)-3*std(pos_RT_HL_HC);
        neuMax_HL_HC = mean(neu_RT_HL_HC)+3*std(neu_RT_HL_HC);
        neuMin_HL_HC = mean(neu_RT_HL_HC)-3*std(neu_RT_HL_HC);
        negMax_HL_HC = mean(neg_RT_HL_HC)+3*std(neg_RT_HL_HC);
        negMin_HL_HC = mean(neg_RT_HL_HC)-3*std(neg_RT_HL_HC);
     
        % HL_LC
        posMax_HL_LC = mean(pos_RT_HL_LC)+3*std(pos_RT_HL_LC);
        posMin_HL_LC = mean(pos_RT_HL_LC)-3*std(pos_RT_HL_LC);
        neuMax_HL_LC = mean(neu_RT_HL_LC)+3*std(neu_RT_HL_LC);
        neuMin_HL_LC = mean(neu_RT_HL_LC)-3*std(neu_RT_HL_LC);
        negMax_HL_LC = mean(neg_RT_HL_LC)+3*std(neg_RT_HL_LC);
        negMin_HL_LC = mean(neg_RT_HL_LC)-3*std(neg_RT_HL_LC);

        % LL_HC
        posMax_LL_HC = mean(pos_RT_LL_HC)+3*std(pos_RT_LL_HC);
        posMin_LL_HC = mean(pos_RT_LL_HC)-3*std(pos_RT_LL_HC);
        neuMax_LL_HC = mean(neu_RT_LL_HC)+3*std(neu_RT_LL_HC);
        neuMin_LL_HC = mean(neu_RT_LL_HC)-3*std(neu_RT_LL_HC);
        negMax_LL_HC = mean(neg_RT_LL_HC)+3*std(neg_RT_LL_HC);
        negMin_LL_HC = mean(neg_RT_LL_HC)-3*std(neg_RT_LL_HC);

        % LL_LC
        posMax_LL_LC = mean(pos_RT_LL_LC)+3*std(pos_RT_LL_LC);
        posMin_LL_LC = mean(pos_RT_LL_LC)-3*std(pos_RT_LL_LC);
        neuMax_LL_LC = mean(neu_RT_LL_LC)+3*std(neu_RT_LL_LC);
        neuMin_LL_LC = mean(neu_RT_LL_LC)-3*std(neu_RT_LL_LC);
        negMax_LL_LC = mean(neg_RT_LL_LC)+3*std(neg_RT_LL_LC);
        negMin_LL_LC = mean(neg_RT_LL_LC)-3*std(neg_RT_LL_LC);

     
        % removal of outlier

        outlier = [];

         for z=1:288
               if ((valence_order(z) == 1) && (loss_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_HL_HC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_HL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (loss_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> neuMax_HL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_HL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (loss_order(z) == 1) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> negMax_HL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_HL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 1) && (loss_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> posMax_HL_LC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_HL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (loss_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> neuMax_HL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_HL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (loss_order(z) == 1) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> negMax_HL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_HL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 1) && (loss_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_LL_HC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_LL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (loss_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> neuMax_LL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_LL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (loss_order(z) == 2) && (contigency_order(z) == 1) && (acc(z) == 1))
                  if RT(z)> negMax_LL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_LL_HC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

               elseif ((valence_order(z) == 1) && (loss_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax_LL_LC % response time is greater than congmax
                      outlier(z)=1; % it is an outlier
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< posMin_LL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (loss_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> neuMax_LL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< neuMin_LL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (loss_order(z) == 2) && (contigency_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> negMax_LL_LC
                      outlier(z)=1;
                  else
                      outlier(z)=0;
                  end

                  if RT(z)< negMin_LL_LC
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
        loss_order(acc==0 | outlier'==1)=[];
        contigency_order(acc==0 | outlier'==1)=[];
        target_order(acc==0 | outlier'==1)=[];
        targetPos_order(acc==0 | outlier'==1)=[];
        identity_order(acc==0 | outlier'==1)=[]; % Accuracy is nil when incorrect responses are made
        acc(acc==0 | outlier'==1)=[];


        %% append conditionwise values to the group avg table  

        %%%% RT %%%%

        % HL_HC
        pos_RT_HL_HC = RT(valence_order == 1 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neu_RT_HL_HC = RT(valence_order == 2 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neg_RT_HL_HC = RT(valence_order == 3 & loss_order == 1 & contigency_order == 1 & acc == 1);

        % HL_LC
        pos_RT_HL_LC = RT(valence_order == 1 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neu_RT_HL_LC = RT(valence_order == 2 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neg_RT_HL_LC = RT(valence_order == 3 & loss_order == 1 & contigency_order == 2 & acc == 1);

        % LL_HC
        pos_RT_LL_HC = RT(valence_order == 1 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neu_RT_LL_HC = RT(valence_order == 2 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neg_RT_LL_HC = RT(valence_order == 3 & loss_order == 2 & contigency_order == 1 & acc == 1);

        % LL_LC
        pos_RT_LL_LC = RT(valence_order == 1 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neu_RT_LL_LC = RT(valence_order == 2 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neg_RT_LL_LC = RT(valence_order == 3 & loss_order == 2 & contigency_order == 2 & acc == 1);


        %%%% Accuracy %%%%

        % HL_HC
        pos_Acc_HL_HC = acc(valence_order == 1 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neu_Acc_HL_HC = acc(valence_order == 2 & loss_order == 1 & contigency_order == 1 & acc == 1);
        neg_Acc_HL_HC = acc(valence_order == 3 & loss_order == 1 & contigency_order == 1 & acc == 1);

        % HL_LC
        pos_Acc_HL_LC = acc(valence_order == 1 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neu_Acc_HL_LC = acc(valence_order == 2 & loss_order == 1 & contigency_order == 2 & acc == 1);
        neg_Acc_HL_LC = acc(valence_order == 3 & loss_order == 1 & contigency_order == 2 & acc == 1);

        % LL_HC
        pos_Acc_LL_HC = acc(valence_order == 1 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neu_Acc_LL_HC = acc(valence_order == 2 & loss_order == 2 & contigency_order == 1 & acc == 1);
        neg_Acc_LL_HC = acc(valence_order == 3 & loss_order == 2 & contigency_order == 1 & acc == 1);
        
        % LL_LC
        pos_Acc_LL_LC = acc(valence_order == 1 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neu_Acc_LL_LC = acc(valence_order == 2 & loss_order == 2 & contigency_order == 2 & acc == 1);
        neg_Acc_LL_LC = acc(valence_order == 3 & loss_order == 2 & contigency_order == 2 & acc == 1);


        %% conditionwise mean value

        %%%% RT %%%%

        % HR_HC
        pos_avgRT_HL_HC = mean(pos_RT_HL_HC);
        neu_avgRT_HL_HC = mean(neu_RT_HL_HC);
        neg_avgRT_HL_HC = mean(neg_RT_HL_HC);
       

        % RL
        pos_avgRT_HL_LC = mean(pos_RT_HL_LC);
        neu_avgRT_HL_LC = mean(neu_RT_HL_LC);
        neg_avgRT_HL_LC = mean(neg_RT_HL_LC);

        % PH
        pos_avgRT_LL_HC = mean(pos_RT_LL_HC);
        neu_avgRT_LL_HC = mean(neu_RT_LL_HC);
        neg_avgRT_LL_HC = mean(neg_RT_LL_HC);

        % PL
        pos_avgRT_LL_LC = mean(pos_RT_LL_LC);
        neu_avgRT_LL_LC = mean(neu_RT_LL_LC);
        neg_avgRT_LL_LC = mean(neg_RT_LL_LC);
        
        % High Reward Emotional Index
        EI_pos_HL = pos_avgRT_HL_HC - neu_avgRT_HL_HC;
        EI_neg_HL = neg_avgRT_HL_HC - neu_avgRT_HL_HC;

        % Low Reward Emotional Index
        EI_pos_LL = pos_avgRT_LL_HC - neu_avgRT_LL_HC;
        EI_neg_LL = neg_avgRT_LL_HC - neu_avgRT_LL_HC;

        % Ratio based emotional distraction index

        % HR_HC
        EI_pos_ratioRT_HL_HC = pos_avgRT_HL_HC/neu_avgRT_HL_HC;
        EI_neg_ratioRT_HL_HC = neg_avgRT_HL_HC/neu_avgRT_HL_HC;

        % LR_HC
        EI_pos_ratioRT_LL_HC = pos_avgRT_LL_HC/neu_avgRT_LL_HC;
        EI_neg_ratioRT_LL_HC = neg_avgRT_LL_HC/neu_avgRT_LL_HC;

        % HR_LC
        EI_pos_ratioRT_HL_LC = pos_avgRT_HL_LC/neu_avgRT_HL_LC;
        EI_neg_ratioRT_HL_LC = neg_avgRT_HL_LC/neu_avgRT_HL_LC;

        % LR_LC
        EI_pos_ratioRT_LL_LC = pos_avgRT_LL_LC/neu_avgRT_LL_LC;
        EI_neg_ratioRT_LL_LC = neg_avgRT_LL_LC/neu_avgRT_LL_LC;

        
        %%%% Accuracy %%%%


        % HR_HC
        pos_avgAcc_HL_HC = sum(pos_Acc_HL_HC)/24;
        neu_avgAcc_HL_HC = sum(neu_Acc_HL_HC)/24;
        neg_avgAcc_HL_HC = sum(neg_Acc_HL_HC)/24;

        % HR_LC
        pos_avgAcc_HL_LC = sum(pos_Acc_HL_LC)/24;
        neu_avgAcc_HL_LC = sum(neu_Acc_HL_LC)/24;
        neg_avgAcc_HL_LC = sum(neg_Acc_HL_LC)/24;

        % LR_HC
        pos_avgAcc_LL_HC = sum(pos_Acc_LL_HC)/24;
        neu_avgAcc_LL_HC = sum(neu_Acc_LL_HC)/24;
        neg_avgAcc_LL_HC = sum(neg_Acc_LL_HC)/24;

        % LR_LC
        pos_avgAcc_LL_LC = sum(pos_Acc_LL_LC)/24;
        neu_avgAcc_LL_LC = sum(neu_Acc_LL_LC)/24;
        neg_avgAcc_LL_LC = sum(neg_Acc_LL_LC)/24;
        
        % Ratio based emotional distraction index

        % HR_HC
        EI_pos_ratioAcc_HL_HC = pos_avgAcc_HL_HC/neu_avgAcc_HL_HC;
        EI_neg_ratioAcc_HL_HC = neg_avgAcc_HL_HC/neu_avgAcc_HL_HC;

        % LR_HC
        EI_pos_ratioAcc_LL_HC = pos_avgAcc_LL_HC/neu_avgAcc_LL_HC;
        EI_neg_ratioAcc_LL_HC = neg_avgAcc_LL_HC/neu_avgAcc_LL_HC;

        % HR_LC
        EI_pos_ratioAcc_HL_LC = pos_avgAcc_HL_LC/neu_avgAcc_HL_LC;
        EI_neg_ratioAcc_HL_LC = neg_avgAcc_HL_LC/neu_avgAcc_HL_LC;

        % LR_LC
        EI_pos_ratioAcc_LL_LC = pos_avgAcc_LL_LC/neu_avgAcc_LL_LC;
        EI_neg_ratioAcc_LL_LC = neg_avgAcc_LL_LC/neu_avgAcc_LL_LC;

       
        %% group average


        gp_avg_RTs = [gp_avg_RTs;table(pos_avgRT_HL_HC, neu_avgRT_HL_HC, neg_avgRT_HL_HC,...
                        pos_avgRT_LL_HC, neu_avgRT_LL_HC, neg_avgRT_LL_HC,...
                        pos_avgRT_HL_LC, neu_avgRT_HL_LC, neg_avgRT_HL_LC,...
                        pos_avgRT_LL_LC, neu_avgRT_LL_LC, neg_avgRT_LL_LC)];

                        
                                                        
        gp_avg_Acc = [gp_avg_Acc;table(pos_avgAcc_HL_HC, neu_avgAcc_HL_HC, neg_avgAcc_HL_HC,...
                        pos_avgAcc_LL_HC, neu_avgAcc_LL_HC, neg_avgAcc_LL_HC,...
                        pos_avgAcc_HL_LC, neu_avgAcc_HL_LC, neg_avgAcc_HL_LC,...
                        pos_avgAcc_LL_LC, neu_avgAcc_LL_LC, neg_avgAcc_LL_LC)];
                           
        
        gp_avg_loss_points = [gp_avg_loss_points; table(HL_HC_loss_points,...
            LL_HC_loss_points,HL_LC_loss_points,LL_LC_loss_points)];

        gp_EI_High_Contingency = [gp_EI_High_Contingency; table(EI_pos_HL, EI_neg_HL, EI_pos_LL,...
            EI_neg_LL)];
      
        gp_Ratio_RT = [gp_Ratio_RT; table(EI_pos_ratioRT_HL_HC, EI_neg_ratioRT_HL_HC,...
            EI_pos_ratioRT_LL_HC, EI_neg_ratioRT_LL_HC,...
            EI_pos_ratioRT_HL_LC, EI_neg_ratioRT_HL_LC,...
            EI_pos_ratioRT_LL_LC, EI_neg_ratioRT_LL_LC)];

        gp_Ratio_Acc = [gp_Ratio_Acc; table(EI_pos_ratioAcc_HL_HC, EI_neg_ratioAcc_HL_HC,...
            EI_pos_ratioAcc_LL_HC, EI_neg_ratioAcc_LL_HC,...
            EI_pos_ratioAcc_HL_LC, EI_neg_ratioAcc_HL_LC,...
            EI_pos_ratioAcc_LL_LC, EI_neg_ratioAcc_LL_LC)];
        
       %end
        
    end
     
    %% plotting
            
        % RT
        
        gp_pos_avgRT_HL_HC = mean(gp_avg_RTs.pos_avgRT_HL_HC);
        gp_neu_avgRT_HL_HC = mean(gp_avg_RTs.neu_avgRT_HL_HC);
        gp_neg_avgRT_HL_HC = mean(gp_avg_RTs.neg_avgRT_HL_HC);
      
        gp_pos_avgRT_HL_LC = mean(gp_avg_RTs.pos_avgRT_HL_LC);
        gp_neu_avgRT_HL_LC = mean(gp_avg_RTs.neu_avgRT_HL_LC);
        gp_neg_avgRT_HL_LC = mean(gp_avg_RTs.neg_avgRT_HL_LC);
        
        gp_pos_avgRT_LL_HC = mean(gp_avg_RTs.pos_avgRT_LL_HC);
        gp_neu_avgRT_LL_HC = mean(gp_avg_RTs.neu_avgRT_LL_HC);
        gp_neg_avgRT_LL_HC = mean(gp_avg_RTs.neg_avgRT_LL_HC);
        
        gp_pos_avgRT_LL_LC = mean(gp_avg_RTs.pos_avgRT_LL_LC);
        gp_neu_avgRT_LL_LC = mean(gp_avg_RTs.neu_avgRT_LL_LC);
        gp_neg_avgRT_LL_LC = mean(gp_avg_RTs.neg_avgRT_LL_LC);

        % plot1
        RT = [gp_pos_avgRT_HL_HC, gp_neu_avgRT_HL_HC, gp_neg_avgRT_HL_HC;...
                        gp_pos_avgRT_LL_HC, gp_neu_avgRT_LL_HC, gp_neg_avgRT_LL_HC;...
                        gp_pos_avgRT_HL_LC, gp_neu_avgRT_HL_LC, gp_neg_avgRT_HL_LC;...
                        gp_pos_avgRT_LL_LC, gp_neu_avgRT_LL_LC, gp_neg_avgRT_LL_LC];
        
       
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
        X = cat(2,gp_avg_RTs.pos_avgRT_HL_HC, gp_avg_RTs.neu_avgRT_HL_HC, gp_avg_RTs.neg_avgRT_HL_HC,...
                        gp_avg_RTs.pos_avgRT_LL_HC, gp_avg_RTs.neu_avgRT_LL_HC, gp_avg_RTs.neg_avgRT_LL_HC,...
                        gp_avg_RTs.pos_avgRT_HL_LC, gp_avg_RTs.neu_avgRT_HL_LC, gp_avg_RTs.neg_avgRT_HL_LC,...
                        gp_avg_RTs.pos_avgRT_LL_LC, gp_avg_RTs.neu_avgRT_LL_LC, gp_avg_RTs.neg_avgRT_LL_LC);
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

        ylim([400 900]);

        set(gca, 'XTick',1:4, 'XTickLabels',{'High Loss Contingent','Low Loss Contingent','High Loss Non-Contingent','Low Loss Non-Contingent'});
        legend('Positive','Neutral','Negative');
        
        
        %% Accuracy
        
        gp_pos_avgAcc_HL_HC = mean(gp_avg_Acc.pos_avgAcc_HL_HC);
        gp_neu_avgAcc_HL_HC = mean(gp_avg_Acc.neu_avgAcc_HL_HC);
        gp_neg_avgAcc_HL_HC = mean(gp_avg_Acc.neg_avgAcc_HL_HC);
        
        gp_pos_avgAcc_HL_LC = mean(gp_avg_Acc.pos_avgAcc_HL_LC);
        gp_neu_avgAcc_HL_LC = mean(gp_avg_Acc.neu_avgAcc_HL_LC);
        gp_neg_avgAcc_HL_LC = mean(gp_avg_Acc.neg_avgAcc_HL_LC);
        
        gp_pos_avgAcc_LL_HC = mean(gp_avg_Acc.pos_avgAcc_LL_HC);
        gp_neu_avgAcc_LL_HC = mean(gp_avg_Acc.neu_avgAcc_LL_HC);
        gp_neg_avgAcc_LL_HC = mean(gp_avg_Acc.neg_avgAcc_LL_HC);
        
        gp_pos_avgAcc_LL_LC = mean(gp_avg_Acc.pos_avgAcc_LL_LC);
        gp_neu_avgAcc_LL_LC = mean(gp_avg_Acc.neu_avgAcc_LL_LC);
        gp_neg_avgAcc_LL_LC = mean(gp_avg_Acc.neg_avgAcc_LL_LC);
        
        % plot 1
        Acc= [gp_pos_avgAcc_HL_HC,  gp_neu_avgAcc_HL_HC,  gp_neg_avgAcc_HL_HC;...
                gp_pos_avgAcc_LL_HC, gp_neu_avgAcc_LL_HC,  gp_neg_avgAcc_LL_HC;...
                gp_pos_avgAcc_HL_LC, gp_neu_avgAcc_HL_LC,  gp_neg_avgAcc_HL_LC;...
                gp_pos_avgAcc_LL_LC, gp_neu_avgAcc_LL_LC,  gp_neg_avgAcc_LL_LC];
                

        % Plotting the graphs

        figure;
        b_acc=bar(Acc*100);

        hold on

        X_Acc = cat(2,gp_avg_Acc.pos_avgAcc_HL_HC, gp_avg_Acc.neu_avgAcc_HL_HC, gp_avg_Acc.neg_avgAcc_HL_HC,...
                        gp_avg_Acc.pos_avgAcc_LL_HC, gp_avg_Acc.neu_avgAcc_LL_HC, gp_avg_Acc.neg_avgAcc_LL_HC,...
                        gp_avg_Acc.pos_avgAcc_HL_LC, gp_avg_Acc.neu_avgAcc_HL_LC, gp_avg_Acc.neg_avgAcc_HL_LC,...
                        gp_avg_Acc.pos_avgAcc_LL_LC, gp_avg_Acc.neu_avgAcc_LL_LC, gp_avg_Acc.neg_avgAcc_LL_LC);
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

        set(gca, 'XTick',1:4, 'XTickLabels',{'High Loss Contingent','Low Loss Contingent','High Loss Non-Contingent','Low Loss Non-Contingent'});
        legend('Positive','Neutral','Negative');
       
       
    %%  Points Avoided Losing

        gp_avg_HL_HC_lost_point = mean(gp_avg_loss_points.HL_HC_loss_points);
        gp_avg_LL_HC_lost_point = mean(gp_avg_loss_points.LL_HC_loss_points);
        gp_avg_HL_LC_lost_point = mean(gp_avg_loss_points.HL_LC_loss_points);
        gp_avg_LL_LC_lost_point = mean(gp_avg_loss_points.LL_LC_loss_points);
        
    
        Reward_Points = [gp_avg_HL_HC_lost_point, gp_avg_HL_LC_lost_point,...
            gp_avg_LL_HC_lost_point,gp_avg_LL_LC_lost_point];


    figure;
    b=bar(Reward_Points*100);

    hold on
    
    X = cat(2,gp_avg_loss_points.HL_HC_loss_points, gp_avg_loss_points.HL_LC_loss_points,...
                    gp_avg_loss_points.LL_HC_loss_points, gp_avg_loss_points.LL_LC_loss_points);
               
    [nSubj, nCond] = size(X); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
    corr_fac =sqrt((nCond)/(nCond-1));


    Y = X - repmat(mean(X,2,'omitnan'),1,size(X,2)) + repmat(mean(mean(X,'omitnan')), size(X,1),size(X,2)); %%??
    Z = corr_fac * ( Y - repmat(mean(Y,'omitnan'), size(Y,1), 1)) + repmat(mean(Y,'omitnan'), size(Y,1), 1);
    RP_avg_stderr = std(Z,'omitnan')/sqrt(nSubj);
    xBar1 = get(b,'XData')' + [b.XOffset]; %??????
    stderr=cat(1,RP_avg_stderr(1)*100*1.96,RP_avg_stderr(2)*100*1.96,RP_avg_stderr(3)*100*1.96, RP_avg_stderr(4)*100*1.96); %???????
    errorbar(xBar1,Reward_Points*100, stderr, 'k', 'linestyle', 'none','lineWidth', 1);


    title('Points avoided losing');
    xlabel('Conditions');
    ylabel('Lost Points(%)');

    ylim([50 100]);

    set(gca, 'XTick',1:4, 'XTickLabels',{'High Loss Contingent','High Loss Non-Contingent','Low Loss Contingent','Low Loss Non-Contingent'});
       