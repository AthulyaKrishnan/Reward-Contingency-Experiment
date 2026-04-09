[readme.txt](https://github.com/user-attachments/files/26489571/readme.txt)
`.m` files correspond to the MATLAB analysis scripts used for data processing (e.g., outlier removal, group averages).

Participant demographics are stored in an `.xlsx` file. Each participant is assigned a subject ID, along with age and gender (1 = Male, 2 = Female) is mentioned.

FOLDER: “ANOVA Results” contains `.csv` files with processed data (each row = participant, each column = condition), as well as JASP files where statistical tests were conducted [HR = High reward, LR = Low Reward, HL = High Loss, LL = Low Loss, HC = Contingent, LC = Non-Contingent].

FOLDER: “logFiles” contains the raw data collected during the experiment, including all variables.

FOLDER: “rollingWindow” contains `.m` files summarizing successful trials (defined as points won or loss avoided) from experiment 1 and experiment 2, across all reward-contingency conditions in each run for each participant.

FOLDER: “valueLog” contains `.m` files for each participant with criteria, total points won, and loss avoidance in each run across high/low gain/loss conditions.
