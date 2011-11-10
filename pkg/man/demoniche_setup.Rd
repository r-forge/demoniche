\name{demoniche_setup}
\alias{demoniche_setup}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sets-up the species data for demographic modelling.
}
\description{
The first step used for modelling spatially-explicit demographic dynamics requires running the 'demoniche_setup' function, which checks the consistency of the user-supplied information and generates an R object containing the necessary information for modelling. The object is also saved in the working directory for future reference. Input data is either written directly into the workspace, or read from csv or txt files according to standard R procedures. 
}
\usage{
demoniche_setup(modelname, Populations, stages,
                      Nichemap = "oneperiod", matrices, matrices_var, prob_scenario = c(0.5, 0.5),
                proportion_initial, density_individuals,
                      transition_affected_niche = FALSE, transition_affected_env = FALSE,
                       transition_affected_demogr = FALSE, env_stochas_type = "normal", 
                     noise = 1, fraction_SDD = FALSE, 
                      fraction_LDD = FALSE, dispersal_constants = FALSE,
                       no_yrs, Ktype = "ceiling", K = NULL, Kweight = FALSE, sumweight = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{modelname}{
%%     ~~Describe \code{modelname} here~~
}
  \item{Populations}{
%%     ~~Describe \code{Populations} here~~
}
  \item{fraction_SDD}{
%%     ~~Describe \code{fraction_SDD} here~~
}

  \item{Nichemap}{
%%     ~~Describe \code{Nichemap} here~~
}
  \item{matrices}{
%%     ~~Describe \code{matrices} here~~
}
  \item{matrices_var}{
%%     ~~Describe \code{matrices_var} here~~
}
  \item{prob_scenario}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{noise}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{transition_affected_niche}{
%%     ~~Describe \code{transition_affected_niche} here~~
}
  \item{transition_affected_env}{
%%     ~~Describe \code{transition_affected_env} here~~
}
  \item{transition_affected_demogr}{
%%     ~~Describe \code{transition_affected_demogr} here~~
}
  \item{env_stochas_type}{
%%     ~~Describe \code{env_stochas_type} here~~
}
  \item{stages}{
%%     ~~Describe \code{stages} here~~
}
  \item{proportion_initial}{
%%     ~~Describe \code{proportion_initial} here~~
}
  \item{density_individuals}{
%%     ~~Describe \code{density_individuals} here~~
}
  \item{fraction_LDD}{
%%     ~~Describe \code{fraction_LDD} here~~
}
  \item{dispersal_constants}{
%%     ~~Describe \code{dispersal_constants} here~~
}
  \item{no_yrs}{
%%     ~~Describe \code{no_yrs} here~~
}
  \item{K}{
%%     ~~Describe \code{K} here~~
}
  \item{sumweight}{
%%     ~~Describe \code{sumweight} here~~
}
  \item{Kweight}{
%%     ~~Describe \code{sumweight} here~~
}
  \item{Ktype}{
%%     ~~Describe \code{sumweight} here~~
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
# Please see the Manual for examples.
 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Simulation modelling}
\keyword{Species}% __ONLY ONE__ keyword per line
