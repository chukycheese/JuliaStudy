# Listening to the Data
# Packages used in this chapter
Pkg.add("StatsBase")
Pkg.add("HypothesisTests")
Pkg.add("Gadfly")

using StatsBase
using HypothesisTests
using DataFrames
using Gadfly

cd("C:/dev/Julia/JuliaStudy/")

# Computing Basic Statistics and Correlations
X = readcsv("magic04.csv")
X = X[1:end - 1, :]

# Preparing the data of magic04 for exploration
N, n = size(X)
I = Array(Float64, N, n - 1)
O = X[:, end]
for j in 1:(n - 1)
        for i in 1:N
                I[i, j] = Float64(X[i, j])
        end
end

# Variable summary
for i in 1:size(I, 2)
        describe(I[:, i])
end

# skewness
for i in 1:size(I, 2)
        println("The skewness of column ", i, " is : ", skewness(I[:, i]))
end

# using summarystats() function for descriptive Statistics
println("The mean of the first column is : ", summarystats(I[:, 1]).mean)
println("The minimum of the first column is : ", summarystats(I[:, 1]).min)
println("The 0.25 quantile of the first column is : ", summarystats(I[:, 1]).q25)
println("The median of the first column is : ", summarystats(I[:, 1]).median)
println("The 0.75 quantile of the first column is : ", summarystats(I[:, 1]).q75)
println("The maximum of the first column is : ", summarystats(I[:, 1]).max)

# Correlations among variables
C = cor(I)

# Plots
# Preparing data for visualization
varnames = ["fLength", "fWidth", "fSize", "fConc", "fConcl",
"fAsym", "fM3Long", "fM3Trans", "fAlpha", "fDist", "class"]

df = readtable("magic04.csv", header = false)
df = df[1:(end - 1), :]

old_names = names(df)
new_names = [Symbol(varnames[i]) for i in 1:length(varnames)]

old_names
new_names
varnames

for i in 1:length(old_names)
        rename!(df, old_names[i], new_names[i])
end

println(head(df))

# Bar Plots
plot(df, x = "class", Geom.bar, Guide.YLabel("count"),
Guide.Title("Class distribution for magic04 dataset"))

plot(df, x = :class, Geom.bar, Guide.YLabel("count"),
Guide.Title("Class distribution for magic04 dataset"))

# Line Plots
plot(df, y = :fSize, Geom.line, Guide.XLabel("data point"),
Guide.YLabel("fSize"), Guide.Title("fSize of various data points in magic04 dataset"))

# Scatter Plots
# Basic scatter plot
plot(x = df[:fM3Long], y = df[:fM3Trans], Geom.point,
Guide.XLabel("fM3Long"), Guide.YLabel("fM3Trans"),
Guide.Title("Relationship between fM3Trans & fM3Long"))

# Scatter plots using the ouput of t-SNE algorithm
using TSne
include("C:/dev/Julia/JuliaStudy/Code files-selected/normalize.jl")
include("C:/dev/Julia/JuliaStudy/Code files-selected/sample.jl")
X = normalize(X, "stat")
X, O = sample(X, O, 2000)
Y = tsne(X, 2)
plot(x = Y[:, 1], y = Y[:, 2], color = O)

# Histogram
p = plot(x = df[:fAlpha], Geom.histogram,
Guide.XLabel("fAlpha"), Guide.YLabel("frequency"))

p = plot(x = df[:fAlpha], Geom.histogram(bincount = 20),
Guide.XLabel("fAlpha"), Guide.YLabel("frequency"))

# Exporting a plot to a file
myplot = plot(x = [1, 2, 3, 4, 5], y = [2, 3.5, 7, 7.5, 10])
draw(PNG("myplot.png", 5inch, 2.5inch), myplot)

# Hypothesis Testing
# t-test
ind1 = findin(df[:class], ["g"])
ind2 = findin(df[:class], ["h"])

x_g = df[:fDist][ind1]
x_h = df[:fDist][ind2]

v_g = var(x_g)
v_h = var(x_h)

pvalue(UnequalVarianceTTest(x_g, x_h))

# Chi-Square test
x_g = df[:fLength][ind1]
x_h = df[:fLength][ind2]





### Case Study: Exploring the OnlineNewPopularity Dataset
pwd()
df = readtable("C:\\dev\\Julia\\JuliaStudy\\Data files-selected\\OnlineNewsPopularity\\OnlineNewsPopularity.csv", header = true)
show(head(df))

# Variable stats
Z = names(df[2:end])
for z in Z
        X = convert(Array, df[Symbol(z)])
        println(z, "\t", summarystats(X))
end

# Normalize variables
for z in Z
        X = df[Symbol(z)]
        Y = (X - mean(X)) / std(X)
        df[Symbol(z)] = Y
end

n = length(Z)
C = Array(Any, n, 2)
for i in 1:n
        X = df[Symbol(Z[i])]
        C[i, 1] = Z[i]
        C[i, 2] = cor(X, df[:shares])
end

# visualization
for i in 1:n
        plot(x = df[Symbol(Z[i])], Geom.histogram, Guide.XLabel(string(Z[i])),
        Guide.YLabel("frequency"))
        plot(x = df[Symbol(Z[i])], y = df[:shares], Geom.point,
        Guide.XLabel(string(Z[i])), Guide.YLabel("shares"))
end

# Hypotheses
X = df[1:end-1]
Y = df[end]

a = 0.01
N = length(Y)
mY = mean(Y)
ind1 = (1:N)[Y .>= mY]
ind2 = (1:N)[Y .< mY]
A = Array(Any, 59, 4)
for i in 1:59
        X = convert(Array, df[Symbol(Z[i])])
        X_high = X[ind1]
        X_low = X[ind2]
        var_high = var(X_high)
        var_low = var(X_low)
        if abs(2 * (var_high - var_low) / (var_high + var_low)) <= 0.1
                p = pvalue(EqualVarianceTTest(X_high, X_low))
        else
                p = pvalue(UnequalVarianceTTest(X_high, X_low))
        end
        A[i, :] = [i, Z[i], p, p < a]
        if p < a
                println([i, "\t", Z[i]])
        end
end
