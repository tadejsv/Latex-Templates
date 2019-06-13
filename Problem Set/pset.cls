\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{pset}[2019/06/02 Base class for problem sets]

\RequirePackage{etoolbox}

% Set bool for fancy (or not) theorems
\newbool{nosolutions}
\newbool{nobox} \newbool{inline}

% This option will determine whether the theorems are fancy (default) or not
\DeclareOption{nosolutions}{\booltrue{nosolutions}}
\DeclareOption{nobox}{\booltrue{nobox}}
\DeclareOption{inline}{\booltrue{inline}}

% Pass other options go to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{notes}}

% Process options
\ProcessOptions \relax

% This extends the base article class
\LoadClassWithOptions{notes}

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
        \parbox{\textwidth}{\centering\sffamily
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
    {\sffamily\bfseries\ifbool{inline}{\normalsize}{\large}\@problemstr\ \refstepcounter{problem}\theproblem\ifstrempty{#1}{}{\label{pr:#1}}%
     \ifstrempty{#2}{}{ (#2)}}%
    \setlength{\tskip}{1em-\parskip}\ifbool{inline}{\hskip 1em}{\vskip \tskip}
}

% Custom solutions
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

% Optional problem
\RequirePackage[letterspace=125]{microtype}

\newcommand{\optional}[1][OPTIONAL]{\marginpar{\flushright \tcbox[sharp corners, colback=white, size=fbox, fontupper=\sffamily\scshape\lsstyle, baseline=3.4pt, boxrule=0.4pt]{#1}}}