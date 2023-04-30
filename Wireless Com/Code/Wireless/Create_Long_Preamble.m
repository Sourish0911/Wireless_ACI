%% Long Preamble
    % Function to create the long preamble for the PLCP sub-layer PPDU.
    %% *Syntax*
    %
    % LongP = Create_Long_Preamble()
    %% *Description*
    % The Create_Long_Preamble() function creates the long preamble, based on the
    % specifications distributed by the IEEE 802.11-2012 standard.
    % To obtain the long preamble it is necessary to create a long sequence
    % and then 2 long sequences and the Guard Interval are concatenated.
    % The values of the carriers are assigned according to the indicated in
    % the standard.
%%
    % 
    % <<Pre_largo.PNG>>
    %     
    % *Input Arguments*
    % 
    % none 
    %
    % *Output arguments*
    %
    % * LongP
    %
    % Long preamble for the PLCP sub-layer PPDU.
    % 
    %% *Examples*
    %  The function Create_Long_Preamble() is called.

function LongP = Create_Long_Preamble()
%%
    % *Assigning values to carriers*
    %
    % An array of 53 elements is generated (52 subcarriers + DC) and 
    % the corresponding values are assigned.
    Lo_preamble = ones(1,53);
    Lo_preamble(1,3)= -1; 
    Lo_preamble(1,4)= -1; 
    Lo_preamble(1,7)= -1; 
    Lo_preamble(1,9)= -1;
    Lo_preamble(1,16)= -1; 
    Lo_preamble(1,17)= -1;
    Lo_preamble(1,20)=-1;
    Lo_preamble(1,22)=-1;
    Lo_preamble(1,27)=0;
    Lo_preamble(1,29)=-1; 
    Lo_preamble(1,30)=-1; 
    Lo_preamble(1,33)=-1; 
    Lo_preamble(1,35)=-1; 
    Lo_preamble(1,37)=-1; 
    Lo_preamble(1,38)=-1; 
    Lo_preamble(1,39)=-1; 
    Lo_preamble(1,40)=-1; 
    Lo_preamble(1,41)=-1; 
    Lo_preamble(1,44)=-1; 
    Lo_preamble(1,45)=-1; 
    Lo_preamble(1,47)=-1;
    Lo_preamble(1,49)=-1; 
%%
    % *Discretization process*:
    %
    % The indexes of the vector are ordered according to the  
    % standard.
    preambleLArr = zeros(1,64);
    preambleLArr(1) = 0;
    preambleLArr(2:27) = Lo_preamble(28:53);
    preambleLArr(28:38) = 0;
    preambleLArr(39:64) = Lo_preamble(1:26);
    
%%
    % The symbols are passed in time through the IFFT.
    preambleLifft = ifft(preambleLArr);        
%% 
    % *Long preamble concatenation*
    %
    % The cyclic prefix is obtained, using the last half of the long sequence.
    GI2 = preambleLifft(length(preambleLifft)/2+1:length(preambleLifft)); 
%%
    % The long preamble is created with a Guard Interval and two long
    % sequences.
    LongP = [GI2 preambleLifft preambleLifft];    
end
%%
% *See also*
%
    % <Create_SYNC.html Create_SYNC> 
