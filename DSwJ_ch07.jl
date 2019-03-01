# DSwJ_ch07.jl

# 7.1 Accessing Datasets

## RDatasets.jl

using Pkg
Pkg.add("RDatasets")

using RDatasets
rds = RDatasets.datasets();

# look for crabs in available datasets
crab_res = filter(x -> occursin("crab", x[:Dataset]), rds);
print(crab_res)
# So the "crabs" dataset is in the MASS package

crabs = dataset("MASS", "crabs")
print(crabs[1:5, :])


## RData.jl

Pkg.add("RData")

using RData

# Read in wine data (in two steps)
wine = RData.load("./wine.rds");
println(typeof(wine))
println(wine[1:5, 1:6])

# Read in coffee data (in two steps)
coffee = RData.load("./coffee.rds");
println(typeof(coffee))
println(coffee[1:5, 1:6])


## 7.2 Interact with R

Pkg.add("RCall")

Pkg.build("RCall")

using RCall

x = Int[10, 39, 50, 24]
R"chisq.test($x)"
println(R"chisq.test($x)")
println(R"mean($x)")
