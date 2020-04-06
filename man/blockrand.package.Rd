\name{blockrand-package}
\alias{blockrand-package}
\docType{package}
\title{
Generate block randomizations for clinical trials.
}
\description{
This package will create a block randomization for clinical trials and
help with creating the randomization cards that the study coordinator
can use to assign new subjects to their treatment.
}
\details{
\tabular{ll}{
Package: \tab blockrand\cr
Type: \tab Package\cr
Version: \tab 1.1\cr
Date: \tab 2008-02-02\cr
License: \tab Gnu Public License Ver. 2\cr
Copyright: \tab Greg Snow and Intermountain Healthcare\cr
}
Currently there are 2 main functions and an optional list.  The
\code{blockrand} function is used to create a data frame with the block
sequential treatment randomizations.  When doing a stratified study you
should run \code{blockrand} once for each stratum then optionally
combine the different data frames with \code{rbind}.  Save the data
frame(s) and when the study is completed the data can be added to the
data frame for analysis.

The \code{plotblockrand} function is used to
create the randomization cards to be used when assigning subjects to
treatment.  The cards are printed out and sealed in envelopes, then when
a new subject is enrolled the next envelope is opened and the subject
assigned to the corresponding treatment.

You can optionally create a list named \code{blockrand.text} with
optional elements top, middle, and bottom.  If this list exists and you
run \code{plotblockrand} without specifying these arguments, then the
element of the blockrand.text list will be used instead.
}
\author{
Greg Snow \email{538280@gmail.com}

Maintainer: Greg Snow \email{538280@gmail.com}
}
\keyword{ package }

\examples{
## stratified by sex, 100 in stratum, 2 treatments
male <- blockrand(n=100, id.prefix='M', block.prefix='M',stratum='Male')
female <- blockrand(n=100, id.prefix='F', block.prefix='F',stratum='Female')

my.study <- rbind(male,female)

\dontrun{
plotblockrand(my.study,'mystudy.pdf',
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

plotblockrand(my.study, 'mystudy.pdf', cut.marks=TRUE)
}

}
