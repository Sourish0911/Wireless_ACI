%% PLCP Preamble 
    % Function to create the SYNC field of the 802.11 standard (PLCP sub-layer PPDU).
    %% *Syntax*
    %  SYNC = Create_SYNC()
    %% *Description*
    % The Create_SYNC() function allows you to create the short preamble
    % and the long preamble through of independent functions. Then 
    % concatenate both of them and obtain the PPDU preamble.
    % The generation of the preambles is given according to the IEEE 802.11-2012 standard.
   %%
    % 
    % <<Pre_PPDU.PNG>>
    %
    % *Input Arguments*
    % 
    % none SIGNAL
    %
    % *Output arguments*
    %
    % * SYNC
    %
    % SYNC field of the 802.11 standard.
    %% *Example*
    % The function Create_SYNC() is called.
%%
 function SYNC = Create_SYNC()
%%
    % Each part of the preamble is created independently.
    ShortP=Create_Short_Preamble();
    LongP=Create_Long_Preamble();
%%
    % The preamble is concatenated.
    SYNC = [ShortP LongP];
end 
%%
% *See also*
%
    % <Create_Short_Preamble.html Create_Short_Preamble()> 
    %
    % <Create_Long_Preamble.html Create_Long_Preamble()>
    %
    % <txOFDM.html OFDM package transmission>
