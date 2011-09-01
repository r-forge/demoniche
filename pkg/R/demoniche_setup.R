demoniche_setup <-
function(interactive=FALSE, modelname, Populations, stages,
                      Nichemap = FALSE, matrices, matrices_var, prob_scenario = c(0.5, 0.5),
                proportion_initial, density_individuals,
                      transition_affected_niche = FALSE, transition_affected_env = FALSE,
                       transition_affected_demogr = FALSE, env_stochas_type = "normal", 
                     noise = 1, fraction_SDD = FALSE, 
                      fraction_LDD = FALSE, dispersal_constants = FALSE,
                       no_yrs, K = NULL, sumweight = FALSE)
{
     
 require('sp')      
            
 if(exists("BEMDEM")) rm(BEMDEM, inherits = TRUE)
  
  if(is.vector(matrices)) {
    matrices <- matrix(matrices, ncol = 2, nrow = length(matrices))  # Deterministic modelling
    print("You are carrying out deterministic modelling.")
    colnames(matrices) <- c("matrixA", "matrixA")
     }
     
  if(length(K) != 1 && length(K) != nrow(Populations) && !is.null(K)) print("K must be either one number or a vector with the same length as the number of populations!") 
  if(length(proportion_initial) != length(stages)) print("Number of stages or proportions is wrong!")
  if(nrow(matrices) %% length(stages)!= 0) print("Number of rows in matrix is not a multiple of stages name vector!")
  if(is.vector(Populations)) print("There must be at least two populations!") 
  
  if(is.numeric(sumweight)){
         if(length(sumweight) != length(stages)) print("Length of sumweight does not correpond to length of stages!")
         }
  
  # I have to rescale matrices_sd to coefficient of variations! Or input coefficient of variations? 
  if(Nichemap == FALSE){    
    # how get that 'by' is the correct value (if <1 degre)  min_dist <-  
  extent <- cbind( X = seq(min(Populations[,"X"]), max(Populations[,"X"]), 1), 
     Y = seq(min(Populations[,"Y"]), max(Populations[,"Y"]), 1))
 Nichemap <- cbind(HScoreID = 1:nrow(extent), extent, allyears = rep(1,nrow(extent)))    
  }        
  years_projections <- colnames(Nichemap)[4:ncol(Nichemap)]
  
  # if(no_yrs < 1) print("There must be at least two years of projections!") 
  if((ncol(Nichemap)-3) != length(years_projections)) print("Number of years of projections is not equal to the number of habitat scores!")
  
  colnames(Populations) <- c("PatchID", "XCOORD", "YCOORD", "area_population") 
  colnames(Nichemap) <- c("HScoreID", "XCOORD", "YCOORD", years_projections) 
   
  
  if(max(Nichemap[, 4:ncol(Nichemap)]) > 100) 
      {Nichemap[, 4:ncol(Nichemap)] <- Nichemap[, 4:ncol(Nichemap)]/1000} # make sure HS Score is 0-1.
  if(max(Nichemap[, 4:ncol(Nichemap)]) > 10) 
      {Nichemap[, 4:ncol(Nichemap)] <- Nichemap[, 4:ncol(Nichemap)]/100}     
     
  list_names_matrices <- list() 
  
      for (i in 1:ncol(matrices)) #  makes a list of matrix names
         {  
           M_name_one <- paste(colnames(matrices)[i], sep = "_")
           list_names_matrices <- c(list_names_matrices, list(M_name_one))
         }      
    
          
    #  Niche_populations <- matrix(0, nrow = nrow(Nichemap), ncol = 1) # this will be same as niche values but with initial population sizes 
      # colnames(Niche_populations) <- years_projections  
    #   rownames(Niche_populations) <- Nichemap[,1]  
       Niche_ID <- data.frame(matrix(0, nrow = nrow(Nichemap), ncol = 4)) # this is the ID information
       Niche_ID[,1:3] <- Nichemap[,1:3]
       Niche_ID[,1] <- Nichemap[,1]
       colnames(Niche_ID) <- c("Niche_ID","X","Y","PopulationID")
       rownames(Niche_ID) <- Nichemap[,1]   
    
      n0_all <-  matrix(0, nrow = nrow(Nichemap), ncol = length(stages)) # many of these will be zeros
    
       if(length(density_individuals) == 1){
    		density_individuals <- rep(density_individuals, times = nrow(Populations))
   		}
          
       # join the Hs_scores to the closest population.     pxs = 1
          for(pxs in 1:nrow(Populations)) # for all original populations 
          	  {       
            rows <- which(
           spDistsN1(as.matrix(Nichemap[,2:3], ncol = 2), matrix(as.numeric(Populations[pxs,2:3]), ncol = 2), longlat=TRUE) 
           == min(spDistsN1(as.matrix(Nichemap[,2:3], ncol = 2), matrix(as.numeric(Populations[pxs,2:3]), ncol = 2), longlat=TRUE))) 
       
            Niche_ID[rows,4] <- Populations[pxs,1]
            n0_all[rows[1],] <- Populations[pxs,4] * proportion_initial * density_individuals[pxs] 
                } 

   # only the niche values      
         Niche_values <-  Nichemap[,4:(length(years_projections)+3)]              
                
  # to make populationmax    K = NULL
     if(is.null(K)){ 
   
    } else      # put Kweight here
     populationmax_all <- rep(K * (max(rowSums(n0_all))), length= nrow(Nichemap)) 
           
          # this is what cannot get made 
  dist_populations <- spDists(as.matrix(Niche_ID[,2:3]), longlat=TRUE)
      
      dimnames(dist_populations) <- list(Niche_ID[,1], Niche_ID[,1])

dispersal_probabilities <- dist_latlong <- neigh_index <-NA # If no dispersal

if(dispersal_constants != FALSE){
  dispersal_probabilities <-
  dispersal_constants[1] * dexp((dist_populations * dispersal_constants[3]) / dispersal_constants[2])
         
  dispersal_probabilities[dist_populations > dispersal_constants[4]] <- 0
  diag(dispersal_probabilities) <- 0   
        }      

if(fraction_LDD != FALSE){
  dist_latlong <- round(as.matrix(dist(Niche_ID[,2:3])), 1)                   
   # find populations that are neighboring 
  neigh_index <- sort(unique(as.numeric(dist_latlong)))[2:3]         
}          
  
   if(sumweight[1] == "all_stages") sumweight <- rep(1, length(proportion_initial))
   if(transition_affected_env[1] == "all") transition_affected_env <- which(matrices[,1] > 0)
   if(transition_affected_niche[1] == "all") transition_affected_niche <- which(matrices[,1] > 0)
   if(transition_affected_demogr[1] == "all") transition_affected_demogr <- which(matrices[,1] > 0)
 #  if(is.numeric(transition_affected_env)) transition_affected_env <- transition_affected_env
 #  if(is.numeric(transition_affected_niche)) transition_affected_niche <- transition_affected_niche
 #  if(is.numeric(transition_affected_demogr)) transition_affected_demogr <- transition_affected_demogr
   if(any(matrices < 0)) print("There are some negative rates in the transition matrices!")
   if(any(matrices_var < 0)) print("There are some negative rates in the standard deviation transition matrices!")
  
  
  if(max(transition_affected_niche) > nrow(matrices)){ 
      print("Stages affected by Habitat suitability values does not comply with the size of matrix! Not that the matrix is made with 'byrow = FALSE") }
  if(max(transition_affected_env) > nrow(matrices)){ 
    print("Stages affected by environmental stochasticity does not comply with the size of matrix! Note that the matrix is made with 'byrow = FALSE") }
  if(max(transition_affected_demogr) > nrow(matrices)){  
      print("Stages affected by demographic stochasticity does not comply with the size of matrix! Note that the matrix is made with 'byrow = FALSE") }
    
                                                   # dist_populations not used.
BEMDEM <- list(Orig_Populations = Populations, Niche_ID = Niche_ID, Niche_values = Niche_values,    
        years_projections = years_projections, 
        matrices = matrices, matrices_var = as.matrix(matrices_var), prob_scenario = prob_scenario, noise = noise,
        stages = stages, proportion_initial = proportion_initial, density_individuals = 
        density_individuals, 
        fraction_SDD = fraction_SDD, dispersal_probabilities = dispersal_probabilities, 
        dist_latlong = dist_latlong,
        neigh_index = neigh_index, fraction_LDD = fraction_LDD, no_yrs = no_yrs, K = K, 
        populationmax_all = populationmax_all, n0_all = n0_all, list_names_matrices = list_names_matrices,
        sumweight = sumweight, transition_affected_env = transition_affected_env, 
        transition_affected_niche = transition_affected_niche, transition_affected_demogr = 
        transition_affected_demogr, env_stochas_type = env_stochas_type)  

#load(paste(modelname, ".rda", sep = ""))  

assign(modelname, BEMDEM, envir = .GlobalEnv)  

save(BEMDEM, file = paste(modelname, ".rda", sep = ""))
# rm(BEMDEM)
# 
# rm(modelname)
  # return(BEMDEM)
         
 }

