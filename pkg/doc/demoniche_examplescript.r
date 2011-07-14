##### Demoniche example simulation ############################################# 
################################################################################
#### Author: Hedvig Nenzen, hedvig.nenzen@gmail.com ############################
          
library(demoniche)           
# As example species we will use population information from Hudsonia montana
# For more information see help(hudsonia) in the popbio package.
# The geographical information is hypothetical.

##### Required information ##################################################### 
                                                 
# We enter our data into the workspace, either by reading files from a folder,
# (using read.table() or load()) by writing them into the workspace, or by 
# directly writing them into the function 'demoniche_setup'
# Each vector we define  will be a part of the species object (a list)), which 
# contains all the information needed for modelling. 

##### Geographic information ###################################################

# Should be one file with ID of patches (Must be numeric), coordinates of original
# locations, size of the population (in same unit as density data).  
# The data should be in lat/long format. 
                                   
Populations_mine      <- 
    read.table(file = "Hudsonia_Populations_grids.csv", sep = ",", header = TRUE)   


# patch coordinates and future Niche data. This can be a regular 
# grid with the same coordinate system as where the patches are located.
# the Niche values corresponding to the geographical location of the population 
# will be joined in the setup function.
# In this case we are using predicted proabilities of presence under climate
# change so we will say that our results from models that include the effects of 
# Niche values, are under the effect of climate change. 

Nichemap_mine        <- 
        read.table(file = "Hudsonia_SDMmodelling.csv", sep = ",", header = TRUE)      


# With the lattice library we can plot the Nichevalues and see how the most 
# suitable areas moves towards the south.
library(lattice) 

niche_formulas <- as.formula(paste(paste(colnames(Nichemap_mine)[-c(1:3)],
                      collapse="+"),"X+Y",sep="~"))    
print(levelplot(niche_formulas, Nichemap_mine, col.regions=rev(heat.colors(100)), 
  main = "Niche Values"))

##### Demographic information ##################################################
# A matrix/data frame of transtion matrices for different scenarios, 
# one column per matrix. The dimension should be a multiple of the number of stages. 
# The first matrix should be the 'reference' matrix.     
# The model can also run with one single matrix.   

# Load required data from the popbio package
library(popbio)
data(hudvrs)         
data(hudsonia)     

matrices_mine <- cbind(meanmatrix = as.vector(hudmxdef(hudvrs$mean)), 
                              sapply(hudsonia, unlist))        
colnames(matrices_mine) <- c("Reference_matrix", "Mx1", "Mx2","Mx3", "Mx4")

stages_mine <- colnames(hudsonia$A85)

# Make sure that the command 'matrix(matrices_mine[,1], ncol = 
# length(stages_mine), byrow = FALSE)' gives the correct matrix (dependent on 
# the original order of the matrix elements, by row or by column). 
matrix(matrices_mine[,1], ncol = length(stages_mine), byrow = FALSE)                                        

# Which stages should be counted when calculating population sizes 
# In this case, we do not count the seed stage when calculating population sizes
# It can also be "all_stages" for all stages
sumweight_mine      <- c(0,1,1,1,1,1)              
     
     
proportion_initial_mine <- c(0.9818098089, 0.0006907668, 0.0069076675, 
                              0.0036840893, 0.0057563896, 0.0011512779)

# Density of individuals (all stages, including seeds) in patches.
# Same units as area sizes as in Populations_mine (sometimes lat/long)
density_individuals_mine <- 20000                

# When populations are over this(multiple) above compared to the population with the largest  
# original population they will reach K carrying capacity, and will be reduced to K.
# If NULL, there is no density dependence implemented in the model.
K_mine              <- 100

# Variances in vital rates                    
matrices_var_mine   <-
 matrix(0.01, ncol = 1, nrow = nrow(matrices_mine), dimnames = list(NULL, "sd"))  

# either FALSE (no), "all" (all nonzero transition probabilities) 
# or a vector of affected stages.
transition_affected_niche_mine <- c(1,3)
      
# either TRUE("all_nonzero_stages") or a vector of affected stages. 
# These stages are indicated when the matrix vector
# is made into a matrix with byrow = FALSE. 
transition_affected_env_mine <- "all"   #    "all"   
                                              
# Either TRUE("all_nonzero_stages") or a vector of affected stages. 
transition_affected_demogr_mine <- "all"      

# Do you want the environmental stochasticity to be normal or lognormal? Indicate
# "normal" or "lognormal" here. The default is a "normal" distribution. 
env_stochas_type_mine <- "normal"  

# With which probability should the scenario matrices should be drawn?
# Should be a vector of two numbers. Default is equal probability.
prob_scenario_mine <- c(0.5, 0.5)   

# Temporal autocorrelation, noise. Is the change in probability that the same 
# matrix as the last iteration will be chosen the next time period. 
# A noise value of 1 is completely random. 
# 0 < noise < 2. 
noise_mine <- 0.95
                                               
# Dispersal    
# Fraction of seeds that disperse short distance, beyond patch borders.   
# Dispersal takes palce to the 8 contigous cells.
# If this is zero, no SDD is modelled.      
fraction_SDD_mine <- 0.5   
                                            
# Fraction of seeds that disperse long distance, beyond patch borders. 
# The direction of seeds is deterined by the distances between populations.   
# If this is zero, no LDD is modelled.
fraction_LDD_mine <- 0.1                
                                              
