clearvars
basic_path = pwd;
logfile_path = strcat(basic_path, '\logFiles');
cd(logfile_path);
allfiles = dir(logfile_path);
allfiles = {allfiles(:).name};
allfiles = allfiles(3:length(allfiles))';


lastfile = allfiles(end);
lastfile = cell2mat(lastfile);
lastPnum = str2num(lastfile(5:6));
gp_avg_RTs = table();

% define tables for group acc - each row participant
gp_avg_Acc = table();

% main loop

RT = [];
acc = [];
valence_order = [];
reward_order = [];
contigency_order = [];
identity_order = [];
target_order = [];
targetPos_order = [];
 
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
        else 
            pid = num2str(part);
            pfiles = ~cellfun('isempty',strfind(allfiles, strcat('CRD7',pid)));
            all_pfiles = allfiles(pfiles); 
        end 

        %% Getting log files for every blockes defined above. 
        logfile1 = all_pfiles{1,:};
        file1 = load(logfile1,'accuracy','RT','EmoOrder', 'TargetLetterOrder','TargetPositionOrder', 'IdentityOrder');
    
        
        % concatenating all the files variables into one. This will be values
        % per block
        

        RT = cat(1, file1.RT(:));
        acc = cat(1, file1.accuracy(:));
        valence_order = cat(1, file1.EmoOrder(1:48,:));
        identity_order = cat(1, file1.IdentityOrder(1:48,:));
        target_order =  cat(1, file1.TargetLetterOrder(1:48,:));
        targetPos_order =  cat(1, file1.TargetPositionOrder(1:48,:));


        %% take average for each condition

        % RT
        avgRT = mean(RT);
      
        % Accuracy
        avgAcc = mean(acc);
       
        %% define conditionwise variables 

        %%%% RT %%%%

        pos_RT = RT(valence_order == 1  & acc == 1);
        neu_RT = RT(valence_order == 2  & acc == 1);
        neg_RT = RT(valence_order == 3  & acc == 1);

        %%%% Accuracy %%%%

        pos_Acc = acc(valence_order == 1 & acc == 1);
        neu_Acc = acc(valence_order == 2 & acc == 1);
        neg_Acc = acc(valence_order == 3 & acc == 1);

       
        %% remove conditiowise outliers and take average again and plot

        % HR_HC
        posMax = mean(pos_RT)+3*std(pos_RT);
        posMin = mean(pos_RT)-3*std(pos_RT);
        neuMax = mean(neu_RT)+3*std(neu_RT);
        neuMin = mean(neu_RT)-3*std(neu_RT);
        negMax = mean(neg_RT)+3*std(neg_RT);
        negMin = mean(neg_RT)-3*std(neg_RT);

     
        % removal of outlier

        Outlier = [];


        

         for z=1:48
               if ((valence_order(z) == 1) && (acc(z) == 1))% if information order is uninfo, congriuency order is congruent, accuracy is 1
                  if RT(z)> posMax % response time is greater than congmax
                      Outlier(z)=1; % it is an outlier
                  else
                      Outlier(z)=0;
                  end
               elseif ((valence_order(z) == 1) && (acc(z) == 1))
                  if RT(z)< posMin
                      Outlier(z)=1;
                  else
                      Outlier(z)=0;
                  end
               elseif  ((valence_order(z) == 2) && (acc(z) == 1))
                  if RT(z)> neuMax
                      Outlier(z)=1;
                  else
                      Outlier(z)=0;
                  end
               elseif ((valence_order(z) == 2) && (acc(z) == 1))
                  if RT(z)< neuMin
                      Outlier(z)=1;
                  else
                      Outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (acc(z) == 1))
                  if RT(z)> negMax
                      Outlier(z)=1;
                  else
                      Outlier(z)=0;
                  end
               elseif ((valence_order(z) == 3) && (acc(z) == 1))
                  if RT(z)< negMin
                      Outlier(z)=1;
                  else
                      Outlier(z)=0;
                  end
               else 
                   Outlier(z)=0;
               end
         end

        % when no response is made, the accuracy is 0
        RT(acc==0 | (Outlier)' ==1)=[]; % when incorrect response is made, the RT is taken as nil
        valence_order(acc==0 | Outlier'==1)=[]; % info order taken as nil when incorrect responses are made
        target_order(acc==0 | Outlier'==1)=[];
        targetPos_order(acc==0 | Outlier'==1)=[]; % Accuracy is nil when incorrect responses are made
%        gender_order(acc==0 | Outlier'==1)=[];
        identity_order(acc==0 | Outlier'==1)=[];
        acc(acc==0 | Outlier'==1)=[];


        %% append conditionwise values to the group avg table .
        %%%% RT %%%%

        pos_RT = RT(valence_order == 1 & acc == 1);
        neu_RT = RT(valence_order == 2 & acc == 1);
        neg_RT = RT(valence_order == 3 & acc == 1);


        %%%% Accuracy %%%%

        pos_Acc = acc(valence_order == 1 & acc == 1);
        neu_Acc = acc(valence_order == 2 & acc == 1);
        neg_Acc = acc(valence_order == 3 & acc == 1);

    

        %% conditionwise mean value

        %%%% RT %%%%

       
        pos_avgRT = mean(pos_RT);
        neu_avgRT = mean(neu_RT);
        neg_avgRT = mean(neg_RT);
       
        %%%% Accuracy %%%%

        % RH
        pos_avgAcc = sum(pos_Acc)/24;
        neu_avgAcc = sum(neu_Acc)/48;
        neg_avgAcc = sum(neg_Acc)/24;


        %% group average



        gp_avg_RTs = [gp_avg_RTs;table(pos_avgRT, neu_avgRT, neg_avgRT)];
                    
       
                                                        
        gp_avg_Acc = [gp_avg_Acc;table(pos_avgAcc, neu_avgAcc, neg_avgAcc)];
        
         
       %end
        
   end 
    
   
    
    %% plotting
        
        % RT
        
        gp_pos_avgRT = mean(gp_avg_RTs.pos_avgRT);
        gp_neu_avgRT = mean(gp_avg_RTs.neu_avgRT);
        gp_neg_avgRT = mean(gp_avg_RTs.neg_avgRT);
       
        % plot1
        RT = [gp_neu_avgRT];
        
       
        % Plotting the graphs

        figure;
        b=bar(RT*1000);

        hold on

        X = cat(2,gp_avg_RTs.neu_avgRT);
                        % cat(2 %% dimension)one or two dimension, we hav chosen 2 dimension
        [nSubj, nCond] = size(X); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
        corr_fac =sqrt((nCond)/(nCond-1));

        Y = X - repmat(mean(X,2,'omitnan'),1,size(X,2)) + repmat(mean(mean(X,'omitnan')), size(X,1),size(X,2)); %%??
        Z = corr_fac * ( Y - repmat(mean(Y,'omitnan'), size(Y,1), 1)) + repmat(mean(Y,'omitnan'), size(Y,1), 1);
        RT_avg_stderr = std(Z,'omitnan')/sqrt(nSubj);
        xBar1 = get(b,'XData')' + [b.XOffset]; %??????
        stderr=cat(1,RT_avg_stderr(1)*1000*1.96); %???????
        errorbar(xBar1,RT*1000, stderr, 'k', 'linestyle', 'none','lineWidth', 1);

        title('RT');
        xlabel('Conditions');
        ylabel('Reaction Time(ms)');

        ylim([500 1000]);

        set(gca, 'XTick',1, 'XTickLabels',{'Neutral'});     
       


        %% Accuracy
        
        gp_pos_avgAcc = mean(gp_avg_Acc.pos_avgAcc);
        gp_neu_avgAcc = mean(gp_avg_Acc.neu_avgAcc);
        gp_neg_avgAcc = mean(gp_avg_Acc.neg_avgAcc);
        
        
        % plot 1
        Acc= [gp_neu_avgAcc];
                

        % Plotting the graphs

        figure;
        b_acc=bar(Acc*100);

        hold on

        X_Acc = cat(2,gp_avg_Acc.neu_avgAcc);
                        % cat(2 %% dimension)one or two dimension, we hav chosen 2 dimension

        [nSubj, nCond] = size(X_Acc); % nsub means no of subkects, no of conditons, = size of the X which is 7 rows, 6 columns
        corr_fac =sqrt((nCond)/(nCond-1));

        Y_Acc = X_Acc - repmat(mean(X_Acc,2,'omitnan'),1,size(X_Acc,2)) + repmat(mean(mean(X_Acc,'omitnan')), size(X_Acc,1),size(X_Acc,2)); %%??
        Z_Acc = corr_fac * ( Y_Acc - repmat(mean(Y_Acc,'omitnan'), size(Y_Acc,1), 1)) + repmat(mean(Y_Acc,'omitnan'), size(Y_Acc,1), 1);
        RT_avg_stderrAcc = std(Z_Acc,'omitnan')/sqrt(nSubj);
        xBar2 = get(b_acc,'XData')' + [b_acc.XOffset]; %??????
        stderr_Acc=cat(1,RT_avg_stderrAcc(1)*100*1.96);%???????
        errorbar(xBar2, Acc*100, stderr_Acc, 'k', 'linestyle', 'none','lineWidth', 1);

        title('Accuracy');
        xlabel('Conditions');
        ylabel('Accuracy(%)');

        ylim([50 100]);

        set(gca, 'XTick',1, 'XTickLabels',{'Neutral'});
        %legend('Positive','Neutral','Negative');
        