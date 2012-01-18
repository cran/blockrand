\name{blockrand}
\alias{blockrand}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Generate a block randomization for a clinical trial }
\description{
  This function creates random assignments for clinical trials (or any
  experiment where the subjects come one at a time).  The randomization
  is done within blocks so that the balance between treatments stays
  close to equal throughout the trial.
}
\usage{
blockrand(n, num.levels = 2, levels = LETTERS[seq(length = num.levels)],
id.prefix, stratum, block.sizes = 1:4, block.prefix,
uneq.beg=FALSE, uneq.mid=FALSE, uneq.min=0, uneq.maxit=10)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{n}{ The minimum number of subjects to randomize }
  \item{num.levels}{ The number of treatments or factor levels to
    randomize between }
  \item{levels}{ A character vector of labels for the different
    treatments or factor levels }
  \item{id.prefix}{ Optional integer or character string to prefix the id
  column values}
  \item{stratum}{ Optional character string specifying the stratum being
  generated}
  \item{block.sizes}{ Vector of integers specifying the sizes of blocks
    to use }
  \item{block.prefix}{ Optional integer or character string to prefix
    the block.id column }
  \item{uneq.beg}{ Should an unequal block be used at the beginning of
    the randomization }
  \item{uneq.mid}{ Should an unequal block be used in the middle }
  \item{uneq.min}{ what is the minimum difference between the most and
    least common levels in an unequal block }
  \item{uneq.maxit}{ maximum number of tries to get uneq.min difference }
}
\details{
  This function will randomize subjects to the specified treatments
  within sequential blocks.  The total number of randomizations may end
  up being more than \code{n}.

  The final block sizes will actually be the product of
  \code{num.levels} and \code{block.sizes} (e.g. if there are 2 levels
  and the default block sizes are used (1:4) then the actual block sizes
  will be randomly chosen from the set (2,4,6,8)).

  If \code{id.prefix} is not specified then the id column of the output
  will be a sequence of integers from 1 to the number of rows.  If
  \code{id.prefix} is numeric then the id column of the output will be a
  sequence of integers starting at the value of \code{id.prefix}.  If
  \code{id.prefix} is a character string then the numbers will be
  converted to strings (zero padded) and have the prefix prepended.

  The \code{block.prefix} will be treated in the same way as the
  \code{id.prefix} for identifying the blocks.  The one difference being
  that the \code{block.id} will be converted to a factor in the final
  data frame.

  If \code{uneq.beg} and/or \code{uneq.mid} are true then an additional
  block will be used at the beginning and/or inserted in the middle that
  is not balanced, this means that the final totals in each group may
  not be exactly equal (but still similar).  This makes it more
  difficult to anticipate future assignments as the numbers will not
  return to equality at the end of each block.

  For stratified studies the \code{blockrand} function should run once
  each for each stratum using the \code{stratum} argument to specify the
  current stratum (and using \code{id.prefix} and \code{block.prefix} to
  keep the id's unique).  The separate data frames can then be combined
  using \code{rbind} if desired.

}
\value{
A data frame with the following columns:
  \item{id:}{A unique identifier (number or character string) for each row}
  \item{stratum:}{Optional, if \code{stratum} argument is specfied it
    will be replicated in this column}
  \item{block.id:}{An identifier for each block of the randomization,
    this column will be a factor}
  \item{block.size}{The size of each block}
  \item{treatment}{The treatment assignment for each subject}
}
\references{Schulz, K. and Grimes, D. (2002): Unequal group sizes in
  randomized trials: guarding against guessing, The Lancet, 359, pp
  966--970. }
\author{ Greg Snow \email{greg.snow@imail.org}}
\seealso{ \code{\link{plotblockrand}}, \code{sample}, \code{rbind} }
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
}

}
\keyword{ datagen }% at least one, from doc/KEYWORDS
\keyword{ design }% __ONLY ONE__ keyword per line
\keyword{ distribution }