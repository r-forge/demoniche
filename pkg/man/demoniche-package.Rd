\name{demoniche-package}
\alias{demoniche-package}
\alias{demoniche}
\docType{package}
\title{
Simulating spatially-explicit species demographic growth
}
\description{
demoniche is an R-package to simulate stochastic population growth for various subpopulations of a species. The mechanistic demographic model projects population sizes with various transition matrices that represent demographic impacts on species growth. Demographic modelling is linked to a time series of geographically distributed habitat suitability values that also affect species niche. The demoniche model offers flexible options for stochasticity, density dependence and dispersal. With the demoniche package it is possible to investigate population sizes, extinction probabilities and range shift of a species under the influence of scenarios of environmental and human impacts. 
}
\details{
\tabular{ll}{
Package: \tab demoniche\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2011-07-13\cr
License: \tab GPL-2\cr
LazyLoad: \tab yes\cr
}
data(Hmontana)

noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions =  2,
                        foldername = "noCC_nodispersal")
}
\author{
Hedvig Nenzen

Maintainer: Hedvig Nenzen <hedvig.nenzen@gmail.com>
}
\references{
Morris, W.F., and D.F. Doak. 2002. Quantitative Conservation Biology. Theory and Practice of Population Viability Analysis. - Sinauer Associates, Sunderland, Massachusetts.
}

\keyword{ package }
\seealso{

}
\examples{
data(Hmontana)

noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions =  2,
                        foldername = "noCC_nodispersal")
}
