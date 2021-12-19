% mweight  Computes the molecular weights for a set of chemical species.
%
% SYNTAX
%
%   mw = mweight(formula)
%   mw = mweight(species)
%   mw = molweigth(r)
%
%   Computes the molecular weight of a chemical species. The species may be
%   specified as a chemical formula, a cell array of chemical formulas or
%   as a structure array of atomic representations. If there are no output
%   arguments then a table of molecular weights is displayed.
%
%
% EXAMPLES
%
%   1. Molecular weight of methane
%
%       mw = mweight('CH4')
%
%   2. Molecular weight of methane using a structure array
%
%       r.C = 1;
%       r.H = 4;
%       mweight(r);
%
%   3. Molecular weights of set of compounds
%
%       mweight({'CH4','O2','CO2','H2O'});
%
% AUTHOR : Jeff Kantor (December 18, 2010)
%
% Adapted and modified by Pascal Denis (May 3, 2020)
%
% Atomic mass according tothe value published by IUPAC
% https://iupac.org/wp-content/uploads/2018/12/IUPAC_Periodic_Table-01Dec18.pdf

function mw = mweight(varargin)

% mweight  Computes the molecular weights for a set of chemical species.
%
% SYNTAX
%
%   mw = mweight(formula)
%   mw = mweight(species)
%   mw = mweigth(r)
%
%   Computes the molecular weight of a chemical species. The species may be
%   specified as a chemical formula, a cell array of chemical formulas or
%   as a structure array of atomic representations. If there are no output
%   arguments then a table of molecular weights is displayed.
%
%
% EXAMPLES
%
%   1. Molecular weight of methane
%
%       mw = mweight('CH4')
%
%   2. Molecular weight of methane using a structure array
%
%       r.C = 1;
%       r.H = 4;
%       mweight(r);
%
%   3. Molecular weights of set of compounds
%
%       mweight({'CH4','O2','CO2','H2O'});
%
 
% AUTHOR
%
%    Jeff Kantor
%    December 18, 2010

