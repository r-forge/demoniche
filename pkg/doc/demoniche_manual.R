#line 27 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
options(width=72)


#line 73 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
library(demoniche)


#line 83 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
data(Hmontana)


#line 86 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
str(Hmontana)
Hmontana$env_stochas_type


#line 98 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions = 2,
                        foldername = "noCC_nodispersal")                                 


#line 104 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
CC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = TRUE, Dispersal = FALSE, repetitions = 2, foldername = "CC_nodispersal")                                  


#line 124 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
dim(noCC_nodispersal)
dimnames(noCC_nodispersal)


#line 129 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noCC_nodispersal[,"Meanpop","Mx4"]


#line 138 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))


#line 146 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 138 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))
#line 147 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 157 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
list.files(path = "noCC_nodispersal")


#line 169 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
load('noCC_nodispersal/eigen_results.rda') 
str(eigen_results)


#line 175 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")


#line 182 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 175 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")
#line 183 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 220 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
args(demoniche_setup)


#line 236 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Populations_mine      <- 
    read.table(file = "Hudsonia_Populations_grids.csv", sep = ",", header = TRUE)
head(Populations_mine)    


#line 253 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Nichemap_mine        <- 
        read.table(file = "Hudsonia_SDMmodelling.csv", sep = ",", header = TRUE)      
tail(Nichemap_mine)


#line 262 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
niche_formulas <- as.formula(paste(paste(colnames(Nichemap_mine)[-c(1:3)],
                      collapse="+"),"X+Y",sep="~"))


#line 266 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))


#line 273 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
#line 266 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))
#line 274 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"


#line 283 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
no_yrs_mine         <- 10                            


#line 296 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
library(popbio)
data(hudvrs)         
data(hudsonia)     
matrices_mine <- cbind(meanmatrix = as.vector(hudmxdef(hudvrs$mean)), 
                              sapply(hudsonia, unlist))
head(matrices_mine)                              
colnames(matrices_mine) <- c("Reference_matrix", "Mx1", "Mx2", "Mx3", "Mx4")


#line 309 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
matrix(matrices_mine[,"Reference_matrix"], ncol = 6, byrow = FALSE)                                        


#line 317 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
stages_mine <- colnames(hudsonia$A85)


#line 326 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
sumweight_mine      <- c(0,1,1,1,1,1)   


#line 333 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_niche_mine <- c(1,3)
matrices_mine[transition_affected_niche_mine,1] # these values will be affected by the Niche values in the mean matrix


#line 343 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_env_mine <- "all"  


#line 350 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
transition_affected_demogr_mine <- "all"      


#line 358 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
env_stochas_type_mine <- "normal"  


#line 364 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
matrices_var_mine   <-
 matrix(0.01, ncol = 1, nrow = nrow(matrices_mine), dimnames = list(NULL, "sd"))  


#line 371 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
proportion_initial_mine <- c(0.9818098089, 0.0006907668, 0.0069076675, 
                              0.0036840893, 0.0057563896, 0.0011512779)


#line 378 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
density_individuals_mine <- 20000             


#line 392 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
K_mine              <- 10000
Kweight_mine <- c(0,1.5,1,1,1,1)


#line 401 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
prob_scenario_mine <- c(0.5, 0.5)   


#line 411 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
noise_mine <- 0.95


#line 419 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
fraction_SDD_mine <- 0.05   


#line 427 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
fraction_LDD_mine <- 0.05                


#line 435 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
dispersal_constants_mine <- c(0.7, 0.7, 0.1, 200)                   


#line 444 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
rm(CC_nodispersal, eigen_results, Hmontana, hudsonia,hudvrs, niche_formulas, noCC_nodispersal)

ls()


#line 451 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"

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


#line 480 "/Users/hedvig/Documents/Demoniche/model/demoniche_manual.Rnw"
Hmontana$neigh_index


