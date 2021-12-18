% -*- root: nenga.tex -*-
%%
%% Copyright (c) 2021 Arseny Tolmachev
%% Based on https://github.com/ueokande/jletteraddress
%% Copyright (c) 2014 Shin'ya Ueoka <ibenza@i-beam.org>
%%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{jlpostcard}

\LoadClass[]{article}

\def\nenga@true{1}
\def\nenga@debug{\nenga@true}
\DeclareOption{release}{\gdef\nenga@debug{0}}
\ProcessOptions\relax

\RequirePackage{luatexja-fontspec}
\RequirePackage{graphicx}
\RequirePackage{lltjext}
\RequirePackage{xstring}

%% Sender macros
\def\sendername#1{\gdef\nenga@sendername{#1}}
\def\senderpostcode#1{\gdef\nenga@senderpostcode{#1}}
\def\senderaddressa#1{\gdef\nenga@senderaddressa{#1}}
\def\senderaddressb#1{\gdef\nenga@senderaddressb{#1}}

%% Layouts
\setlength{\hoffset}{-1truein}
\setlength{\voffset}{-1truein}
\setlength{\oddsidemargin}{0pt}
\setlength{\evensidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\headheight}{0pt}
\setlength{\headsep}{0pt}
\setlength{\paperwidth}{100mm}
\setlength{\paperheight}{148mm}

\setlength{\tabcolsep}{0pt}
\setlength\tabbingsep{0pt}
\setlength{\unitlength}{1mm}

\newsavebox{\nenga@data}
% #1 : Receiver name    
% #2 : Receiver postcode
% #3 : Receiver address 1
% #4 : Receiver address 2
\newcommand{\addaddress}[4] {
  \clearpage
  \refstepcounter{section}
  \addcontentsline{toc}{section}{#1}
  \noindent %
  \parindent0pt
  \begin{picture}(100,148)(0,0)%
    \if\nenga@debug\nenga@true\put(0,0){\includegraphics[width=100mm,height=148mm]{images/empty-address-2021.jpg}}\else\fi
    %\put(0,0){\includegraphics[width=100mm,height=148mm]{images/empty-address-2021.jpg}}
    \put(43,130){%
      \fontsize{9mm}{0pt}\selectfont%
      \makebox[7.1mm][c]{\StrChar{#2}{1}}%
      \makebox[7.1mm][c]{\StrChar{#2}{2}}%
      \makebox[7.1mm][c]{\StrChar{#2}{3}}\hskip0.8mm%
      \makebox[6.8mm][c]{\StrChar{#2}{4}}%
      \makebox[6.8mm][c]{\StrChar{#2}{5}}%
      \makebox[6.8mm][c]{\StrChar{#2}{6}}%
      \makebox[6.8mm][c]{\StrChar{#2}{7}}%
    }
    % address line 1
    \savebox{\nenga@data}{\fontsize{15pt}{0pt}\selectfont\tate#3}
    \put(83,\dimexpr122mm-\ltjgetht\nenga@data){\box\nenga@data}
    % address line 2
    \savebox{\nenga@data}{\fontsize{15pt}{0pt}\selectfont\tate#4}
    \put(75,\dimexpr122mm-\ltjgetht\nenga@data){\box\nenga@data}
    % names
    \put(35,119){
      \begin{minipage}<t>[t][3cm]{8cm}
      \fontsize{20pt}{0pt}\selectfont
    \setlength\tabcolsep{1mm}
    \begin{tabular}{lll}%
    #1
    \end{tabular}%
    \end{minipage}%
    }%
    % postal code of sender
    \put(3.2,20.5){ %
      \fontsize{6mm}{0pt}\selectfont%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{1}}%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{2}}%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{3}}\hskip1.1mm%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{4}}%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{5}}%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{6}}%
      \makebox[4mm][c]{\StrChar{\nenga@senderpostcode}{7}}%
    }
    % sender information
    \savebox{\nenga@data}{\fontsize{12pt}{0pt}\selectfont\tate\nenga@senderaddressa}
    \put(25,\dimexpr89mm-\ltjgetht\nenga@data){\box\nenga@data}
    \savebox{\nenga@data}{\fontsize{12pt}{0pt}\selectfont\tate\nenga@senderaddressb}
    \put(18,\dimexpr89mm-\ltjgetht\nenga@data){\box\nenga@data}
    \put(4,76){
      \begin{minipage}<t>[t][1cm]{5cm}
      \fontsize{12pt}{0pt}\selectfont
    \setlength\tabcolsep{1mm}
    \hfill
    \begin{tabular}{ll}%
    \nenga@sendername
    \end{tabular}%
    \end{minipage}%
    }%
  \end{picture}
}