% Modified 2020/05/03
%
% Pascal Denis
% Atomic mass according tothe value published by IUPAC or NIST
% https://iupac.org/wp-content/uploads/2018/12/IUPAC_Periodic_Table-01Dec18.pdf
% https://www.nist.gov/system/files/documents/2019/12/10/nist_periodictable_july2019_crop.pdf

    % This file is part of larger project for developing Matlab based tools
    % for undergraduate use in Chemical Engineering. The following data
    % structure was adapted from that project.

    persistent ppds;

    if isempty(ppds)
        element = @(str, atomicnumber, amu) amu;
        
        ppds.M  = element('any metal',      0,   NaN);
        ppds.X  = element('any halogen',    0,   NaN);
        ppds.H  = element('Hydrogen',       1,   1.000);
        ppds.D  = element('Deuterium',      1,   2.000);
        ppds.T  = element('Tritium',        1,   3.000);
        ppds.He = element('Helium',         2,   4.000);
        ppds.Li = element('Lithium',        3,   7.000);
        ppds.Be = element('Beryllium',      4,   9.0);
        ppds.B  = element('Boron',          5,  11.00);
        ppds.C  = element('Carbon',         6,  12.000);
        ppds.N  = element('Nitrogen',       7,  14.000);
        ppds.O  = element('Oxygen',         8,  16.000);
        ppds.F  = element('Fluorine',       9,  19.000);
        ppds.Ne = element('Neon',          10,  20.000);
        ppds.Na = element('Sodium',        11,  23.000);
        ppds.Mg = element('Magnesium',     12,  24.000);
        ppds.Al = element('Aluminium',     13,  27.000);
        ppds.Si = element('Silicon',       14,  28.000);
        ppds.P  = element('Phosphorus',    15,  31.000);
        ppds.S  = element('Sulfur',        16,  32.000);
        ppds.Cl = element('Chlorine',      17,  35.500);
        ppds.Ar = element('Argon',         18,  40.000);
        ppds.K  = element('Potassium',     19,  39.000);
        ppds.Ca = element('Calcium',       20,  40.000);
        ppds.Sc = element('Scandium',      21,  45.000);
        ppds.Ti = element('Titanium',      22,  48.000);
        ppds.V  = element('Vanadium',      23,  51.000);
        ppds.Cr = element('Chromium',      24,  52.000);
        ppds.Mn = element('Manganese',     25,  55.000);
        ppds.Fe = element('Iron',          26,  56.000);
        ppds.Co = element('Cobalt',        27,  59.000);
        ppds.Ni = element('Nickel',        28,  59.000);
        ppds.Cu = element('Copper',        29,  63.5);
        ppds.Zn = element('Zinc',          30,  65.0);
        ppds.Ga = element('Gallium',       31,  70.000);
        ppds.Ge = element('Germanium',     32,  72.600);
        ppds.As = element('Arsenic',       33,  75.000);
        ppds.Se = element('Selenium',      34,  79.00);
        ppds.Br = element('Bromine',       35,  80.000);
        ppds.Kr = element('Krypton',       36,  84.00);
        ppds.Rb = element('Rubidium',      37,  85.5);
        ppds.Sr = element('Strontium',     38,  88.00);
        ppds.Y  = element('Yttrium',       39,  89.00);
        ppds.Zr = element('Zirconium',     40,  91.00);
        ppds.Nb = element('Niobium',       41,  93.00);
        ppds.Mo = element('Molybdenum',    42,  96.00);
        ppds.Tc = element('Technetium',    43,  97.00);
        ppds.Ru = element('Ruthenium',     44, 101.00);
        ppds.Rh = element('Rhodium',       45, 103.00);
        ppds.Pd = element('Palladium',     46, 106.00);
        ppds.Ag = element('Silver',        47, 108.00);
        ppds.Cd = element('Cadmium',       48, 112.00);
        ppds.In = element('Indium',        49, 115.00);
        ppds.Sn = element('Tin',           50, 119.00);
        ppds.Sb = element('Antimony',      51, 122.00);
        ppds.Te = element('Tellurium',     52, 128.00);
        ppds.I  = element('Iodine',        53, 127.00);
        ppds.Xe = element('Xenon',         54, 131.00);
        ppds.Cs = element('Cesium',        55, 133.00);
        ppds.Ba = element('Barium',        56, 137.00);
        ppds.La = element('Lanthanum',     57, 139.00);
        ppds.Ce = element('Cerium',        58, 140.00);
        ppds.Pr = element('Praseodymium',  59, 141.00);
        ppds.Nd = element('Neodymium',     60, 144.00);
        ppds.Pm = element('Promethium',    61, 145.00);
        ppds.Sm = element('Samarium',      62, 150.00);
        ppds.Eu = element('Europium',      63, 152.00);
        ppds.Gd = element('Gadolinium',    64, 157.00);
        ppds.Tb = element('Terbium',       65, 159.00);
        ppds.Dy = element('Dysprosium',    66, 162.50);
        ppds.Ho = element('Holmium',       67, 165.00);
        ppds.Er = element('Erbium',        68, 167.00);
        ppds.Tm = element('Thulium',       69, 169.00);
        ppds.Yb = element('Ytterbium',     70, 173.00);
        ppds.Lu = element('Lutetium',      71, 175.00);
        ppds.Hf = element('Hafnium',       72, 178.50);
        ppds.Ta = element('Tantalum',      73, 181.00);
        ppds.W  = element('Tungsten',      74, 184.00);
        ppds.Re = element('Rhenium',       75, 186.00);
        ppds.Os = element('Osmium',        76, 190.00);
        ppds.Ir = element('Iridium',       77, 192.00);
        ppds.Pt = element('Platinum',      78, 195.00);
        ppds.Au = element('Gold',          79, 197.00);
        ppds.Hg = element('Mercury',       80, 201.00);
        ppds.Tl = element('Thallium',      81, 204.00);
        ppds.Pb = element('Lead',          82, 207.00);
        ppds.Bi = element('Bismuth',       83, 209.00);
        ppds.Po = element('Polonium',      84, 209.00);
        ppds.At = element('Astatine',      85, 210.00);
        ppds.Rn = element('Radon',         86, 222.00);
        ppds.Fr = element('Francium',      87, 223.00);
        ppds.Ra = element('Radium',        88, 226.00);
        ppds.Ac = element('Actinium',      89, 227.00);
        ppds.Th = element('Thorium',       90, 232.00);
        ppds.Pa = element('Protactinium',  91, 231.00);
        ppds.U  = element('Uranium',       92, 238.00);
        ppds.Np = element('Neptunium',     93, 237.00);
        ppds.Pu = element('Plutonium',     94, 244.00);
        ppds.Am = element('Americium',     95, 243.00);
        ppds.Cm = element('Curium',        96, 247.00);
        ppds.Bk = element('Berkelium',     97, 247.00);
        ppds.Cf = element('Californium',   98, 251.00);
        ppds.Es = element('Einsteinium',   99, 252.00);
        ppds.Fm = element('Fermium',      100, 257.00);
        ppds.Md = element('Mendelevium',  101, 258.00);
        ppds.No = element('Nobelium',     102, 259.00);
        ppds.Lr = element('Lawrencium',   103, 266.00);
        ppds.Q  = element('charge',         0,   0);
        ppds.e  = element('electron',       0,   0);

    end
    
    assert(nargin > 0, 'mweight:input', ['No input. Expects a cell ', ...
                        'array of formulas or struct array of atoms.']);
    assert(nargin < 2, 'mweight:input', 'Unexpected extra inputs.');
     
    % Process function argument to produce a cell array of chemical
    % formulas and structure array of atomic representations.
    
    switch class(varargin{1})
        case 'char'                      % Single formula
            species = varargin;
            r = parse_formula(species);
        
        case 'cell'                      % Cell array of formulas
            species = varargin{1};
            r = parse_formula(species);
            
        case 'struct'                    % Structure array
            r = varargin{1};
            species = hillformula(r);
            
        otherwise
            error('mweight:input',['requires cell array of chemical ',...
              'formulas or a structure array of atomic representations']);
    end

    % For each element of the structure array, compute a molecular weight

    mw = zeros(size(r));
    atoms = fields(r);
    
    for n = 1:size(r(:))
        for i = 1:length(atoms)
            
            % The following check is needed to avoid add adding NaN in
            % cases where M or X appear in atoms.
            
            if r(n).(atoms{i}) > 0
                mw(n) = mw(n) + ppds.(atoms{i})*r(n).(atoms{i});
            end
            
        end
    end
    
    % If no outputs, then display results

    if nargout == 0
        fprintf('\n');
        fprintf('%-25s  %8s\n','Species','Mol. Wt.');
        fprintf('%-25s  %8s\n','-------','--------');
        for n = 1:size(mw(:))
            fprintf('%-25s  %8.3f\n',species{n},mw(n));
        end  
    end

