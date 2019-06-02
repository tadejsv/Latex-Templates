\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2019/06/01 Base class for (lecture) notes]

% Set bool for fancy (or not) theorems
\RequirePackage{etoolbox} \newbool{nofancy}

% Choose whether we have A4, A5, B5 or letter paper. For A4/letter, set margins to 1 inch,
% for B5 and A5 to 0.75 inch
\DeclareOption{a4paper}{\PassOptionsToPackage{paper=a4paper,margin=1in}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToPackage{paper=a4paper,margin=1in}{geometry}}
\DeclareOption{a5paper}{\PassOptionsToPackage{paper=a5paper,margin=0.75in}{geometry}}
\DeclareOption{b5paper}{\PassOptionsToPackage{paper=b5paper,margin=0.75in}{geometry}}

% This option will determine whether the theorems are fancy (default) or not
\DeclareOption{nofancy}{\booltrue{nofancy}}

% All other options go to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Process options - defaults are letterpaper, 11pt size
\ExecuteOptions{letterpaper,11pt}
\ProcessOptions \relax

% This extends the base article class
\LoadClass{article}

% Set the size/margins 1.25 inch left/right and 1 inch top/bottom for letter paper
\RequirePackage{geometry}

% Input and output encoding 
\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}

% Math packages
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{IEEEtrantools}

% To load images
\RequirePackage{graphicx}

% For tables
\RequirePackage{booktabs}

% To separate paragraphs by vertical space, not horizontal
\RequirePackage{parskip}

% To fix theorem spacing in nofancy mode (because of parskip)
\begingroup
    \@for\theoremstyle:=definition,remark,plain\do{%
        \expandafter\g@addto@macro\csname th@\theoremstyle\endcsname{%
            \addtolength\thm@preskip\parskip
            }%
        }
\endgroup

% Customizing the title a bit - we use alphabetical footnote for thanks due to a
% but which causes the * sign to not appear (this may be fixed, check back later)
\RequirePackage{titling}
\thanksmarkseries{alph}

% For showing code - set background color to grey!10 by default

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       WARNING     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REMOVE THE outputdir OPTION WHEN USING THE TEMPLATE IN ITS OWN
% PACKAGE WHERE THE main.tex FILE IS IN THE ROOT PROJECT DIR
\RequirePackage[outputdir=..]{minted}
\setminted{bgcolor=gray!10,breaklines=true,python3=true}
\usemintedstyle{friendly}

% To add the H parameter for float placement
\RequirePackage{float}

% To get text width in inches
\RequirePackage{printlen}

% Import the macros.sty package, we mainly need it for the color palette 
\RequirePackage{macros}

% Color theorem environments
\RequirePackage[theorems,skins,breakable]{tcolorbox}
\ifbool{nofancy}{%
    \theoremstyle{definition}
    \newtheorem{dfn}{Definition}[section]
    \newtheorem{Iexm}{Example}[section]
   
    \theoremstyle{plain}
    \newtheorem{Ithm}{Theorem}[section]
    \newtheorem{Ilem}{Lemma}[section]

    \newenvironment{definition}[2]
        {\begin{dfn}[#1]\ifstrempty{#2}{}{\label{dfn:#2}}}
        {\end{dfn}}
    \newenvironment{lem}[2]
        {\begin{Ilem}[#1]\ifstrempty{#2}{}{\label{lem:#2}}}
        {\end{Ilem}}
    \newenvironment{thm}[2]
        {\begin{Ithm}[#1]\ifstrempty{#2}{}{\label{thm:#2}}}
        {\end{Ithm}}
    \newenvironment{example}[2]
        {\begin{Iexm}[#1]\ifstrempty{#2}{}{\label{exm:#2}}}
        {\end{Iexm}}
}{%
    \newtcbtheorem[number within=section]{thm}{Theorem}{
        colback=white, coltitle = black, fonttitle=\bfseries, colframe=lMint!70!white, sharp corners, enhanced,
        attach boxed title to top left={
            yshift=-\tcboxedtitleheight/2, xshift = 7mm, yshifttext=-\tcboxedtitleheight/4
        },
        boxed title style={colback=lMint!70!white, sharp corners}, breakable
    }{thm}
    \newtcbtheorem[number within=section]{lem}{Lemma}{
        colback=white, coltitle = black, fonttitle=\bfseries, colframe=lMint!70!white, sharp corners, enhanced,
        attach boxed title to top left={
            yshift=-\tcboxedtitleheight/2, xshift = 7mm, yshifttext=-\tcboxedtitleheight/4
        },
        boxed title style={colback=lMint!70!white, sharp corners}, breakable
    }{lem}
    \newtcbtheorem[number within=section]{example}{Example}{
        colback=white, coltitle = black, fonttitle=\bfseries, colframe=lPear!70!white, sharp corners, enhanced,
        attach boxed title to top left={
            yshift=-\tcboxedtitleheight/2, xshift = 7mm, yshifttext=-\tcboxedtitleheight/4
        },
        boxed title style={colback=lPear!70!white, sharp corners}, breakable
    }{exm}
    \newtcbtheorem[number within=section]{definition}{Definition}{
        colback=white, coltitle=black, fonttitle=\bfseries, colframe=lBlue!70!white, sharp corners, enhanced,
        attach boxed title to top left={
            yshift=-\tcboxedtitleheight/2, xshift = 7mm, yshifttext=-\tcboxedtitleheight/4
        },
        boxed title style={colback=lBlue!70!white, sharp corners}, title=Definition, breakable
    }{dfn}
    \tcolorboxenvironment{proof}{colframe=lCyan,interior hidden,breakable,colback=white,sharp corners}
}

% Use Bitstream Charter fonts
\RequirePackage[charter,cal=cmcal]{mathdesign}

% Use Fira Sans as sans-serif font
\RequirePackage[lining]{FiraSans}

% Hyperref
\AtEndPreamble{
    \RequirePackage[unicode]{hyperref}
    \hypersetup{colorlinks=true, allcolors=mOrange}
}