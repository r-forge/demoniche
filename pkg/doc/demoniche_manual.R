#line 22 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
options(width=72)


#line 68 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
library(demoniche)


#line 78 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
data(Hmontana)


#line 81 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
str(Hmontana)
Hmontana$env_stochas_type


#line 93 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions = 2,
                        foldername = "noCC_nodispersal")                                 


#line 99 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
CC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = TRUE, Dispersal = FALSE, repetitions = 2, foldername = "CC_nodispersal")                                  


#line 119 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
dim(noCC_nodispersal)
dimnames(noCC_nodispersal)


#line 124 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noCC_nodispersal[,"Meanpop","Mx1"]


#line 133 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))


#line 141 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 133 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))
#line 142 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 152 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
list.files(path = "noCC_nodispersal")


#line 164 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
load('noCC_nodispersal/eigen_results.rda') 
str(eigen_results)


#line 170 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")


#line 177 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 170 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")
#line 178 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 227 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Populations_mine      <- 
    read.table(file = "Hudsonia_Populations_grids.csv", sep = ",", header = TRUE)
head(Populations_mine)    


#line 238 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Nichemap_mine        <- 
        read.table(file = "Hudsonia_SDMmodelling.csv", sep = ",", header = TRUE)      
tail(Nichemap_mine)


#line 247 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
niche_formulas <- as.formula(paste(paste(colnames(Nichemap_mine)[-c(1:3)],
                      collapse="+"),"X+Y",sep="~"))


#line 251 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))


#line 258 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 251 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))
#line 259 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 268 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
no_yrs_mine         <- 10                            


#line 281 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
library(popbio)
data(hudvrs)         
data(hudsonia)     
matrices_mine <- cbind(meanmatrix = as.vector(hudmxdef(hudvrs$mean)), 
                              sapply(hudsonia, unlist))
head(matrices_mine)                              
colnames(matrices_mine) <- c("Reference_matrix", "Mx1", "Mx2", "Mx3", "Mx4")


#line 294 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
matrix(matrices_mine[,"Reference_matrix"], ncol = 6, byrow = FALSE)                                        


#line 302 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
stages_mine <- colnames(hudsonia$A85)


#line 311 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
sumweight_mine      <- c(0,1,1,1,1,1)   


#line 317 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_niche_mine <- c(1,3)
matrices_mine[transition_affected_niche_mine,1] # these values will be affected by the Niche values in the mean matrix


#line 327 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_env_mine <- "all"  


#line 334 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_demogr_mine <- "all"      


#line 342 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
env_stochas_type_mine <- "normal"  


#line 348 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
matrices_var_mine   <-
 matrix(0.01, ncol = 1, nrow = nrow(matrices_mine), dimnames = list(NULL, "sd"))  


#line 355 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
proportion_initial_mine <- c(0.9818098089, 0.0006907668, 0.0069076675, 
                              0.0036840893, 0.0057563896, 0.0011512779)


#line 362 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
density_individuals_mine <- 20000             


#line 374 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
K_mine              <- 10000
Kweight_mine <- c(0,1.5,1,1,1,1)


#line 383 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
prob_scenario_mine <- c(0.5, 0.5)   


#line 393 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noise_mine <- 0.95


#line 401 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
fraction_SDD_mine <- 0.05   


#line 409 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
fraction_LDD_mine <- 0.05                


#line 417 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
dispersal_constants_mine <- c(0.7, 0.7, 0.1, 200)                   


#line 426 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
rm(CC_nodispersal, eigen_results, Hmontana, hudsonia,hudvrs, niche_formulas, noCC_nodispersal)

ls()


#line 433 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"

demoniche_setup(modelname = "Hmontana", # Name of information object
      Populations = Populations_mine, Nichemap = Nichemap_mine,
      matrices = matrices_mine, matrices_var = matrices_var_mine, noise = noise_mine, 
      prob_scenario = prob_scenario_mine,
      stages = stages_mine, proportion_initial = proportion_initial_mine,
      density_individuals = density_individuals_mine, 
      fraction_LDD = 0.05, fraction_SDD = fraction_SDD_mine, 
      dispersal_constants = dispersal_constants_mine,
      transition_affected_niche = transition_affected_niche_mine,
      transition_affected_demogr = transition_affected_demogr_mine, 
      transition_affected_env = transition_affected_env_mine,
      env_stochas_type = env_stochas_type_mine,
      no_yrs = no_yrs_mine, K = K_mine, Kweight = Kweight_mine, sumweight = sumweight_mine)


#line 461 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Hmontana$neigh_index

str(Hmontana)