end
function r = parse_formula(varargin)

% PARSE_FORMULA Parses a chemical formula to form an atomic representation.
%
% SYNTAX
%
% r = parse_formula(str)
% r = parse_formula({str1,str2,str3, ...})
%
%   Parses chemical formulas and returns a structure array holding the an
%   atomic representation of the chemical forulas. The input is a string or
%   a cell array of strings.
%
%
% EXAMPLES
% 
%   1. Chemical formulas of varying complexity
% 
%       parse_formula('H2O');            % Water
%       parse_formula('NaHCO3');         % Sodium Bicarbonate
%       parse_formula('(CH4)8(H2O)46');  % Methane Clathrate
%       parse_formula('CH3COOCH2CH3');   % Ethyl Acetate
%       parse_formula('MnO4-');          % Negative Charge Ion
%
%       parse_formula('dCH4');           % Returns error message
%
%   2. Create an structure array of atomic representations for a set of
%      compounds
%
%       r = parse_formula({'CH4','O2','CO2','H2O'});
%
%
% USAGE NOTES
%
%   1. Formulas are made of up of sequences of elements followed by
%      integers  indicating the number of included atoms. Omitted integers
%      are assumed to be one.
%
%   2. Elements are the conventional one or two character abbreviations.
%      The character is captialized. If present, the second character is
%      lower case. In addition to the standard elements, the parser allows
%      for
%
%       Symbol  Entity                 Interpretation
%          e    electron               like an element with MW = 0
%          D    deuterium              an element
%          T    tritium                an element
%          M    any metal              like an element, mw = NaN
%          X    any halogen            like an element, mw = NaN
%          Me   methyl group (CH3)     CH3 substituted for Me
%          Et   ethyl group (C2H5)     C2H5 substituted for Et
%          Bu   butyl group (C4H9)     C4H9 substituted for Bu
%          Ph   phenol group (C6H5)    C6H5 substituted for Ph
%
%   3. Subgroups may be included between parenthesis or brackets followed
%      by an integer indicating number of repetitions. Two levels of
%      subgrouping are allowed.
%
%   4. A terminal lower case suffix denoting phases will be correctly
%      parsed. The phase must be one of (aq), (l), (g), or (s).
%
%   5. The charge on an ionic species is appended as a + or - followed by
%      an optional integer.  Examples are H+, OH-, or Ca+2.
%
%   6. The bare electron e- is used in balancing chemical half reactions.
%
%   7. Error messages are generated for invalid fomulas
%
%   8. str can be a cell array of chemical formula. The results is a
%      structure array. The elements of the output structure array are in
%      one-to-one correspondence with elements of the cell array. For
%      example
%
%          r = parse_formula({'CH4','CH3OH','CHOOH'})
%
%      r(1) holds the atomic formula for CH4, r(2) for CH3OH, and r(3) for
%      CHOOH.

