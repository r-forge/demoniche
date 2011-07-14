\name{demoniche_model}
\alias{demoniche_model}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Demographic Modelling
}
\description{
The function performs the modelling simulations on the object created by 'demoniche_setup'. In the 'demoniche_model' function the user specifies if she/he wishes to include effects of the Niche values and dispersal. The user also needs to specify how many repetitions are to be carried out and supply a name for the folder where the simulation results will be saved. 
}
\usage{
demoniche_model(modelname, Niche, Dispersal, repetitions, foldername)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{modelname}{
%%     ~~Describe \code{modelname} here~~
}
  \item{Niche}{
%%     ~~Describe \code{Niche} here~~
}
  \item{Dispersal}{
%%     ~~Describe \code{Dispersal} here~~
}
  \item{repetitions}{
%%     ~~Describe \code{repetitions} here~~
}
  \item{foldername}{
%%     ~~Describe \code{foldername} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
data(Hmontana)

noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions =  2,
                        foldername = "noCC_nodispersal")
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
