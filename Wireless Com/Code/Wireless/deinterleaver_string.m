%% Deinterleaver 
    % It perfoms the deinterleaving of the bits.
    %% *Syntax*
    % CDATA = deinterleaver_string(IDATA, Ncbps)
    %% *Description*
    % The deinterleaver_string(IDATA, Ncbps) function returns a set of
    % properly deinterleaved bits (CDatos). Based on two permutations 
    % made on the input data. The second inverse permutation is performed
    % and then the first inverse permutation according to the IEEE 802.11 
    % standard.
    % 
    % *Input arguments*
    %
    % * IDATA
    %
    % Input vector, specified as a vector of bits with interleaving.
    %   
    % * Ncbps
    %
    % Number of bits coded per symbol.
    %
    % *Output arguments*
    %
    % *  CDATA
    %
    % Deinterlaced bits vector. 
    %% *Examples*
    % The function deinterleaver_string(IDATA, Ncbps) is called.
function CDATA = deinterleaver_string(IDATA, Ncbps)
%% 
    % It is the same as interleaving but indexes are changed when
    % they are assigned.
    %
    % Creation of the permutation vector. Nbpsc represents the number 
    % of bits (coded) per subcarrier
    permutation = zeros(1, length(IDATA));    
    CDATA = zeros(1, length(IDATA));
    Nbpsc = Ncbps / 48;                         
%%    
    % Divide the string of bits into several strings of a number multiple of Ncbps.
    
    for a = 1 : length(IDATA) / Ncbps
%%      
        % *First permutation according to the IEEE 802.11 standard*
        %
        % The first permutation of the deinterleaver is the inverse second permutation 
        % that is done in the interleaving given by the equation: 
        %%
        % $j=sFloor(\frac{i}{8})+(i+Ncbps-Floor(16\frac{i}{Ncbps}))mods$
        %
        % It is also necessary to obtain the s parameter for the permutation, 
        % which is given by the equation:
        
        %%
        % $s=max(\frac{Nbpsc}{2},1)$
        %
        s = max(Nbpsc/2 , 1);
        for b = 1 : Ncbps
            c = s * floor((b-1)/s) + mod( ( (b-1) + Ncbps - floor( 16 * (b-1)/Ncbps ) ), s);
            i = (a-1)*Ncbps + b;
            j = (a-1)*Ncbps + (c+1);
            permutation(j) = IDATA(i);
        end
%%
        % *Second permutation according to the IEEE 802.11 standard*
        %
        % The second permutation of the deinterleaver is the inverse first permutation 
        % that is done in the interleaving given by the equation: 
        
        %%
        % $i=(\frac{Ncbps}{16})(kmod16)+Floor(\frac{k}{16})$
        %
        for b = 1 : Ncbps
            c = (Ncbps/16) * mod((b-1), 16) + floor((b-1)/16);  % Permutation rule
            k = (a-1)*Ncbps + b;       % Real original index
            i = (a-1)*Ncbps + (c+1);     % Real new index
            CDATA(i) = permutation(k);  % Permutation
        end
    end
end
%%
    % *See also*
    %
    % <Interleaver_string.html String interleaving>
    %
    % <process_DATA.html Data field processing> 