% AUTHOR
%
%   Jeff Kantor
%   December 18, 2010


    assert(nargin > 0, 'parse_formula:input', ['No input. Expects a  ', ...
                        'string or cell array of chemical formulas.']);
    assert(nargin < 2, 'stoich:input', 'Unexpected extra inputs.');
    
    switch class(varargin{1})
        case 'char'                      % Single formula
            str = varargin;
        
        case 'cell'                      % Cell array of formulas
            str = varargin{1};
            
        otherwise
            error('parse_formula:input',['requires cell array of  ',...
              'chemical formulas.']);
    end
    
    assert(iscellstr(str), 'parse_formula:input', ...
        'Formulas must be strings.');
    
    % Trim any whitespace at front or back
    
    str = strtrim(str);
    
    % Remove phase information. This information is currently neglected. In
    % a later version we may wish to incorporate phase into a more complete
    % data structure for representing chemical formula.
    
    prex = '|\((aq|g|l|s)\)$';
    str = regexprep(str,prex,'');
    
    % Substitute for some common chemical abbreviations
    
    str = regexprep(str,'Bu','C4H9');    % Butyl
    str = regexprep(str,'Et','C2H5');    % Ethyl
    str = regexprep(str,'Me','CH3');     % Methyl
    str = regexprep(str,'Ph','C6H5');    % Phenol

    % Apply the main parser to every element of str

    q = cellfun(@(s)parse_formula_(s,3),str,'Uniform',false);

    % Union of all atomic species

    atoms = {};
    for i = 1:length(q(:))
        atoms = union(atoms, fields(q{i}));
    end
    
    % Add all atomic species to all structures.

    for i = 1:length(q(:))
        for j = 1:length(atoms)
            if ~ismember(atoms{j},fields(q{i}))
                q{i}.(atoms{j}) = 0;
            end
        end
    end

    % Form the structure array to have the same shape as str
    
    r = reshape([q{:}],size(str));
   
