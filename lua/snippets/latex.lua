local ls, s, t, i, extras, rep, fmt, c, f, d, sn = unpack(require('snippets._snip-init'))

ls.add_snippets('tex', {
  s('beg', {
    t('\\begin{'),
    i(1),
    t('}'),
    t({ '', '\t' }),
    i(0),
    t({ '', '\\end{' }),
    rep(1),
    t('}'),
  }),

  s(
    'talk',
    fmt(
      [[
        \documentclass{{article}}
        \usepackage{{sectsty}}
        \usepackage{{titlesec}}
        \usepackage{{geometry}}
        \usepackage{{soul}}
        \usepackage{{xcolor}}
        \usepackage{{framed}}
        \allsectionsfont{{\centering}}
        \geometry{{paper=letterpaper,margin=54pt,includeheadfoot}}

        \author{{{}}}
        \title{{\vspace{{-2.0cm}}\textbf{{\textit{{{}}}}}}}
        \titlespacing*{{\section}}{{0cm}}{{-0.0cm}}{{0cm}}
        \date{{\ul{{{}| {}}}}}

        % When I have a scripture that I am going to read I highlight and italicize it.
        % After a scripture I add a line to break things up.
        % After saying I am going to read a scripture or put up and image I
        % put \dots{{}} at the end of the sentence.
        % I bold lists.
        % I bold things I want to highlight in speech and if then I want to
        % further highlight I underline as well.
        % For every section in the talk I add a section in the document. The
        % section must contain the time limit.
        % I bold quotes.
        % If I quote a scripture I only underline the scripture itself, but I
        % will still follow my own rules about bolding quotes.
        % For scriptures that trigger images I highlight and bold. Careful
        % now that I have the new information from Dashille.
        % Add thing like (Here I put on the picture) in the document for my
        % own reference when using and taking off images and then a line.
        % They are bolded and centered.
        % Bold the line I use to put on an image and the line I use to take
        % off an image.
        % Every section must start on a new page.
        % I use enumerate or itemize for lists of stuff.
        % \centerline{{\rule{{5.5in}}{{0.4pt}}}} \bigbreak{{}} \hl{{}} \ul{{}} \textbf{{}}
        % \textit{{}} \section{{}} \dots{{}}
        % \begin{{center}}
        % \end{{center}}
        % \begin{{itemize}}
        % \end{{itemize}}
        % \begin{{enumerate}}
        % \end{{enumerate}}
        % \begin{{framed}}
        % \end{{framed}}
        % \sethlcolor{{red, green, blue, cyan, magenta, yellow, black, gray,
        % white, darkgray, lightgray, brown, lime, olive, orange, pink,
        % purple, teal, violet}}

        \begin{{document}}

        \maketitle

        \section{{{}}}

        \begin{{Large}}

        \end{{Large}}

        \end{{document}}
      ]],
      {
        i(1, 'Elías Valdés'), -- \author
        i(2, 'Title'), -- \author
        i(3, 'Version 0.0'), -- \date first
        f(function() -- \date second (current date)
          return os.date('%Y-%m-%d')
        end, {}),
        i(4, 'Section Title'), -- \section
      }
    )
  ),
})
