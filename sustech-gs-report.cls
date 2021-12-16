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
\DeclareStringOption[auto]{system}[auto]
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

\newif\ifsustech@auto
\newif\ifsustech@windows
\newif\ifsustech@mac
\newif\ifsustech@unix
\sustech@validate@key{system}

\LoadClass[openany,UTF8,zihao=-4]{ctexbook}

\RequirePackage[a4paper,text={160true mm,234true mm},top=30.5true mm,left=25true mm,head=5true mm,headsep=2.5true mm,foot=8.5true mm]{geometry}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{amsmath}
\RequirePackage{amsthm}
\RequirePackage{amssymb}
\RequirePackage{amsfonts}
\RequirePackage{bm}

% 如果使用 {unicode-math} 需要禁用 {amsfonts}, {bm}, {amssymb}
% \RequirePackage[math-style=ISO, bold-style=ISO]{unicode-math}
% \IfFontExistsTF{XITSMath-Regular.otf}{
%   \setmathfont[
%     Extension    = .otf,
%     BoldFont     = XITSMath-Bold,
%     StylisticSet = 8,
%   ]{XITSMath-Regular}
%   \setmathfont[range={cal,bfcal},StylisticSet=1]{XITSMath-Regular.otf}
% }{
%   \setmathfont[
%     Extension    = .otf,
%     BoldFont     = *bold,
%     StylisticSet = 8,
%   ]{xits-math}
%   \setmathfont[range={cal,bfcal},StylisticSet=1]{xits-math.otf}
% }
% \DeclareRobustCommand\bm[1]{{\symbf{#1}}}
% \DeclareRobustCommand\boldsymbol[1]{{\symbf{#1}}}

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
\RequirePackage{xparse}

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

\RequirePackage{listofitems}
\RequirePackage{xeCJKfntef}

\newcommand{\ulbox}[2][2em]{%
  \CJKunderline[thickness=1pt]{\makebox[#1]{#2}}%
}

\NewDocumentCommand\sustech@info@item{s o m o m}{%
  {
    \renewcommand\arraystretch{1.3} % 应该只是对可能会换行的英文 item 生效。
    \bfseries
    \IfValueTF{#2}
    {\begin{tabular}[t]{@{}l@{}}\makebox[#2][s]{#3}\end{tabular}}
    {\begin{tabular}[t]{@{}l@{}}#3\end{tabular}}
  } & %
  {
    \renewcommand\arraystretch{1.3} % 应该只是对可能会换行的英文 item 生效。
    \bfseries
    \IfBooleanTF{#1}
    {%有星号
      \IfValueTF{#4}
      {\sustech@info@multiline[#4]{#5}}
      {\sustech@info@multiline[15em]{#5}}
    }
    {%没星号
      \IfValueTF{#4}
      {\sustech@info@singleline[#4]{#5}}
      {\sustech@info@singleline[15em]{#5}}
    }
  }
}

\newcommand{\sustech@info@singleline}[2][2em]{
  \begin{tabular}[t]{@{}l@{}}\ulbox[#1]{#2}\end{tabular}
}

\newcommand{\sustech@info@multiline}[2][2em]{
  \setsepchar{\\}%
  \readlist\tmp@list#2%
  \def\e@tmp@list{}%
  \foreachitem\y\in\tmp@list[]{%
    \listeadd{\e@tmp@list}{\y}%
  }%
  \renewcommand*{\do}[1]{\ulbox[#1]{##1}\\}%
  \begin{tabular}[t]{@{}l@{}}%
    \dolistloop{\e@tmp@list}
  \end{tabular}
}

\newcommand\makecover{%
  \pagenumbering{Roman}%
  \ifsustech@chinese
    % Chinese
    \begingroup
      \thispagestyle{empty}
      \centering
      \vspace*{10mm}
      {
        \zihao{-2} \kaishu \bfseries %
        \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}%
        南方科技大学 \par
      }

      \vspace{10mm}
      {
        \zihao{2} \songti \bfseries%
        \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}%
        \report@name \par
      }

      \vspace{30pt}
      \parbox[t]{30em}{
        \centering
        \zihao{-2} \songti \bfseries%
        题~目：\sustech@title}
      \par

      \vspace*{30pt}
      {\zihao{3} \songti
        \begin{tabular}{l@{}l}
          \sustech@info@item*[6em]{院（系）}[10em]{\sustech@department}\\
          \sustech@info@item*[6em]{学科}[10em]{\sustech@discipline}\\
          \sustech@info@item*[6em]{导师}[10em]{\sustech@supervisor}\\
          \sustech@info@item[6em]{研究生}[10em]{\sustech@author}\\
          \sustech@info@item[6em]{学号}[10em]{\sustech@student@id}\\
          \sustech@info@item[6em]{\date@name}[10em]{\sustech@date}
        \end{tabular}
      }\par
      \vfill

      {
        \zihao{3} \songti \bfseries 研究生院制 \par
      }
    \endgroup
  \else%
    % English
    \begingroup
      \thispagestyle{empty}
      \centering
      \vspace*{10mm}
      {
        \zihao{2} \bfseries %
        \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}%
        Southern University of Science and Technology \par
      }

      \vspace{10mm}
      {
        \zihao{2} \bfseries%
        \renewcommand{\CJKglue}{\hskip 2pt plus 0.08\baselineskip}%
        \report@name@en \par
      }

      \vspace{30pt}
      \parbox[t]{30em}{
        \centering
        \zihao{-2} \bfseries%
        Title：\sustech@title}
      \par

      \vspace*{30pt}
      {\zihao{3}
        \begin{tabular}{l@{}l}
          \sustech@info@item*{Department}[16em]{\sustech@department}\\
          \sustech@info@item*{Discipline}[16em]{\sustech@discipline}\\
          \sustech@info@item*{Supervisor}[16em]{\sustech@supervisor}\\
          \sustech@info@item{Student Name}[16em]{\sustech@author}\\
          \sustech@info@item{Student Number}[16em]{\sustech@student@id}\\
          \sustech@info@item{\date@name@en}[16em]{\sustech@date}
        \end{tabular}
      }\par
      \vfill

      {
        \zihao{3} \bfseries Graduate School \par
      }
    \endgroup
  \fi
  \clearpage
  \setcounter{page}{1}
}


% kvvalue 定义个人信息选项
\RequirePackage{xkeyval}
\RequirePackage{etoolbox}
\newcommand\reportsetup[1]{%
  \setkeys{sustech}{#1}}

\define@key{sustech}{title}{\def\sustech@title{#1}}
\define@key{sustech}{author}{\def\sustech@author{#1}}
\define@key{sustech}{student-id}{\def\sustech@student@id{#1}}
\define@key{sustech}{supervisor}{\def\sustech@supervisor{#1}}
\define@key{sustech}{date}{\def\sustech@date{#1}}
\define@key{sustech}{department}{\def\sustech@department{#1}}
\define@key{sustech}{discipline}{\def\sustech@discipline{#1}}
\define@key{sustech}{system}{\def\sustech@system{#1}}
\define@choicekey{sustech}{bibliography-toc-style}{nonserial,none}[nonserial]{%
  \def\sustech@bib@toc@style{#1}
}
\ifundef{\sustech@bib@toc@style}{\reportsetup{bibliography-toc-style}}

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
\ctexset{chapter={name={,},number={}}}
\arraycolsep=1.7pt
\setcounter{secnumdepth}{4} % 限制目录深度
% 章节样式
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
% 列表环境的布局
\setitemize{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=-0em}
\setenumerate{leftmargin=3em,itemsep=0em,partopsep=0em,parsep=0em,topsep=0em}
% 图表编号、样式
\renewcommand{\theequation}{\arabic{equation}}
\renewcommand{\thetable}{\arabic{table}}
\captionsetup{labelsep=space,font=small,justification=centering}
\renewcommand{\thefigure}{\arabic{figure}}
\renewcommand{\thesubfigure}{\alph{subfigure})}
\renewcommand{\subcapsize}{\zihao{5}}
\renewcommand{\p@subfigure}{\thefigure~}
\setlength{\subfigbottomskip}{0pt}


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

\RequirePackage{fontspec}
\ifsustech@auto
  \IfFileExists{/System/Library/Fonts/Menlo.ttc}{
    \reportsetup{system = mac}
  }{
    \IfFileExists{/dev/null}{
      \IfFileExists{null:}{
        \reportsetup{system = windows}
      }{
        \reportsetup{system = unix}
      }
    }{
      \reportsetup{system = windows}
    }
  }
\fi

\newcommand\load@font@times{%
  \setmainfont{Times New Roman}%
  \setsansfont{Arial}%
  \ifthenelse{\equal{\sustech@system}{mac}}{
    \setmonofont{Menlo}[Scale = MatchLowercase]%
  }
  {
    \setmonofont{Courier New}[Scale = MatchLowercase]%
  }
}
\newcommand\load@font@termes{%
  \setmainfont{texgyretermes}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \load@texgyre@sans@mono
}
\newcommand\load@texgyre@sans@mono{%
  \setsansfont{texgyreheros}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
  ]%
  \setmonofont{texgyrecursor}[
    Extension      = .otf,
    UprightFont    = *-regular,
    BoldFont       = *-bold,
    ItalicFont     = *-italic,
    BoldItalicFont = *-bolditalic,
    Ligatures      = CommonOff,
  ]%
}
\ifthenelse{\equal{\sustech@system}{unix}}{
    \load@font@termes
  }
  {
    \load@font@times
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
  \newcommand{\bib@nonserial}{nonserial} % 在目录中不标注序号
  \newcommand{\bib@none}{none} % 不在目录中显示
  \ifthenelse{\equal{\sustech@bib@toc@style}{\bib@nonserial}}{
    \renewcommand\bibsection{
      \phantomsection
      \addcontentsline{toc}{section}{\bibname}
      \chapter*{\bibname}
    }
  }{}
  \ifthenelse{\equal{\sustech@bib@toc@style}{\bib@none}}{
    \renewcommand\bibsection{
      \phantomsection
      \pdfbookmark[1]{\bibname}{reference}
      \chapter*{\bibname}
    }
  }{}
}
