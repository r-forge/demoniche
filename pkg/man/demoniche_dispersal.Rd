\name{demoniche_dispersal}
\alias{demoniche_dispersal}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Dispersal modelling
}
\description{
Inner function. Calculates long and short distance dispersal between populations. 
}
\usage{
demoniche_dispersal(seeds_per_population, fraction_LDD, fraction_SDD, dispersal_probabilities, dist_latlong, neigh_index)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{seeds_per_population}{
%%     ~~Describe \code{seeds_per_population} here~~
}
  \item{fraction_LDD}{
%%     ~~Describe \code{fraction_LDD} here~~
}
  \item{fraction_SDD}{
%%     ~~Describe \code{fraction_SDD} here~~
}
  \item{dispersal_probabilities}{
%%     ~~Describe \code{dispersal_probabilities} here~~
}
  \item{dist_latlong}{
%%     ~~Describe \code{dist_latlong} here~~
}
  \item{neigh_index}{
%%     ~~Describe \code{neigh_index} here~~
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

xs <- expand.grid(seq(1,3, 0.5) ,seq(1,3, 0.5)) # make coordinates
      
dist_latlong <- round(as.matrix(dist(xs)), 1)

neigh_index <- sort(unique(as.numeric(dist_latlong)))[2:3] # find coordinates

seeds_per_population_new <- rep(0,nrow(xs))
seeds_per_population <- sample(c(0,0,10000000), length(seeds_per_population_new), replace = TRUE)

dist_populations <- apply(xs, 1, function(eachPoint) spDistsN1(as.matrix(xs), eachPoint, longlat=TRUE))
  
dispersal_constants <- c(0.7, 0.7, 0.1, 1000)     

dispersal_probabilities <-
 dispersal_constants[1] * dexp((dist_populations * dispersal_constants[3])/dispersal_constants[2])
            
dispersal_probabilities[dist_populations > dispersal_constants[4]] <- 0
  diag(dispersal_probabilities) <- 0  

plot(dispersal_probabilities[,1])
                
        
disp <- 
     demoniche_dispersal(seeds_per_population = seeds_per_population,
     fraction_LDD = 0.05, fraction_SDD = 0.5, dispersal_probabilities = dispersal_probabilities, 
     dist_latlong = dist_latlong, neigh_index = neigh_index)  
                                      
plot(seeds_per_population- disp)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
