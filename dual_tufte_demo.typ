#import "src/lib.typ": tufte, sidenote

#show: tufte.with(
  title: [Untitled],
  author: "Author",
  date: datetime.today(),
  bib: bibliography("refs.bib"),
)

= Introduction

This paragraph uses #sidenote[A short note in the margin.] and cites @tufte2001.
