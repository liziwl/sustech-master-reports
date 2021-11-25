%% Copyright (C) 2020-2021 by Ziqiang Li <leezisy AT gmail.com>
%%
%% This file may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%    https://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
\NeedsTeXFormat{LaTeX2e}[1999/12/01]
\ProvidesClass{sustech-gs-report}
  [2019/12/08 v1.0 SUSTech Thesis Template]
\RequirePackage{ifxetex,ifluatex,ifthen}
  \ifthenelse{\boolean{xetex}\OR\boolean{luatex}}{}{
    \ClassError{sustech-gs-report}{You Should Use XeLaTeX or LuaLaTeX To Compile.}}

\hyphenation{SUSTech-gs-report}
\newcommand{\sustechgsreport}{sustech-gs-report}
\newcommand{\version}{1.0}
\RequirePackage{kvoptions}
\SetupKeyvalOptions{
  family=sustech,
  prefix=sustech@,
  setkeys=\kvsetkeys}
\DeclareStringOption[master]{degree}[master]
\DeclareStringOption[chinese]{language}[chinese]
\DeclareStringOption[proposal]{type}[proposal]
\DeclareStringOption[none]{fontsets}[none]
\DeclareDefaultOption{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessKeyvalOptions*
\newcommand\sustech@validate@key[1]{%
  \@ifundefined{sustech@\csname sustech@#1\endcsname true}{%
    \ClassError{\sustechgsreport}{Invalid value '\csname sustech@#1\endcsname'}{}%
  }{%
    \csname sustech@\csname sustech@#1\endcsname true\endcsname
  }%
}
\newif\ifsustech@master
\newif\ifsustech@doctor
\sustech@validate@key{degree}

\newif\ifsustech@chinese
\newif\ifsustech@english
\sustech@validate@key{language}

\newif\ifsustech@proposal
\newif\ifsustech@progress
\sustech@validate@key{type}

\newif\ifsustech@external
\newif\ifsustech@none
\sustech@validate@key{fontsets}

\LoadClass[openany,UTF8,zihao=-4]{ctexbook}

\RequirePackage[a4paper,text={160true mm,234true mm},top=30.5true mm,left=25true mm,head=5true mm,headsep=2.5true mm,foot=8.5true mm]{geometry}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{amsthm}
\RequirePackage{amsmath}
\RequirePackage{amsfonts}
\RequirePackage{amssymb}
\RequirePackage{txfonts}
\RequirePackage{bm}
\RequirePackage{graphicx}
\RequirePackage{enumitem}
\RequirePackage{fancyhdr}
\RequirePackage{titlesec}
\RequirePackage{subfigure}
\RequirePackage{url}
%% Hyperref，如不需要PDF书签（目录），bookmarks的值改为 false
\RequirePackage[breaklinks,hidelinks,hypertexnames=true,bookmarks=true,bookmarksopen=true,bookmarksnumbered=true]{hyperref}
%% 固定宽度的表格。放在 hyperref 之前的话，tabularx 里的 footnote 显示不出来。
\RequirePackage{tabularx}
\RequirePackage{longtable}
\RequirePackage{filehook}

\RequirePackage{fontspec}
\setmainfont{Times New Roman}
\setmonofont{Courier New}

\ifsustech@proposal
  \ifsustech@master
    \def\report@name@en{Master's Thesis Proposal}
    \def\report@name{硕士学位论文开题报告}
  \else
    \def\report@name@en{Doctor's Thesis Proposal}
    \def\report@name{博士学位论文开题报告}
  \fi
  \def\date@name@en{Date of Proposal Report}
  \def\date@name{开题报告日期}
\else
  \ifsustech@master
    \def\report@name@en{Study Progress Report of Master's Students}
    \def\report@name{硕士研究生年度考核报告}
  \else
    \def\report@name@en{Study Progress Report of Doctor's Students}
    \def\report@name{博士研究生年度考核报告}
  \fi
  \def\date@name@en{Submission Date}
  \def\date@name{年度考核日期}
\fi

\newcommand\makecover{%
  \pagenumbering{Roman}%
  \ifsustech@chinese
    % Chinese
    \thispagestyle{empty}
    \zihao{-2}\vspace*{10mm}
    \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}
    \centerline{\kaishu\textbf{南方科技大学}}

    \vspace{10mm}
    \centerline{\zihao{2}\songti\textbf{\report@name}}

    \renewcommand{\CJKglue}{\hskip 0pt plus 0.08\baselineskip}
    \vspace{30pt}
    \zihao{-2}
    \begin{center}\songti\textbf{题~目：\sustech@title}\end{center}
    \vspace{30pt}
    \zihao{3}
    \hspace*{68pt}{\songti
    \renewcommand{\arraystretch}{1.3}
    \begin{tabular}{l@{}l}
    \textbf{院\hfill （系）}   & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@affil}\\
    \textbf{学\hfill 科}     & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@subject}\\
    \textbf{导\hfill 师}     & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@supervisor}\\
    \textbf{研\hfill 究\hfill 生}      & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@author}\\
    \textbf{学\hfill 号}  & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@stuno}\\
    \textbf{\date@name} & \rule[-4pt]{200pt}{1pt}\hspace{-326pt}\centerline{\textbf\sustech@date}\\
    \end{tabular}
    \renewcommand{\arraystretch}{1}}
    \vfill
    \centerline{\songti\textbf{研究生院制}}
  \else%
    % English
    \thispagestyle{empty}
    \zihao{-2}\vspace*{10mm}
    \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}
    \centerline{\zihao{2}\textbf{Southern University of Science and Technology}}

    \vspace{10mm}
    \centerline{\zihao{2}\textbf{\report@name@en}}

    \renewcommand{\CJKglue}{\hskip 0pt plus 0.08\baselineskip}
    \vspace{30pt}
    \zihao{-2}
    \begin{center}\textbf{Title：\sustech@title}\end{center}
    \vspace{30pt}
    \zihao{3}
    \hspace*{30pt}{\songti
    \renewcommand{\arraystretch}{1.3}
    \begin{tabular}{l@{}l}
    \textbf{Department}   & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@affil}\\
    \textbf{Discipline}     & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@subject}\\
    \textbf{Supervisor}     & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@supervisor}\\
    \textbf{Student Name}      & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@author}\\
    \textbf{Student Number}  & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@stuno}\\
    \textbf{\date@name@en} & \rule[-4pt]{250pt}{1pt}\hspace{-352pt}\centerline{\textbf\sustech@date}\\
    \end{tabular}
    \renewcommand{\arraystretch}{1}}
    \vfill
    \centerline{\songti\textbf{Graduate School}}
  \fi
  \clearpage
  \setcounter{page}{1}
}


