%% String data coding
    % Convolutional encoder with puncturing.
    % 
    %% *Syntax*
    %
    % CData = Encode_String(data, R)
    %
    %% *Description*
    %
    % The function CData = Encode_String(data, R) returns a set of 
    % encoded bits (CData) from the received parameters. 
    % The graphical representation of the convolutional encoder used 
    % in the 802.11p standard is as follows.
    %%
    % 
    % <<Cod_Conv.PNG>>
    % 
    % *Input Arguments*
    %
    %
    % * Data
    %
    % Input vector, specified as an uncoded bit vector.
    %   
    % * R
    %
    % Coding rate to perform the coding of the data parameter.
    %
    % *Output arguments*
    %
    % * CData
    %
    % Vector encoded bits with R encoding rate.
    %
    %% *Example*
    %
    %  The function Encode_String(data, R) is called.
function CData= Encode_String(data, R)
%%
    % Definition of the generating polynomials g0, g1 and of the restriction
    % length k for the creation of the Trellis diagram.
    g0 = 133;                               
    g1 = 171;                               
    k = 7;                                  
    trellis = poly2trellis(k, [g1 g0]);  
%%
    % Verification of the convolution rate and selection of the puncturing 
    % pattern according to the IEEE 802.11 standard.
    switch R
        case 1/2
            punctPattern =  [1 1];          % without puncturing        
        case 2/3
            punctPattern = [1 1 1 0];       % puncturing pattenr
        case 3/4
            punctPattern = [1 1 1 0 0 1];   % puncturing pattern
        otherwise
            errordlg('INVALID CODING RATE');
    end
 %%   
    % Coding of the data according to the Trellis diagram created 
    % with the selected puncturing pattern.
    punctPattern = fliplr(punctPattern);
    CData = convenc(data, trellis, punctPattern);     
end

%%
    % *See also*
    %
    % <https://la.mathworks.com/help/matlab/ref/fliplr.html fliplr> 
    %
    % <https://la.mathworks.com/help/comm/ref/convenc.html convenc> 
    %
    % <Create_SIGNAL.html Create_SIGNAL> 
    %
    % <Create_DATA.html PLCP DATA> 
    %
    % <decode_string.html String decodification>
    