\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pset}[2019/06/02 Base class for problem sets]

% Set bool for fancy (or not) theorems
\RequirePackage{etoolbox} \newbool{nosolutions}
\newbool{nobox} \newbool{inline}

% Choose whether we have A4, A5, B5 or letter paper. For A4/letter, set margins to 1 inch,
% for B5 and A5 to 0.75 inch
\DeclareOption{a4paper}{\PassOptionsToPackage{paper=a4paper,margin=1in}{geometry}}
\DeclareOption{letterpaper}{\PassOptionsToPackage{paper=a4paper,margin=1in}{geometry}}
\DeclareOption{a5paper}{\PassOptionsToPackage{paper=a5paper,margin=0.75in}{geometry}}
\DeclareOption{b5paper}{\PassOptionsToPackage{paper=b5paper,margin=0.75in}{geometry}}

% This option will determine whether the theorems are fancy (default) or not
\DeclareOption{nosolutions}{\booltrue{nosolutions}}
\DeclareOption{nobox}{\booltrue{nobox}}
\DeclareOption{inline}{\booltrue{inline}}

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

% To fix theorem spacing (because of parskip)
\begingroup
    \@for\theoremstyle:=definition,remark,plain\do{%
        \expandafter\g@addto@macro\csname th@\theoremstyle\endcsname{%
            \addtolength\thm@preskip\parskip
            }%
        }
\endgroup

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

% Use Bitstream Charter fonts
\RequirePackage[charter,cal=cmcal]{mathdesign}

% Hyperref
\AtEndPreamble{
    \RequirePackage[unicode]{hyperref}
    \hypersetup{colorlinks=true, allcolors=mOrange}
}

% Support for title, date, subject, term, author commands for title
\renewcommand{\title}[1]{\gdef\@title{#1}}
\renewcommand{\author}[1]{\gdef\@author{#1}}
\renewcommand{\date}[1]{\gdef\@date{#1}}
\newcommand{\term}[1]{\gdef\@term{#1}}
\newcommand{\course}[1]{\gdef\@course{#1}}

\global\let\@term\@empty
\global\let\@course\@empty

% Custom title
\renewcommand{\maketitle}{
\begingroup
    \begin{tcolorbox}[width=\textwidth,sharp corners, colframe=black, colback=white, boxrule=1pt]
        \parbox{\textwidth}{\centering
            {\large\scshape\@course\quad\hspace*{\fill}\@term\rule{0pt}{0pt}}\\[1em]
            {\LARGE\bfseries\@title}\ifdefempty{\@date}{\\[1em]}{\\}
            \ifdefempty{\@date}{}{{\large\@date}\\[1em]}
            {\large\@author}
        }
    \end{tcolorbox}\@thanks
\endgroup
}


% Definitions for problem
\newcommand{\problemstr}[1]{\renewcommand{\@problemstr}{#1}}
\newcommand{\@problemstr}{Problem}
\newcounter{problem}

% Temporary length
\newlength{\tskip}

% Custom problem command
\newcommand{\problem}[2][]{%
    \vskip 3.25ex plus 1ex minus .2ex%
    {\bfseries\ifbool{inline}{\normalsize}{\Large}\@problemstr\ \refstepcounter{problem}\theproblem\ifstrempty{#1}{}{\label{pr:#1}}%
     \ifstrempty{#2}{}{ (#2)}}%
    \setlength{\tskip}{1em-\parskip}\ifbool{inline}{\hskip 1em}{\vskip \tskip}
}

% Custom solutions
\RequirePackage[theorems]{tcolorbox}

\RequirePackage{comment}
\ifbool{nosolutions}{
    \specialcomment{solutions}{\begingroup}{\endgroup}%
    \excludecomment{solutions}
}{
    \theoremstyle{remark}%
    \newtheorem*{solutions}{Solutions}%
    \ifbool{nobox}{}{
        \tcolorboxenvironment{solutions}{
            sharp corners, colframe=black, colback=white, boxrule=1pt
        }
    }
}

% Hide solutions if nosolutions option is passed

%\renewenvironment{solutions}{comment}{}