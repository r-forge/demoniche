### R code from vignette source '/home/hedvig/Package_demoniche/model/demoniche_manual.Rnw'
### Encoding: UTF-8

options(width=72)


library(demoniche)


data(Hmontana)


str(Hmontana)
Hmontana$env_stochas_type


noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions = 2,
                        foldername = "noCC_nodispersal")                                 


CC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = TRUE, Dispersal = FALSE, repetitions = 2, foldername = "CC_nodispersal")                                  


dim(noCC_nodispersal)
dimnames(noCC_nodispersal)


noCC_nodispersal[,"EMA","Mx4"]


barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))


barplot(cbind(noCC_nodispersal[90,2,], CC_nodispersal[90,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("no Niche values","with Niche values"))


list.files(path = "noCC_nodispersal")


load('noCC_nodispersal/eigen_results.rda') 
str(eigen_results)


image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")


image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")


Populations_mine      <- 
    read.table(file = "Hudsonia_Populations_grids.csv", sep = ",", header = TRUE)
head(Populations_mine)    


Nichemap_mine        <- 
        read.table(file = "Hudsonia_SDMmodelling.csv", sep = ",", header = TRUE)      
tail(Nichemap_mine)


niche_formulas <- as.formula(paste(paste(colnames(Nichemap_mine)[-c(1:3)],
                      collapse="+"),"X+Y",sep="~"))


print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))


print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))


no_yrs_mine         <- 10                            


library(popbio)
data(hudvrs)         
data(hudsonia)     
matrices_mine <- cbind(meanmatrix = as.vector(hudmxdef(hudvrs$mean)), 
                              sapply(hudsonia, unlist))
head(matrices_mine)                              
colnames(matrices_mine) <- c("Reference_matrix", "Mx1", "Mx2", "Mx3", "Mx4")


matrix(matrices_mine[,"Reference_matrix"], ncol = 6, byrow = FALSE)                                        


stages_mine <- colnames(hudsonia$A85)


sumweight_mine      <- c(0,1,1,1,1,1)   


transition_affected_niche_mine <- c(1,3)
matrices_mine[transition_affected_niche_mine,1] # these values will be affected by the Niche values in the mean matrix


transition_affected_env_mine <- "all"  


transition_affected_demogr_mine <- "all"      


env_stochas_type_mine <- "normal"  


matrices_var_mine   <-
 matrix(0.01, ncol = 1, nrow = nrow(matrices_mine), dimnames = list(NULL, "sd"))  


proportion_initial_mine <- c(0.9818098089, 0.0006907668, 0.0069076675, 
                              0.0036840893, 0.0057563896, 0.0011512779)


density_individuals_mine <- 20000             


K_mine              <- 100


prob_scenario_mine <- c(0.5, 0.5)   


noise_mine <- 0.95


fraction_SDD_mine <- 0.05   


fraction_LDD_mine <- 0.05                


dispersal_constants_mine <- c(0.7, 0.7, 0.1, 200)                   


rm(CC_nodispersal, eigen_results, Hmontana, hudsonia,hudvrs, niche_formulas, noCC_nodispersal)

ls()



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
      no_yrs = no_yrs_mine, K = K_mine, sumweight = sumweight_mine)


Hmontana$neigh_index