end % parse_formula
function r = parse_formula_(str,kdepth)

    assert(kdepth > 0, 'parse_formula_:Recursion', ...
        'Reached maximum recursion depth');

    r = struct([]);
    
    % Regular expression returning tokens for element and number
    % sexpr matches single elements followed by a digit, or a +/-
    % followed by a digit to denote charge
    
    persistent srex;  % Regexp pattern to match elements and charges
    persistent grex;  % Regexp pattern to match groups
    
    if isempty(srex) || isempty(grex)
        srex = ['(A[lrsgutcm]|B[eraik]?|C[laroudsemf]?|D[y]?|E[urs]|', ...
                'F[erm]?|G[aed]|H[eofgas]?|I[nr]?|Kr?|L[iaur]|', ...
                'M[gnodt]?|N[eaibdpos]?|Os?|P[drmtboau]?|R[buhenaf]|', ...
                'S[icernbmg]?|T[icebmalh]?|U|V|W|X[e]?|Yb?|Z[nr])', ...
                '(\d*\.\d+|\d*)', ...
                '|(e|+|-)(\d*)'];
        grex = '|\(([^\)]*)\)(\d*\.\d+|\d*)|\[([^\]]*)\](\d*\.\d+|\d*)';
    end

    % Parse formula for chemical groups. This picks out anything that looks
    % an element followed by a number, or a subgroup within parentheses.
    % The tokens are returned in the cell array u. Each u{k} has two
    % elements, the first is a string denoting the group, and the second is
    % number string of repetitions.

    [u,s,e] = regexp(str,[srex,grex],'tokens','start','end');

    % Report any parsing errors. A parse error occurs if there are any
    % characters not matched as tokens. We scan the start and end positions
    % of the tokens to determine if there are any gaps.

    g(1:length(str)) = '^';
    for i = 1:length(s);
        g(s(i):e(i)) = ' ';
    end
    
    assert(all(g ~= '^'), 'parse_formula:ParseError', ...
        'Could not parse formula:\n    %s\n    %s\n', str, char(g));
    
    % Extract atom tokens from the first part of each token
    
    tok = cellfun(@(v)v{1},u,'Uni',false);

    % Extract counts from the second part of each token, convert to
    % doubles, empty counts set to 1
    
    cnt = cellfun(@(v)v{2},u,'Uni',false);
    cnt = str2double(cnt);
    cnt(isnan(cnt)) = 1;
    
    % Loop over tokens

    for j = 1:length(u)

        % See if token matches an element

        if strcmp(tok{j},regexp(tok{j},srex,'match'))

            % The token exactly matches an element.
            % Change + or - tokens to 'Q'.
            
            tok{j} = regexprep(tok{j},'+','Q');

            if strcmp(tok{j}, '-')
                tok{j} = 'Q';
                cnt(j) = -cnt(j);
            end

            % Update atomic representation, adding a field if needed.

            if isfield(r,tok{j})
                r.(tok{j}) = r.(tok{j}) + cnt(j);
            else
                r(1).(tok{j}) = cnt(j);
            end

        else 

            % The token must be a group, so do a recursion to find
            % an atomic represenation of the group.

            q = parse_formula_(tok{j},kdepth-1);

            % Updatethe  atomic representation to include the group.
            % Add fields if needed. Multiply by number of groups in the
            % formula we're parsing.

            f = fields(q);

            for k = 1:length(f)

                if isfield(r,f{k})
                    r.(f{k}) = r.(f{k}) + cnt(j)*q.(f{k});
                else
                    r(1).(f{k}) = cnt(j)*q.(f{k});
                end

            end
        end
    end
        
end % parse_formula_