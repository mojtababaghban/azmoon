\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{azmoon}[2017/12/27 version 0.1 by Mojtaba Baghban]

\def\azmoonversion{0.1}

\newif\if@printlinesep
\@printlineseptrue

\def\templ@te{fantasy}
\def\p@persize{a4paper}
\def\f@ntsize{11pt}
\def\he@dstatus{headonall}
\def\he@donall{headonall}
\def\he@donfirst{headonfirst}
\def\nohe@d{nohead}

\RequirePackage{pgfopts}

\pgfkeys{
	/azm/.cd,
	a4paper/.value forbidden,
	a4paper/.style={papersize=a4paper},
	a3paper/.value forbidden,
	a3paper/.style={papersize=a3paper},
	a5paper/.value forbidden,
	a5paper/.style={papersize=a5paper},
	papersize/.value required,
	papersize/.is choice,
		papersize/a3paper/.code={\def\p@persize{a3paper}},
		papersize/a4paper/.code={\def\p@persize{a4paper}},
		papersize/a5paper/.code={\def\p@persize{a5paper}},
	template/.value required,
	template/.store in=\templ@te,
	10pt/.value forbidden,
	10pt/.style={fontsize=10pt},
	11pt/.value forbidden,
	11pt/.style={fontsize=11pt},
	12pt/.value forbidden,
	12pt/.style={fontsize=12pt},
	fontsize/.value required,
	fontsize/.is choice,
		fontsize/10pt/.code={\def\f@ntsize{10pt}},
		fontsize/11pt/.code={\def\f@ntsize{11pt}},
		fontsize/12pt/.code={\def\f@ntsize{12pt}},
	headonall/.value forbidden,
	headonall/.style={headstatus=headonall},
	headonfirst/.value forbidden,
	headonfirst/.style={headstatus=headonfirst},
	nohead/.value forbidden,
	nohead/.style={headstatus=nohead},
	headstatus/.value required,
	headstatus/.is choice,
		headstatus/headonall/.code={\def\he@dstatus{headonall}},
		headstatus/headonfirst/.code={\def\he@dstatus{headonfirst}},
		headstatus/nohead/.code={\def\he@dstatus{nohead}},
}
\ProcessPgfOptions{/azm}

\LoadClass[\f@ntsize]{article}

\RequirePackage{amsmath}
\RequirePackage{cancel}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{totcount}
\RequirePackage{lastpage}
\RequirePackage{marginnote}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
%\RequirePackage{xecolor}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{geometry}
\RequirePackage{biditools}

\newcommand\printlinesep{\@printlineseptrue}
\newcommand\noprintlinesep{\@printlinesepfalse}