# Constants for LDD dispersal kernel in the format: c(a, b, c, Distmax) 
# If the distance between populations is larger than Distmax (in kilometers,
# there will be no dispersal between patches 
dispersal_constants_mine <- c(0.7, 0.7, 0.1, 200)                   

                  
##### Projection information ###################################################

# Length in years of each time period
no_yrs_mine         <- 10                            
                        
                                
################################################################################
#### Setup data ###############################################################


# The setup function checks the consistency of data and generates one object 
# with all the necessary information for the modeling the workspace. 
# The object is also saved in the working directory

demoniche_setup(modelname = "Hmontana", # Name of information object
      Populations = Populations_mine, fraction_SDD = fraction_SDD_mine, Nichemap = Nichemap_mine,
      matrices = matrices_mine, matrices_var = matrices_var_mine, noise = noise_mine, 
      prob_scenario = prob_scenario_mine,
      stages = stages_mine, proportion_initial = proportion_initial_mine,
      density_individuals = density_individuals_mine, fraction_LDD = 0.05, 
      dispersal_constants = dispersal_constants_mine,
      transition_affected_niche = transition_affected_niche_mine, 
      transition_affected_demogr = transition_affected_demogr_mine, 
      transition_affected_env = transition_affected_env_mine,
      env_stochas_type = env_stochas_type_mine,
      no_yrs = no_yrs_mine, K = K_mine, sumweight = sumweight_mine)
               
# We have now created a species object (a list) which is called the 'modelname'
# that we specified. In this case Hmontana. We can look at the structure of this 
# list, and we can inspect parts of it with the dollar sign. 
             
str(Hmontana)
 Hmontana$stages
     
################################################################################
#### MODEL #####################################################################
 
# When the 'demoniche' function is run, a folder with the specified foldername 
# is created in the working directory where results from each run are stored. 
  
# the object from the 'demoniche' function is an array with three dimensions. 
# The rows are the information for each matrix. 
# The columns are various information about the projects: initial total patch 
# area, initial population, percentage of patches that went extinct during the 
# simulations, the lambda of the treatment matrix (not the mean, first matrix,
# function from popbio package),the stochastic lambda from the two matrices 
# (from popbio package), and the habitat suitability values. 
load("Hmontana.rda")

# Here we run 4 different simulations with all combinations of TRUE and FALSE 
# for dispersal and future_HSvalues. In this case, the future HS values are 
# outputs from SDM and represent changing climates
# The results will be saved in different folders, and in different objects. 
 
             
noCC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = FALSE, repetitions =  2,
                        foldername = "noCC_nodispersal")
           
CC_nodispersal <- demoniche_model(modelname = "Hmontana", Niche = TRUE, 
                        Dispersal = FALSE, repetitions = 2,
                        foldername = "CC_nodispersal")  
                        
noCC_dispersal <- demoniche_model(modelname = "Hmontana", Niche = FALSE, 
                        Dispersal = TRUE, repetitions = 2, 
                        foldername = "noCC_dispersal")
        
CC_dispersal <- demoniche_model(modelname = "Hmontana", Niche = TRUE, 
                        Dispersal = TRUE, repetitions = 2,
                        foldername = "CC_dispersal")
   

# Plot of final population sizes for each transition matrix
# with and without effects of Niche values. 

barplot(cbind(noCC_nodispersal[10,2,], CC_nodispersal[10,2,]), beside = TRUE, 
      legend.text = Hmontana$list_names_matrices, names.arg = 
      c("Stable Climate (no Niche values)","Climate Change (with Niche values)"),
      inside = TRUE)
                               

       
################################################################################
#### Analyze Results ###########################################################                                    
# We can look at the files in folder we created in the the working directory. 
# There are jpeg and csv files that we can inspect outside R. 
# We can load the .rda files in R. 
list.files(path = "noCC_nodispersal") 
  
# The population_sizes.rda saves the populations sizes for each repetition. 
# Here we can inspect the population sizes for each repetition             
load("noCC_nodispersal/population_sizes.rda")  
population_sizes[100,,]

# We can also load the complete projection results from each repetition and each 
# population, with the complete stage structure for each year. This file is
# always called 'Projection', so loading a new file will will replace the values. 
load("noCC_nodispersal/Projection_rep1_Reference_matrix.rda")  
str(Projection)

# Projection is a large array so it is better we only look at parts, here for 
# example, for the first 10 years of the first Niche period and three grid 
# cells (one which was never colonized).          
Projection[1:10,,898:900,1]  
           
# For each matrix, we can also load the object 'eigen_results_allmatrices.rda'
# for the 'treatment matrix' i.e. not the mean basic matrix.
# The array contains the eigenvalue of the matrix (lambda), the stable stage 
# distribution, the sensitivities and specificities, the reproductive value of 
# each stage, and the damping ratio. It is a list with a entry for each matrix, 
# which is made up of the results from the function 'eigen.analysis' from popbio.  
# These examples are taken from the 'popbio' package help files. 

load('noCC_nodispersal/eigen_results.rda') 
str(eigen_results) 

# Sensitivity matrix for 'meanmatrix' transition matrix.
eigen_results$Reference_matrix$sensitivities     
image2(eigen_results$Reference_matrix$sensitivities)
title("Sensitivity, Reference Matrix")
          


    
