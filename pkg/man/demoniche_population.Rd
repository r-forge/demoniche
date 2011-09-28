\name{demoniche_population}
\alias{demoniche_population}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
demographic modelling
}
\description{
Inner function that carries out demographic modelling in each population and year
}
\usage{
demoniche_population(Matrix_projection, Matrix_projection_var = NULL, n, populationmax, K = NULL, Kweight, onepopulation_Niche, sumweight, noise, prob_scenario, prev_mx, transition_affected_demogr, transition_affected_niche, transition_affected_env, env_stochas_type, yx_tx)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{Matrix_projection}{
%%     ~~Describe \code{Matrix_projection} here~~
}
  \item{Matrix_projection_var}{
%%     ~~Describe \code{Matrix_projection_var} here~~
}
  \item{n}{
%%     ~~Describe \code{n} here~~
}
  \item{populationmax}{
%%     ~~Describe \code{populationmax} here~~
}
  \item{K}{
%%     ~~Describe \code{K} here~~
}
  \item{Kweight}{
%%     ~~Describe \code{K} here~~
}
  \item{onepopulation_Niche}{
%%     ~~Describe \code{onepopulation_Niche} here~~
}
  \item{sumweight}{
%%     ~~Describe \code{sumweight} here~~
}
  \item{prob_scenario}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{noise}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{transition_affected_demogr}{
%%     ~~Describe \code{transition_affected_demogr} here~~
}
  \item{transition_affected_niche}{
%%     ~~Describe \code{transition_affected_niche} here~~
}
  \item{transition_affected_env}{
%%     ~~Describe \code{transition_affected_env} here~~
}
  \item{prev_mx}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{yx_tx}{
%%     ~~Describe \code{prob_scenario} here~~
}
  \item{env_stochas_type}{
%%     ~~Describe \code{env_stochas_type} here~~
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

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
