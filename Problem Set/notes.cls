\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{notes}[2019/06/01 Base class for (lecture) notes]

% Very useful packages
\RequirePackage{etoolbox,calc}

% Pass other options go to the article class
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}

% Process options
\ExecuteOptions{unicode} %For hyperref
\ProcessOptions \relax

% This extends the base article class
\LoadClassWithOptions{scrartcl}
\KOMAoptions{paper=letter, parskip=half-}

% Normal (not bold) font for title
\addtokomafont{title}{\mdseries}

% Use Bitstream Charter as main (serif) and FiraSans as sans
% and Source Code Pro as monospaced
\RequirePackage[charter,cal=cmcal]{mathdesign}
\RequirePackage[lining, scale=0.95]{FiraSans}
\usepackage{inconsolata}
\renewcommand{\scdefault}{sc} %fix sc

\RequirePackage[utf8x]{inputenc}
\RequirePackage[T1]{fontenc}

% Custom page length - here ALF is the length of the alphabet (AFTER loading fonts)
% Width is set clipped to (2*ALF, 3*ALF)
% Height is set to either 1 inch top, 1.5 inches bottom 
\RequirePackage{geometry}

\newcommand{\maxlen}[2]{\ifdimgreater{#1}{#2}{#1}{#2}}
\newcommand{\minlen}[2]{\ifdimless{#1}{#2}{#1}{#2}}
\newcommand{\alfabet}{abcdefghijklmnopqrstuvwxyz}
\newlength{\ALF}
\newlength{\tmp}

\newcommand{\recalcmargins}{
    \recalctypearea
    \settowidth{\ALF}{\alfabet}
    
    % Set width/height
    \geometry{
        width=\maxlen{2\ALF}{\minlen{3\ALF}{\textwidth}}, 
        height=\maxlen{0.7727\paperheight}{\paperheight-2.5in},
    }
    
    % Now margin par
    \setlength{\tmp}{\paperwidth-\textwidth}
    \setlength{\tmp}{0.5\tmp}
    \geometry{
        marginparwidth=\minlen{\tmp-2\marginparsep}{1in}
    }
}

\recalcmargins

% Put section number in margin
\newlength{\titleskip}
\setlength{\titleskip}{\marginparsep-0.5em}
\newlength{\ntitleskip}
\setlength{\ntitleskip}{-\titleskip}
\renewcommand\sectionlinesformat[4]{%
  \hspace{\ntitleskip}\makebox[0pt][r]{#3}\hspace{\titleskip}#4%
}

% No parindent
\setlength{\parindent}{0pt}

% Enumitem
\RequirePackage{enumitem}

% Footnotes at bottom, fix issue with asteriks and spacing
\RequirePackage[hang,bottom]{footmisc}
\DefineFNsymbolsTM*{custom}{%
    {\fontfamily{lmr}\selectfont\textasteriskcentered}{\fontfamily{lmr}\selectfont *}  
    \textdagger     \dagger
    \textdaggerdbl  \ddagger
    \textsection    \mathsection
    \textbardbl     \|%
    \textparagraph  \mathparagraph
}%
\setfnsymbol{custom}

% Fix footnote indent
\setlength{\footnotemargin}{1em}

% Math packages
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{IEEEtrantools}

% To load images
\RequirePackage{graphicx}

% For tables
\RequirePackage{booktabs}

% For showing code - set background color to grey!10 by default
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%       WARNING     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REMOVE THE outputdir OPTION WHEN USING THE TEMPLATE IN ITS OWN
% PACKAGE WHERE THE main.tex FILE IS IN THE ROOT PROJECT DIR
\RequirePackage[outputdir=..]{minted}
\setminted{breaklines=true,python3=true}
\usemintedstyle{friendly}

% Line numbers in tt font
\renewcommand{\theFancyVerbLine}{\ttfamily \scriptsize\arabic{FancyVerbLine}}

% Okay, put everything in a tcolorbox
\RequirePackage[most, minted]{tcolorbox}

\newtcblisting{tminted}[2][]{
    listing engine=minted, listing only, minted language = #2,
    colback=gray!10, frame empty, size=fbox, breakable, sharp corners, colframe=gray!10,
    minted options={autogobble, #1}
}

\newlength{\nparskip}
\setlength{\nparskip}{-\parskip}
%\newcommand{\tinputminted}[3][]{
%    \inputminted[#1]{#2}{#3}
%}

\newtcbinputlisting{tinputminted}[3][]{
    listing engine=minted, listing only, minted language = #2,
    size=fbox, breakable, colback=gray!10, sharp corners, colframe=gray!10,
    listing file={#3}, minted options={autogobble, #1}, 
}

% To get text width in inches
\RequirePackage{printlen}

% Hyperref
\AtEndPreamble{
    \RequirePackage{hyperref}
    \hypersetup{colorlinks=true, allcolors=mOrange}
}