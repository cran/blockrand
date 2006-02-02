\name{plot.blockrand}
\alias{plot.blockrand}

\title{ Create a pdf file of randomization cards }
\description{
  Creates a pdf file of randomization cards based on the output from
  \code{blockrand}.  This file can then be printed and the cards put into
  envelopes for use by a study coordinator for assigning subjects to treatment.
}
\usage{
plot.blockrand(x, file = "blockrand.pdf", top, middle, bottom, width =
11, height = 8.5, par.args, id.col = "id", stratum.col = "stratum",
treat.col = "treatment", cut.marks = FALSE, top.ho, top.vo, middle.ho,
middle.vo, bottom.ho, bottom.vo, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{ A data frame, usually the output from \code{blockrand} }
  \item{file}{ The name of the pdf file to create (include the .pdf in
    the name) }
  \item{top}{ A character vector or list (see details) with the template
  to be printed at the top of each card}
  \item{middle}{ A character vector or list (see details) with the
    template to be printed in the middle of each card (positioned to be
    visible through the window of an envelope) }
  \item{bottom}{ A single character string to be printed at the bottom
    of each card }
  \item{width}{ Passed to \code{pdf} }
  \item{height}{ Passed to \code{pdf} }
  \item{par.args}{ A list containing additional arguments to \code{par}
    before plotting the text }
  \item{id.col}{ Name or number of the column in \code{x} that contains
    the id's of the subjects }
  \item{stratum.col}{ Name or number of the column in \code{x} that
    contains the names of the strata }
  \item{treat.col}{ Name or number of the column in \code{x} that
    contains the treatment assignments }
  \item{cut.marks}{ Logical, should cut marks be plotted as well (useful
    if printing on plain paper then cutting apart)}
  \item{top.ho}{Shift top text to the right(left)}
  \item{top.vo}{Shift top text up(down)}
  \item{middle.ho}{Shift middle text to the right(left)}
  \item{middle.vo}{Shift middle text up(down)}
  \item{bottom.ho}{Shift bottom text to the right(left)}
  \item{bottom.vo}{Shift bottom text up(down)}
  \item{\dots}{ Optional arguments passed to \code{pdf} }
}
\details{

  This function creates a pdf file with randomization "cards".  It puts
  4 cards per page.  You can either print the file onto perforated cards
  (Avery 8387) or onto regular paper then cut the cards apart.  The top
  of each card can then be folded over (extra protection from someone
  trying to read the upcoming treatments) and the card placed in an
  envelope (letter size) with a window and sealed.  The envelopes are
  then used by a study coordinator to assign subjects to treatments as
  they are enrolled into the trial.

  Each card is split into 3 parts, top, middle, and bottom.

  The top
  part is printed flush left and is the part that will be folded over
  for better security.  Information on the treatment assignment goes
  here along with any other information you want.

  The middle part is printed centered so that it will appear through the
  window of the envelope.  The subject ID number and stratification
  information should go here.

  The bottom part is limited to a single line that will be printed flush
  right at the bottom of the card.  This can be used for additional
  instructions to the study coordinator (e.g. call the statistician at
  123-4567 to record assignment).

  The \code{top}, \code{middle}, and \code{bottom} templates can be
vectors or lists.  If the vectors
  have length greater than 1, then each element of the vector will be
  printed on a separate line (if there are 3 elements in \code{top} then
  there will be 3 lines at the top, etc.), \code{bottom} should only
  have a single element.  If \code{top}, \code{middle}, or \code{bottom}
  are lists then they should have an element named "text"
  that consists of a character vector containing the template.  The
  lists can then also have optional elements named "font" and "col",
  these vectors should be the same length as the "text" vector and
  represent the fonts and colors to use for the corresponding lines of
  text (for example if \code{font} is \code{c(1,2,1)} then the 2nd line
  will be printed bold).

  If the template in \code{top} or \code{middle} contains "\%ID\%" (not
  including the quotes, but including the percent signs) then this
  string will be replaced with the contents of the ID column for each
  card.  If they contain "\%STRAT\%" then it will be replaced with the
  contents of the stratum column.  If \code{top} contains "\%TREAT\%" then
  it will be replaced with the contents of the treatment column (note
  that this is not available in the \code{middle} template).

  If any of the arguments \code{top}, \code{middle}, or \code{bottom}
  are missing then the function will look for a list named
  "blockrand.text" and will look for the corresponding elements of that
  list to use as the template.  If the list does not exist, or the list
  does not have a corresponding element, then that portion of the card
  will be blank.  Specifying the argument when calling the function will
  override the "blockrand.text" list.

  The arguments \code{top.ho}, \code{middle.ho}, and \code{bottom.ho}
  move the corresponding parts to the right (left if negative).  The
  units are approximately \code{strwidth("W")} so specifying a value of
  \code{0.5} will move the section about half a character to the right.
  The arguments
  \code{top.vo}, \code{middle.vo}, and \code{bottom.vo} move the
  corresponding parts up (down if negative).  The units are approximately
  \code{1.5*strheight("Wj")}.

  If any of the offset arguments are not specified then the
  corresponding element of the list "blockrand.text" is used if it
  exists otherwise they are 0.

  The idea of the "blockrand.text" list is to set common defaults for
  your system (the default positions work for me, but you may want to
  tweak things for your system) including templates that are commonly
  used in your institution.  Individual pieces can then be overridden
  with the function arguments.
}
\note{
  Adobe Acrobat (and possibly other pdf viewers) will often try to
  rescale the page when printing, for best results turn this feature off
  before printing.
  }
\value{
This function does not return anything useful, it is run for the side
effect of creating a pdf file.  The pdf file will have 4 cards per page
and 1 card for each line of \code{x}.
}
\author{Greg Snow \email{greg.snow@imail.org }}
\examples{
## stratified by sex, 100 in stratum, 2 treatments
male <- blockrand(n=100, id.prefix='M', block.prefix='M',stratum='Male')
female <- blockrand(n=100, id.prefix='F', block.prefix='F',stratum='Female')

my.study <- rbind(male,female)

\dontrun{
plot.blockrand(my.study,'mystudy.pdf',
   top=list(text=c('My Study','Patient: \%ID\%','Treatment: \%TREAT\%'),
            col=c('black','black','red'),font=c(1,1,4)),
   middle=list(text=c("My Study","Sex: \%STRAT\%","Patient: \%ID\%"),
               col=c('black','blue','green'),font=c(1,2,3)),
   bottom="Call 123-4567 to report patient entry",
   cut.marks=TRUE)

### or

blockrand.txt <- list(
   top=list(text=c('My Study','Patient: \%ID\%','Treatment: \%TREAT\%'),
            col=c('black','black','red'),font=c(1,1,4)),
   middle=list(text=c("My Study","Sex: \%STRAT\%","Patient: \%ID\%"),
               col=c('black','blue','green'),font=c(1,2,3)),
   bottom="Call 123-4567 to report patient entry")

plot.blockrand(my.study, 'mystudy.pdf', cut.marks=TRUE)
}
}
\keyword{ design }% at least one, from doc/KEYWORDS
\keyword{ datagen }% __ONLY ONE__ keyword per line
