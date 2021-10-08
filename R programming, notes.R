# Additional notes for Data Vis KORS
# Rick Scavetta 
# 08 Oct 2020
# Notes on environments and accesing information

# The %>% Operator ----

# LHS %>% RHS - Forward pipe operator 
# Take the LHS (data frame) and put it in the first argument position (1) of the function on the RHS

# iris %>% 
#   ggplot(aes(Sepal.Length, Sepal.Width, col = Species))

# Attaching objects and loading packages ----

# Typical: Load an entire packages 

# We load packages using library()
library(ggplot2)
# This will make all functions & datasets in the specifiec package (here ggplot2) 
# available to our global environtment (or "workspace"), i.e. where we're executing our commands
# More subtly it creates an environment that contains all the objects defined by the package
# and places it in a long chain of environments nested environments. When we call a function in that 
# package, R looks in the global environment and if it doesn't find it, it keeps working its way
# backwards through these environments until it does find it.

# you can see this chain of environments here:
library(rlang)
env_parents(current_env())

# We can skip this and call a specific function using the :: operator
ggplot2::geom_point()

# NOT RECOMMENDED ************
# For objects you can you may see this:
attach(PlantGrowth) # but avoid this

# It does the same thing as library but for objects (here PlantGrowth, a data.frame). 
# An envrionment is created and each named elemet of PlantGrowth is an object in this environment
env_parents(current_env())

# Thus you can call the following and it will find them in that environment
weight
group

# This opens up a lot of room for conflicts between names and confusion

# instead use typically use the $ notation
# $ is to objects, as :: is to packages
PlantGrowth$weight
PlantGrowth$group

# In the tidyverse, $ notation is not necessary. 
# Tidyverse functions, e.g. ggplot() first looks 
# int he data frame specficied (typically as the
# first argument of the function, see  %>% above)
# and then it looks in the environments.
# i.e. tthey don't make new environments.

