\name{demoniche_setup}
\alias{demoniche_setup}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Sets-up the species data for demographic modelling.
}
\description{
The first step used for modelling spatially-explicit demographic dynamics requires running this function, which checks the consistency of the user-supplied information and generates an R object containing the necessary information for modelling. The object is also saved in the working directory for future reference. 
}
\usage{
demoniche_setup(modelname, Populations, stages,
                Nichemap = "oneperiod", matrices, matrices_var = FALSE, prob_scenario = c(0.5, 0.5),
                proportion_initial, density_individuals,
                transition_affected_niche = FALSE, transition_affected_env = FALSE,
                transition_affected_demogr = FALSE, env_stochas_type = "normal", 
                noise = 1, fraction_SDD = FALSE, 
                fraction_LDD = FALSE, dispersal_constants = c(0.7, 0.7, 0.1, 3),
                no_yrs, Ktype = "ceiling", K = NULL, Kweight = FALSE, sumweight = FALSE)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{modelname}{
Character, desired name of the species object.
}
  \item{Populations}{
The matrix with the population IDs, X coordinates, Y coordinates and area in the columns.
}

  \item{Nichemap}{
The background niche map, with X coordinates, Y coordinates and niche values for different periods in the coulmns.
}
  \item{matrices}{
A matrix of transtion matrices for different scenarios, 
 one column per matrix. The dimension should be a multiple of the number of stages. 
 The first matrix should be the 'reference' matrix.     
The model can also run with a single matrix, in which case the mean population will be the same as the minimum and maximum population numbers, and the standard deviation NA (deterministic modelling).
}
  \item{matrices_var}{
A vector. Coefficients of variation in vital rates which are used to set how variable the environmental and demographic stocasticity should be.
}
  \item{prob_scenario}{
A vector of two numbers, and the default is equal probability, i.e. \code{c(0.5,0.5)}.
}
  \item{noise}{
Currently not implemented.
}
  \item{transition_affected_niche}{
Here we specify which transition probabilities (matrix elements) should be affected by the Niche values. We can specify the character string \code{"all"} which means that all non-zero stages are affected. Alternatively, we enter the matrix stages as a vector of numbers which correponds to the correct matrix element. In this case, we set Niche values to affect rows 1 and 3 of the matrices object. We know that the first and third row in our matrices object refer to the probability of a seed surviving in the seed-bank and the probability of a seed becoming a seedling. 
}
  \item{transition_affected_env}{
Here we specify which transition probabilities (matrix elements) should be affected by and environmental and demographic stochasticity. To use no stochasticity and carry out deterministic modelling, we set this to \code{FALSE} (default). This vector refers to the  affected transition stages in the same way as the Niche values.

Possible arguments: \code{"all"} (all nonzero transition probabilities) 
or a vector of affected stages.
}
  \item{transition_affected_demogr}{
Currently not implemented.
}
  \item{env_stochas_type}{
Do you want the environmental stochasticity to be normal or lognormal? Indicate
'normal' or 'lognormal' here. The default is a "normal" distribution.
}
  \item{stages}{
Character vector with names of stages of the transition matrices.
}
  \item{sumweight}{
Vector, which stages to count when calculating population sizes. Should be a vector of the same length as the number of stages.
}

  \item{proportion_initial}{
This is the initial proportion of individuals in all stages, and should be a vector of the same length as the number of stages, and should add to 1.
}
  \item{density_individuals}{
Density of individuals (all stages, including seeds) in each grid cell. This number is automatically multiplied by the column named 'area' in Populations, and should be in the same units as the area in the \code{Populations} object. This can be a single value, which is then used for all populations, or a vector if denisities in each population are known. This density value only affects the initial abundances, and not future projections.
}
  \item{fraction_SDD}{
Proportion of seeds with short-distance dispersal (contigous populations). 
}

  \item{fraction_LDD}{
Proportion of seeds with long-distance dispersal, with the dispersal kernel.
}
  \item{dispersal_constants}{
Constants for LDD dispersal function as a vector in the format: \code{c(a, b, c, Distmax)} 
If the distance between populations is larger than Distmax (in the same units as the Populations, in this case in lat-long), there will be no dispersal between patches.
}
  \item{no_yrs}{
Length in years of each time period (each of the columns with niche values in the Nichemap is a time period).
}
  \item{K}{
Carrying capacity of populations. When populations are over the value in K (the number of individuals) they will reach carrying capacity, and will be reduced to the value of K. This takes place through a simple ceiling functionality. The carrying capacity of newly colonized cells is set to the mean carrying capacity supplied.

If K is NULL, there is no carrying capacity limit in the simulations. In the demoniche model the K can be different for each (initial) population and each time period. If desired,K should correspond to either a vector of values with the same length as the number of populations, or a vector with the same length as the number of time periods (K for each timeperiod - the Niche values at each time period). It can also vary both for each population and each timeperiod, and should the be a matrix.
}

\item{Kweight}{
The \code{Kweight} argument defines which population stages should be affected by the density dependence. It should be a vector with the same length as the number of life stages. When calculating density dependent growth, the vector is multiplied by the population size when the population size is computed. A value of '1' means that the stage is counted as is, and a value above, means that it is counted proportionately more.  If we want a stage to be ignored when determining density dependence, we make it a zero. In this case, we want mostly juveniles to be counted, but not seeds. The default is  (same as a vector of ones). Beware, changing the \code{Kweight} means that populations could grow above or below the actual K set.
}
  \item{Ktype}{
Currently ceiling only. 
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
The function returns a list with the specified model name, to be used in demoniche_model function. It is also saved in the working directory.
}
\references{
%% ~put references to the literature/web site here ~
}
\author{
Hedvig Nenzen
}
\note{
Please see the Manual for examples, available from \url{http://demoniche.r-forge.r-project.org/pics/demoniche_manual.pdf}
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{

 
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{Simulation modelling}
\keyword{Species}% __ONLY ONE__ keyword per line
