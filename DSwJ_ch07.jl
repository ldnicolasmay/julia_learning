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

# Perform a Chi squared test using R function
x = Int[10, 39, 50, 24]
R"chisq.test($x)"
println(R"chisq.test($x)")
println(R"mean($x)")

# Since `$` is meaningful in R, some care has to be taken
# when using it
index = [1, 2, 5]
println(R"MASS::crabs$index") # <- this `index` isn't the Julia `index`
                            # it's the index field of the `crabs` dataset
# Here's how to use the Julia `index`
println(R"MASS::crabs[$index, ]")

# Pkg.add("Distributions")
# Pkg.add("StatsBase")
# Pkg.add("Random")

using RCall, Distributions, StatsBase, Random
Random.seed!(636)

# Simulate data for logistic regression
N = 1000
x1 = randn(N)
x2 = randn(N)
x0 = fill(1.0, N)

# A linaer function of x1 and x2
lf = x0 + 0.5*x1 + 2*x2

# The inv-logit function of lf
prob = 1 ./ ( x0 + exp.(-lf))

# Generate y
y = zeros(Int64, N)
for i = 1:N
    y[i] = rand(Binomial(1, prob[i]), 1)[1]
end

# Run code in R
# Note that x.3 is generated in R (randomly from a normal distribution) but
# x1 and x2 are sent from Julia to R
modelsum = R"""
set.seed(39)
n <- length($x1)
df <- data.frame(x.1 = $x1, x.2 = $x2, y = $y, x.3 = rnorm(n))
fit1 <- glm(y ~ x.1 + x.2 + x.3, data = df, family = "binomial")
summary(fit1)
"""
println(modelsum)

# Odds ratios for x1 and x2, respectively
exp(0.46455)
exp(1.86382)