\newcommand\teacher@title{معلم}
\newcommand\teacher@name{}
\newcommand\student@name{}
\newcommand\answer@time{}
\newcommand\exam@date{}
\newcommand\@topic{}
\newcommand\@grade{}
\newcommand\@branch{}
\newcommand\school@title{مدرسه}
\newcommand\@school{}
\newcommand\@city{}
\newcommand{\hi@note}{}
\newcommand{\bye@note}{}
\newcommand{\answer@color}{blue}
\newcommand{\ques@color}{black}
\newcommand\examdate[1]{\renewcommand{\exam@date}{#1}}
\newcommand\hinote[1]{\renewcommand{\hi@note}{#1}}
\newcommand\byenote[1]{\renewcommand{\bye@note}{#1}}
\newcommand\topic[1]{\renewcommand{\@topic}{#1}}
\newcommand\grade[1]{\renewcommand{\@grade}{#1}}
\newcommand\branch[1]{\renewcommand{\@branch}{#1}}
\newcommand\schooltitle[1]{\renewcommand{\school@title}{#1}}
\newcommand\school[1]{\renewcommand{\@school}{#1}}
\newcommand\city[1]{\renewcommand{\@city}{#1}}
\newcommand\teacher[1]{\renewcommand{\teacher@name}{#1}}
\newcommand\teachertitle[1]{\renewcommand{\teacher@title}{#1}}
\newcommand\student[1]{\renewcommand{\student@name}{#1}}
\newcommand\answertime[1]{\renewcommand{\answer@time}{#1}}
\newcommand\answercolor[1]{\renewcommand{\answer@color}{#1}}
\newcommand\quescolor[1]{\renewcommand{\ques@color}{#1}}

\newif\ifanswermode
\answermodefalse

\newcommand{\printanswers}{\answermodetrue}
\newcommand{\noprintanswers}{\answermodefalse}

\newlength{\totalpoint}
\newlength{\sumpoint}
\setlength{\sumpoint}{0pt}
\newlength{\fheadheight}
\newlength{\leftmg}
\newlength{\rightmg}
\newlength{\topmg}
\newlength{\bottommg}
\newlength{\he@dsep}

\setlength\leftmg{1.5cm}
\setlength\rightmg{1.5cm}
\setlength\topmg{.5cm}
\setlength\bottommg{.5cm}
\setlength\he@dsep{0pt}

\def\headfootlength{}

\IfFileExists{\jobname.headfootlength}
{
	\input{\jobname.headfootlength}
}
{}
\ifcsname headleng1\endcsname
	\setlength\fheadheight{\csname headleng1\endcsname pt}
\else
	\setlength\fheadheight{0pt}
\fi
\IfFileExists{\templ@te tpl}{
	\input{\templ@te tpl}
}
{\ClassError{azmoon}{file \templ@te tpl.tex not exist}{}}
\geometry{\p@persize,top=\topmg,bottom=\bottommg,right=\rightmg,left=\leftmg,
	headsep=\he@dsep,headheight=\fheadheight,marginparsep=.2cm,
	marginparwidth=1.4cm,footskip=0pt,includehead,includefoot}

% Redefine \f@nch@vbox for auto height
\def\f@nch@vbox#1#2{%
	\setbox0\vbox{#2}%
	\ifdim\ht0=#1\else%
		\f@nch@warning{%
			\string#1 (\the#1) is not equal with \the\ht0.^^J
			Please compile again to correct this problem.%
		}%
	\fi%
	\ifx#1\headheight%
		\edef\eheadfootlength{%
			\string\expandafter\string\def\string\csname\space
			headleng\thepage \string\endcsname{\strip@pt\ht0}%
		}%
		\expandafter\g@addto@macro\expandafter\headfootlength\expandafter{%
			\eheadfootlength^^J%
		}%
		\bidi@AfterOutputPageShipOut{%
			\ifcsname headleng\the\numexpr\value{page}+1\relax\endcsname%
				\global\setlength{\headheight}{%
					\csname headleng\the\numexpr\value{page}+1\relax\endcsname pt%
				}%
			\else%
				\global\setlength{\headheight}{0pt}%
			\fi%
			\global\setlength{\textheight}{%
				\dimexpr\paperheight-1in-\voffset-\topmargin-\headheight-
				\headsep-\footskip-\bottommg\relax%
			}%
		}%
	\fi%
	\box0%
}
\newcommand{\truesym}{%
	\hspace{0cm}%
	\begin{tikzpicture}[baseline={([yshift=-.9ex]current bounding box.center)}]
	\draw[thick] (-.15,0) -- (0,-.15);
	\draw[thick] (0,-.15) -- (.3,.35);
	\end{tikzpicture}
}
\newcommand{\falsesym}{%
	\hspace{0cm}%
	\begin{tikzpicture}[baseline={([yshift=-.9ex]current bounding box.center)}]
	\draw[thick] (-.18,.18) -- (.18,-.18);
	\draw[thick] (.18,.18) -- (-.18,-.18);
	\end{tikzpicture}
}
\newtotcounter{numques}
\newenvironment{questions}{%
	\newcommand{\question}[2][\@nil]{%
		\def\@point{##1}%
		\def\ques@body{##2}%
		\ifx\@point\@nnil\else%
			\global\addtolength{\sumpoint}{##1pt}%
		\fi%
		\stepcounter{numques}%
		\ifcsname question@\templ@te\endcsname
			\csname question@\templ@te\endcsname{\thenumques}{\ques@body}{\@point}%
		\else%
			\ClassError{azmoon}{command \csname question@\templ@te\endcsname not defined}{}
		\fi%
	}%
	\renewcommand{\section}[1]{%
		\ifcsname section@\templ@te\endcsname%
			\csname section@\templ@te\endcsname{##1}%
		\else%
			\ClassError{azmoon}{command \csname section@\templ@te\endcsname not defined}{}%
		\fi%
	}%
	\newcommand{\answer}[2][0pt]{%
		{%
			\color{\answer@color}%
			\ifanswermode ##2\else\ifdim ##1=0pt\else%
			\vspace{##1}\fi\fi%
		}%
	}%
	\ifcsname bquestions@\templ@te\endcsname%
		\csname bquestions@\templ@te\endcsname%
	\fi%
}
{%
	\ifcsname equestions@\templ@te\endcsname%
		\csname equestions@\templ@te\endcsname%
	\fi%
}%
\newcommand{\tf}[1][]{
		\def\value{#1}%
		\def\truevalue{t}%
		\def\falsevalue{f}%
		\def\trueopacity{0}%
		\def\falseopacity{0}%
		\ifx\value\falsevalue\def\falseopacity{1}\fi
		\ifx\value\truevalue\def\trueopacity{1}\fi
		\hspace{0cm}%
		\begin{tikzpicture}[baseline={([yshift=-.7ex]current bounding box.center)}]
		\draw (0,0) circle (.25);
		\ifanswermode%
		\draw[very thick,color=\answer@color,opacity=\falseopacity] (-.18,.18) -- (.18,-.18);
		\draw[very thick,color=\answer@color,opacity=\falseopacity] (.18,.18) -- (-.18,-.18);
		\draw[very thick,color=\answer@color,opacity=\trueopacity] (-.15,0) -- (0,-.15);
		\draw[very thick,color=\answer@color,opacity=\trueopacity] (0,-.15) -- (.3,.35);
		\fi
		\end{tikzpicture}
	}%
\newcommand{\fillin}[2][2cm]{%
\ifanswermode{\color{\answer@color}#2}%
\else%
\rule{#1}{.5pt}%
\fi%
}%
\newcommand{\fillincirc}[2][.3cm]{%
	\begin{tikzpicture}[baseline={([yshift=-.9ex]current bounding box.center)}]
	\draw (0,0) circle (#1) node[pos=.5] {\ifanswermode \color{\answer@color} #2 \fi};
	\end{tikzpicture}%
}%
\newcounter{numparts}%
\newcounter{curpart}%
\newlength{\partlength}
\setlength{\partlength}{\linewidth}
\newenvironment{parts}[1][1]{%
	\newcommand{\num@cols}{#1}
	\newcommand{\numcols}[1]{%
		\renewcommand{\num@cols}{##1}%
		\setlength{\partlength}{\dimexpr \linewidth / \num@cols - .9cm\relax}%
	}
	\setlength{\partlength}{\dimexpr \linewidth / \num@cols - .9cm\relax}
%	\par
	\setcounter{numparts}{0}%
	\setcounter{curpart}{0}%
	\renewcommand{\part}[2][]{%
		\stepcounter{numparts}%
		\stepcounter{curpart}%
		\ifnum\num@cols>1%
			\begin{minipage}[t]{\partlength}%
				\item ##2%
			\end{minipage}%
		\else%
			\item {##2}%
		\fi%
		\ifnum\value{curpart}=\num@cols%
		\setcounter{curpart}{0}\par\else\hfill\fi
	}
	\begin{enumerate}[label=(\alph*),nosep,leftmargin=*]
	}
	{
	\end{enumerate}
}
\newcounter{numchoice}%
\newenvironment{fourchoice}[1][4]{%
	\newcommand{\@choice}[2][{}]{%
		\part{\tf[##1] ##2}%
	}
	\newcommand{\choice}[1]{%
		\@choice{##1}
	}
	\newcommand{\choiceok}[1]{%
	\@choice[t]{##1}
	}
	\begin{parts}[#1]
	}
	{%
	\end{parts}
}
\newenvironment{truefalse}[1][1]{%
	\newcommand{\itemt}[1]{%
		\part{\tf[t] ##1}
	}
	\newcommand{\itemf}[1]{%
		\part{\tf[f] ##1}
	}
	\begin{parts}[#1]
	}
	{%
	\end{parts}
}
\fancypagestyle{first}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0cm}
	\fancyhead[R]{%
		\ifcsname fheader@\templ@te\endcsname%
			\csname fheader@\templ@te\endcsname%
		\else%
			\ClassError{azmoon}{command \csname fheader@\templ@te\endcsname not defined}{}%
		\fi%
	}
	\ifcsname ffooter@\templ@te\endcsname%
		\fancyfoot[R]{%
			\csname ffooter@\templ@te\endcsname%
		}%
	\fi%
}
\fancypagestyle{mean}{%
	\fancyhf{}
	\renewcommand{\headrulewidth}{0cm}
	\fancyhead[R]{%
		\ifcsname mheader@\templ@te\endcsname%
			\csname mheader@\templ@te\endcsname%
		\else%
			\ClassError{azmoon}{command \csname mheader@\templ@te\endcsname not defined}{}%
		\fi%
	}
}
\ifx\he@dstatus\he@donall
	\pagestyle{mean}
	\thispagestyle{first}
\fi

\ifx\he@dstatus\he@donfirst
	\pagestyle{empty}
	\thispagestyle{first}
\fi

\ifx\he@dstatus\nohe@d
	\pagestyle{empty}
\fi

\linespread{1.5}
\setlength{\parindent}{0cm}

\AtEndDocument{%
	\if@filesw%
	\immediate\write\@auxout%
	{\string\global\string\setlength{\string \totalpoint}{\the\sumpoint}}%
	\begingroup
	% same write register as environment `filecontents` uses
	\chardef\reserved@c=15 %
	\immediate\openout\reserved@c=\jobname.headfootlength\relax
	\immediate\write\reserved@c{%
		\headfootlength%
	}%
	\immediate\closeout\reserved@c
	\endgroup
	\fi%
}
\newcommand\pvector[1]{%
	\renewcommand{\arraystretch}{.6666}
	\begin{bmatrix}
		#1
	\end{bmatrix}
}
\newcommand\strikeoutup[2][]{%
	\renewcommand{\arraystretch}{.1}
	\begin{tabular}[b]{@{}c@{}} 
		#1\\
		\cancel{#2}
	\end{tabular}
	\renewcommand{\arraystretch}{1}
}
\newcommand\strikeoutdown[2][]{%
	\renewcommand{\arraystretch}{.1}
	\begin{tabular}[t]{@{}c@{}} 
		\cancel{#2}\\
		#1
	\end{tabular}
	\renewcommand{\arraystretch}{1}
}
\newcommand{\strikeout}[2][]{\strikeoutup[#1]{#2}}