% kvvalue 定义个人信息选项
\RequirePackage{xkeyval}
\newcommand\reportsetup[1]{%
  \setkeys{sustech}{#1}}

\define@key{sustech}{title}{\def\sustech@title{#1}}
\define@key{sustech}{author}{\def\sustech@author{#1}}
\define@key{sustech}{stuno}{\def\sustech@stuno{#1}}
\define@key{sustech}{supervisor}{\def\sustech@supervisor{#1}}
\define@key{sustech}{date}{\def\sustech@date{#1}}
\define@key{sustech}{affil}{\def\sustech@affil{#1}}
\define@key{sustech}{subject}{\def\sustech@subject{#1}}

\ifsustech@english
  % English
  \renewcommand{\contentsname}{Table of Contents}
  \renewcommand{\figurename}{Fig.}
  \renewcommand{\tablename}{Table}
  \renewcommand\thesubfigure{(\alph{subfigure})}
  \ctexset{bibname={Reference}}
  \newtheorem{definition}{Definition}
  \newtheorem{example}{Example}
  \newtheorem{algo}{Algorithm}
  \newtheorem{theorem}{Theorem}
  \newtheorem{axiom}{Axiom}
  \newtheorem{proposition}{Proposition}
  \newtheorem{lemma}{Lemma}
  \newtheorem{corollary}{Corollary}
  \newtheorem{remark}{Remark}
  \renewcommand{\proofname}{\bf Proof}
  \renewcommand{\qedsymbol}{$\blacksquare$} % 证毕符号改成黑色的正方形
\else
  % Chinese
  \ctexset{bibname={主要参考文献}}
  \def\equationautorefname{式}%
  \def\footnoteautorefname{脚注}%
  \def\itemautorefname{项}%
  \def\figureautorefname{图}%
  \def\tableautorefname{表}%
  \def\partautorefname{篇}%
  \def\appendixautorefname{附录}%
  \def\chapterautorefname{章}%
  \def\sectionautorefname{节}%
  \def\subsectionautorefname{小小节}%
  \def\paragraphautorefname{段落}%
  \def\subparagraphautorefname{子段落}%
  \def\FancyVerbLineautorefname{行}%
  \def\theoremautorefname{定理}%
  \newtheorem{definition}{\indent \heiti 定义}
  \newtheorem{example}{\indent \heiti 例}
  \newtheorem{algo}{\indent \heiti 算法}
  \newtheorem{theorem}{\indent \heiti 定理}
  \newtheorem{axiom}{\indent \heiti 公理}
  \newtheorem{proposition}{\indent \heiti 命题}
  \newtheorem{lemma}{\indent \heiti 引理}
  \newtheorem{corollary}{\indent \heiti 推论}
  \newtheorem{remark}{\indent \heiti 注解}
  \renewcommand{\proofname}{\indent \heiti 证明}
  \renewcommand{\qedsymbol}{$\blacksquare$} % 证毕符号改成黑色的正方形
\fi

% 减少 ref item 之间的行间距
\AtEndOfPackageFile*{gbt7714}{
  \addtolength{\bibsep}{-0.8em}
}

% 导入原来各种精细化配置
\setlength{\subfigbottomskip}{0pt}
\ctexset{chapter={name={,},number={}}}
\captionsetup{labelsep=space,font=small,justification=centering}
\arraycolsep=1.7pt
\renewcommand{\subcapsize}{\zihao{5}}
\renewcommand{\thesubfigure}{\alph{subfigure})}
\setcounter{secnumdepth}{4}
\newcommand{\pozhehao}{\raisebox{0.1em}{------}}
\titleformat{\chapter}{\center\zihao{-2}\heiti}{\chaptertitlename}{0.5em}{}
\titlespacing{\chapter}{0pt}{-4.5mm}{8mm}
\titleformat{\section}{\zihao{-3}\heiti}{\thesection}{0.5em}{}
\titlespacing{\section}{0pt}{4.5mm}{4.5mm}
\titleformat{\subsection}{\zihao{4}\heiti}{\thesubsection}{0.5em}{}
\titlespacing{\subsection}{0pt}{4mm}{4mm}
\titleformat{\subsubsection}{\zihao{-4}\heiti}{\thesubsubsection}{0.5em}{}
\titlespacing{\subsubsection}{0pt}{0pt}{0pt}
\renewcommand\thesection{\@arabic \c@section} % 前面不带 thechapter


\renewcommand{\CJKglue}{\hskip 0.56pt plus 0.08\baselineskip} %加大字间距，使每行33个字
\def\defaultfont{\renewcommand{\baselinestretch}{1.62}\normalsize\selectfont}
% 调整罗列环境的布局
\setitemize{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=-0em}
\setenumerate{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em}
\renewcommand{\theequation}{\arabic{equation}}
\renewcommand{\thetable}{\arabic{table}}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\p@subfigure}{\thefigure~}


% 定义页眉和页脚 使用fancyhdr 宏包
\pagestyle{fancyplain}
\renewcommand{\chaptermark}[1]{\relax}
\renewcommand{\sectionmark}[1]{\markright{#1}}
\fancyhf{}
\renewcommand{\headrulewidth}{0pt}
\ifsustech@master
  % \fancyhead[C]{\songti \zihao{-5} 南方科技大学硕士学位论文开题报告}
  \fancyfoot[C]{\zihao{-5} -~\thepage~-}
	% \renewcommand\bibsection{\section*{\centerline{\bibname}}
	% \markboth{南方科技大学硕士学位论文开题报告}{\bibname}}
\else
  % \fancyhead[CO]{\songti \zihao{-5}\rightmark}
  % \fancyhead[CE]{\songti \zihao{-5} 南方科技大学博士学位论文开题报告}%
  \fancyfoot[C]{\zihao{-5} -~\thepage~-}
	% \renewcommand\bibsection{\section*{\centerline{\bibname}}
	% \markboth{南方科技大学博士学位论文开题报告}{\bibname}}
\fi

\newcommand{\sustech@fontset}{
  \ifsustech@english
    % English
    \zihao{-4}\setlength{\baselineskip}{20bp}
  \else
    % Chinese
    \zihao{-4}\setlength{\baselineskip}{20bp}
  \fi
}

\renewcommand\frontmatter{%
  % \cleardoublepage
  % \@mainmatterfalse
  \sustech@fontset
  \pagenumbering{Roman}%
}

\newcommand{\sustech@mainpageset}{
  \thispagestyle{empty}
  \clearpage{\pagestyle{empty}}
  \setcounter{page}{1}
}

\renewcommand\mainmatter{%
  \sustech@mainpageset
  % \cleardoublepage
  % \@mainmattertrue
  \sustech@fontset
  \pagenumbering{arabic}%
}

\renewcommand\backmatter{%
  \clearpage
  % \@mainmatterfalse
}

\newcommand\load@cjk@font@none{
  \xeCJKsetup{EmboldenFactor=3.17}%
}

\newcommand\load@cjk@font@external{%
  \xeCJKsetup{EmboldenFactor=3.17}%
  \setCJKmainfont[
    AutoFakeBold = true,
    Path = "fonts/",
    ItalicFont   = SimKai.ttf,
  ]{SimSun.ttc}%
  \setCJKsansfont[Path = "fonts/",AutoFakeBold]{SimHei.ttf}%
  \setCJKmonofont[Path = "fonts/",AutoFakeBold]{SimFang.ttf}%
  \setCJKfamilyfont{zhsong}[Path = "fonts/",AutoFakeBold]{SimSun.ttc}%
  \setCJKfamilyfont{zhhei}[Path = "fonts/",AutoFakeBold]{SimHei.ttf}%
  \setCJKfamilyfont{zhkai}[Path = "fonts/",AutoFakeBold]{SimKai.ttf}%
  \setCJKfamilyfont{zhfs}[Path = "fonts/",AutoFakeBold]{SimFang.ttf}%
  \renewcommand\songti{\CJKfamily{zhsong}}
  \renewcommand\heiti{\CJKfamily{zhhei}}
  \renewcommand\kaishu{\CJKfamily{zhkai}}
  \renewcommand\fangsong{\CJKfamily{zhfs}}
}

\ifsustech@external
  \load@cjk@font@external
\else
  \load@cjk@font@none
\fi

\AtEndOfPackageFile*{hyperref}{
  \ifsustech@chinese
    \hypersetup{
      pdflang = zh-CN,
    }%
  \else
    \hypersetup{
      pdflang = en-US,
    }%
  \fi
  \AtBeginDocument{%
    \hypersetup{
      pdftitle    = \sustech@title,
      pdfauthor   = \sustech@author,
      pdfsubject  = \report@name,
    }%
  }
}

\let\tableofcontentsORIG\tableofcontents
\renewcommand\tableofcontents{
  \pdfbookmark[1]{\contentsname}{toc}
  \tableofcontentsORIG
}

\AtEndOfPackageFile*{natbib}{
  \renewcommand\bibsection{
    \phantomsection
    \chapter*{\bibname}
    \addcontentsline{toc}{section}{\bibname}
  }
}
