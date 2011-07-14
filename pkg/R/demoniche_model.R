demoniche_model <-
function(modelname, Niche, Dispersal, repetitions, foldername)  
{

BEMDEM <- get(modelname, envir = .GlobalEnv)   #assign("BEMDEM", get(modelname))     

#load(paste(modelname, ".rda", sep = ""))   
   #  rm(Hmontana)
 require(sp)
 require(popbio)
 require(lattice)
 
#### Create vectors ############################################################                                     
Projection <- array(0, # Projection is where all the results go
          dim = 
          c(BEMDEM$no_yrs, length(BEMDEM$stages), nrow(BEMDEM$Niche_ID), length(BEMDEM$years_projections))
          , 
          dimnames = 
          list(paste( "timesliceyear", 1:BEMDEM$no_yrs, sep="_"), c(paste(BEMDEM$stages)), 
          BEMDEM$Niche_ID[,"Niche_ID"], paste(BEMDEM$years_projections))
           )

eigen_results <- vector(mode = "list" , length(BEMDEM$list_names_matrices))  
          names(eigen_results) <- unlist(BEMDEM$list_names_matrices)
          
yrs_total <- BEMDEM$no_yrs * length(BEMDEM$years_projections)

population_sizes <- array(NA,       # per matrix!
          dim = c(yrs_total, length(BEMDEM$list_names_matrices), repetitions), 
          dimnames = list(paste("year", 1: yrs_total, sep = ""), BEMDEM$list_names_matrices, paste("rep", 1:repetitions, sep = "_")))
               
population_results  <- array(1:200,   # for all matrices!
          dim =
           c(yrs_total, 3, length(BEMDEM$list_names_matrices))
           ,
          dimnames = 
          list( paste("year", 1: yrs_total, sep = ""), 
          c("Meanpop", "EMA", "SD" ),
           paste(BEMDEM$list_names_matrices))
          )   

metapop_results <- array(NA,       # per matrix!
          dim = c(yrs_total, length(BEMDEM$list_names_matrices), repetitions), 
          dimnames = list(paste("year", 1: yrs_total, sep = ""), BEMDEM$list_names_matrices, paste("rep", 1:repetitions, sep = "_")))
    
simulation_results <- array(1:200, 
          dim = c(length(BEMDEM$list_names_matrices), 6), 
          dimnames = 
          list(BEMDEM$list_names_matrices, 
      c("lambda", "stoch_lambda","mean_perc_ext_final", "initial_population_area", "initial_pop", "mean_final_pop")
      )  )

              # original area occupied
       simulation_results[,"initial_population_area"] <- 
                    sum(BEMDEM$Populations_area) 
              # original population size            
       simulation_results[,"initial_pop"] <- 
                    sum((colSums(BEMDEM$n0_all) * BEMDEM$sumweight))
                  
   
population_Niche <- rep(1, nrow(BEMDEM$Niche_ID))

dir.create(paste(getwd(), "/", foldername, sep = ""), showWarnings = FALSE)

#### Start repetitions #########################################################
  
for (rx in 1:repetitions)           # tx = 1   rx = 1
      {                               
         print(paste("Starting projections for repetition:", rx), quote = FALSE)
       
       
    for(mx in 1:length(BEMDEM$list_names_matrices))  # selects two matrices for the simulations   mx =1
    {
         print(paste("Projecting for scenario/matrix:", (BEMDEM$list_names_matrices)[mx]), quote = FALSE)
      
         yx_tx <- 0 # restart counter     
         
 # this selects two matrices, the first basic matrix and the projection one mx =1  
     Matrix_projection <- cbind(BEMDEM$matrices[,1], (BEMDEM$matrices[, mx]))
        
 # this selects two standard deviation matrices, the first basic matrix and the projection one (column mx) 
    if(ncol(BEMDEM$matrices_var) > 1){
           Matrix_projection_var <- cbind(BEMDEM$matrices_var[,1], (BEMDEM$matrices_var[, mx]))                                                     
      } else {
          Matrix_projection_var <- cbind(BEMDEM$matrices_var[,1], (BEMDEM$matrices_var[, 1]))  
      }
      
     prev_mx <- rep(1, times = yrs_total + 1)
       
	 for(tx in 1:length(BEMDEM$years_projections)) # selects which time-slice of the simulation tx = 2
            {
                          
                                                 if (Niche == TRUE){ # Niche values
                                                         population_Niche <- BEMDEM$Niche_values[, tx]   
                                                       } 
                  for(yx in 1:BEMDEM$no_yrs)                                  
                        {

                              yx_tx <- yx_tx + 1 # add one year to counter
                            
####################################### PATCH PROJECTION when tx = 1 ###########     tx=1  px=1   tx = 2               
################################################################################     yx=2  yx = 1
                      
                      if(tx == 1 && yx == 1)  
                              {
                                   n0s <- BEMDEM$n0_all[rowSums(BEMDEM$n0_all) > 0,] # take stage vector from intial population, where over zero
                                   n0s_ID <- which(rowSums(BEMDEM$n0_all) > 0) # which populations/rows are above zero
                                 } else  {           # Second year running the model   
                                    if(tx != 1 && yx == 1){ # when going to next time step, yx == 1
                                    
                                    n0s <- t(Projection[BEMDEM$no_yrs,, colSums(Projection[BEMDEM$no_yrs,,,tx-1]) > 0, tx-1])
                                    n0s_ID <- which(colSums(Projection[BEMDEM$no_yrs,,,tx-1]) > 0)
                                    
                                    BEMDEM$Niche_ID[colSums(Projection[BEMDEM$no_yrs,,,tx-1]) > 0, 2]
                                   } else  { 
                                        # take population from previous year, same time period  
                                        n0s <- t(Projection[yx-1,, colSums(Projection[yx-1,,,tx]) > 0,tx])
                                        n0s_ID <- which(colSums(Projection[yx-1,,,tx]) > 0)
                                      }        
                                } # end if tx == 1 && yx == 1  
                                            # n <- c(10,5,5,5,5,5)
                           population_Niche_short <- population_Niche[n0s_ID] 
                                    
              # run fcn for each population px=1        
                     if (nrow(n0s) > 0) { 
                     
                     for(px in 1:nrow(n0s))  {   # px = 1                  
                             n <- as.vector(n0s[px,]) 
                              
                       #  source('demoniche_population.r')
                            # if (sum(n) > 0) {      
                          
				
                 Projection[yx,,n0s_ID[px],tx]    <- 
                      demoniche_population(Matrix_projection = Matrix_projection, Matrix_projection_var = Matrix_projection_var, 
                          n = n, populationmax = BEMDEM$populationmax_all[px], onepopulation_Niche = population_Niche_short[px],
                          sumweight = BEMDEM$sumweight, prob_scenario = BEMDEM$prob_scenario, noise = BEMDEM$noise, prev_mx = prev_mx, 
                          transition_affected_demogr = BEMDEM$transition_affected_demogr, transition_affected_niche = BEMDEM$transition_affected_niche, 
                          transition_affected_env = BEMDEM$transition_affected_env, env_stochas_type = BEMDEM$env_stochas_type, yx_tx = yx_tx) 
                           
                                    #     } # end if n > 0 
                                         } # end if n0s > 0            
                         } # end px for
                           
                         # which patches persist since last timestep (including seeds)?  yx = 1 tx = 8
           metapop_results[yx_tx,mx,rx] <- 
            length(intersect(which(colSums(Projection[yx,,,tx]) > 1), n0s_ID))
################################################################################ 

##################### DISPERSAL FOR ALL PATCHES ####################                              
# Calculate dispersal for one repetition (rx), one matrix (mx), one time period(tx), and one year                     
# and all populationes.   
                 #  load('/noCC_nodispersal/Projection1_meanmatrix.rda')
                           #   print(paste(Projection[yx,1,,tx]))                        
                    if(sum(Projection[yx,1,,tx]) > 0)   # break
                        {                                 
                       if(Dispersal == TRUE) 
                          {                             
                                     
                                         if (Niche == TRUE){ 
                                                population_Niche <- BEMDEM$Niche_values[, tx]   
                                              } 
                                    
                                    #  source("demoniche_dispersal.r")             
                             disp <- 
                             demoniche_dispersal(seeds_per_population = Projection[yx,1,,tx], 
                                      fraction_LDD = BEMDEM$fraction_LDD, 
                                      dispersal_probabilities = BEMDEM$dispersal_probabilities, 
                                      dist_latlong = BEMDEM$dist_latlong, neigh_index = BEMDEM$neigh_index, 
                                      fraction_SDD = BEMDEM$fraction_SDD) # T                
                             
                            Projection[yx,1,,tx] <- disp 
                                   
                             } # end Dispersal if
                            } # end Dispersal if
################################################################################

        # save the results from one run
            population_sizes[yx_tx,mx,rx] <- sum(rowSums(Projection[yx,,,tx]) * BEMDEM$sumweight)
                 
              } # end yx                                        
             
        } # end tx loop  
     
             save(Projection, file = paste(getwd(), "/", foldername,  
                "/Projection_rep", rx, "_", BEMDEM$list_names_matrices[mx], ".rda", sep = ""))    
         
          save(population_sizes, file = paste(getwd(), "/", foldername,  
                                       "/population_sizes", ".rda", sep = "")) 
           
               # PLOTS of spatial occupancy from the last repetition  yx = 1
                  pop <- data.frame(cbind(BEMDEM$Niche_ID[,2:3], 
                      (colSums(Projection[yx,,,] * BEMDEM$sumweight))))
                       
                    form <- as.formula(paste(paste(colnames(pop)[-c(1:2)],collapse="+"),"X+Y",sep="~"))    
                                               
			       jpeg(file = paste(getwd(), "/", foldername, "/map_",
                            BEMDEM$list_names_matrices[mx], ".jpeg", sep = ""))
                    print(levelplot(form, pop, col.regions=rev(heat.colors(100)), allow.multiple = TRUE, 
                            main = paste(foldername, BEMDEM$list_names_matrices[mx], sep = "_")))
                        dev.off() 
		
                       
   }     # end mx loop

  } # end rx loop
  
    #################################################
         # extra loop to calculate EMA, mean, eigenvalues, etc   
  print("Calculating summary values", quote = FALSE)
   
         for(mx in 1:length(BEMDEM$list_names_matrices)) 
            {       
      # for 'eigen_results' object for each matrix. 
             eigen_results[[mx]] <- c(eigen.analysis(matrix(BEMDEM$matrices[, mx], 
                        ncol = length(BEMDEM$stages), byrow = FALSE)), 
                       LTRE = list(matrix(LTRE(matrix(BEMDEM$matrices[, 2], 
                         ncol = length(BEMDEM$stages), byrow = FALSE), 
                                   matrix(BEMDEM$matrices[, 1], 
                                   ncol = length(BEMDEM$stages), byrow = FALSE)), 
                                   nrow = length(BEMDEM$stages)))) 
                   
            simulation_results[mx,"lambda"] <- eigen_results[[mx]]$lambda1
  
            simulation_results[mx,"stoch_lambda"] <- 
                 stoch.growth.rate(list(matrix(BEMDEM$matrices[, 1], 
                 ncol = length(BEMDEM$stages)), matrix(BEMDEM$matrices[, mx], 
                 ncol = length(BEMDEM$stages))), prob = NULL, maxt = 50000, 
                 verbose = FALSE)$sim
            
            simulation_results[mx, "mean_final_pop"] <- 
                              mean(population_sizes[yrs_total,mx,]) 
                   # Final mean percentage of patches extinct
            simulation_results[mx, "mean_perc_ext_final"] <- 
                              mean(metapop_results[yrs_total,mx,]) 
                            #  print(   mean(metapop_results[yrs_total,mx,]))   
          #  simulation_results[mx, "mean_area 

                   for(yx_tx in 1:yrs_total) 
                       {   
         # mean of all repetitions            
    population_results[yx_tx, "Meanpop", mx] <- mean(population_sizes[yx_tx,mx,])
         # sd of all repetitions            
    population_results[yx_tx, "SD", mx] <- sd(population_sizes[yx_tx,mx,])       
         # EMA, Expected Minimum Abundance (minimum abundance) 
    population_results[yx_tx, "EMA", mx] <- min(population_sizes[yx_tx,mx,]) 
                        }       

  save(simulation_results, file =  
        paste(getwd(), "/", foldername, "/simulation_results.rda", sep = ""))
  
  save(metapop_results, file =  
        paste(getwd(), "/", foldername, "/metapop_results.rda", sep = ""))
  
  save(eigen_results, file = 
                   paste(getwd(), "/", foldername, "/eigen_results.rda", sep = "")) 
   
   write.table(simulation_results, sep = ",", file = 
    paste(getwd(), "/", foldername, "/simulation_results.csv", sep = ""), col.names = NA)         
    
   jpeg(file = paste(getwd(), "/", foldername, "/EMA_",
        BEMDEM$list_names_matrices[mx], ".jpeg", sep = ""))
    plot(population_results[,"EMA",mx], ylim = c(0, max(population_results[,"EMA",mx])), 
        main = paste("EMA", BEMDEM$list_names_matrices[mx], foldername, sep = "_"),type = "l",  
        xlab = "Year", ylab = "Population") 
    dev.off()  
   
    
          } # end mx loop number 2, for eigenvalues. 
       #########################################################
   
    
    print("    All repetitions completed!", quote = FALSE)

return(population_results)
  save(population_results, file = paste(getwd(), "/", 
        foldername, "/Population_results.rda", sep = ""))  
 
}     # end fcn

