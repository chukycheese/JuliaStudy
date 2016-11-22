cd("C:/dev/julia/JuliaStudy")
pwd()

# Loading Datasets
# CSV files
data = readcsv("magic04.txt")

# Text files
f = open(filename, "r")
lines = readlines(f)
close(f)

f = open(filename, "r")
for line in eachline(f)
  [some code]

end
close(f)


# p.32 Coding and testing a simple machine learning algorithm in Julia
# Algorithm implemetation
# Listing 2.2 An auxilirary function for the impementation of the kNN algorithm.
# This one is responsible for calculating the distance between two points, x and y, represented as vectors.
function distance{T<:Number}(x::Array{T, 1}, y::Array{T, 1})
  dist = 0              # A
  for i in 1:length(x)  # B
    dist += (x[i] - y[i])^2
  end
  dist = sqrt(dist)
  return dist
end
# A: initializedistance variable
# B: repeat for all dimensions of x and y

# Listing 2.3 Another auxiliary function of the implementation of the kNN algorithm
# This one performs classification of a point based on tis distances from the known points of the dataset.
function classify{T<:Any}(distances::Array{Float64, 1}, labels::Array{T, 1}, k::Int)
        class = unique(labels)                  # A
        nc = length(class)                      # B
        indexes = Array(Int, k)                 # C
        M = typemax(typeof(distances[1]))       # D
        class_count = Array(Int, nc)
        for i in 1:k
                indexes[i] = indmin(distances)
                distances[indexes[i]] = M       # E
        end
        klabels = labels[indexes]

        for i in 1:nc
                for j in 1:k
                        if klabels[j] == class[i]
                                class_count[i] += 1
                                break
                        end
                end
        end
        index = indmax(class_count)
        return class[index]
end
# A: find all the distinct classes
# B: number of classes
# C: initialize vector of indexes of the nearest neighbors
# D: the largest possible number that this vector can have
# E: make sure this element is not selected again

# Listing 2.4 The main function(wrapper) of the implementation of the kNN algorithm.
function apply_kNN{T1<:Number, T2<:Any}(X::Array{T1, 2}, x::Array{T2, 1}, Y::Array{T1, 2}, k::Int)
        N = size(X, 1)                          # A
        n = size(Y, 1)                          # B
        D = Array(Float64, N)                   # C
        z = Array(typeof(x[1]), n)              # D
        for i in 1:n
                for j in 1:N
                        D[j] = distance(X[j, :], Y[i, :])
                end
                z[i] = classify(D, x, k)
        end
        return z
end

for i in 1:n
        for j in 1:n
                D[j] = distance(X[j, :], Y[i, :])
        end
end
ndims(D)
size(D)
ndims(x)
size(x)
classify(D, x, 5)

M = typemax(typeof(D[1]))
indexes = Array(Int, 5)
indexes
for i in 1:5
        indexes[i] = indmin(D)
        D[indexes[i]] = M
end
indexes
indmin(D)

# A: number of known data points
# B: number of data points to classify
# C: initialize distance vector
# D: initialize labels vector (output)

# p.38 Algorithm testing
data = readcsv("magic04.txt")

I = map(Float64, data[:, 1:(end - 1)])  # A
O = data[:, end]                        # B

# A: take all the columns of the data matrix, aprot from the last one andconvert
#    everything into a Float. Result = 10-dimArray of Float numbers
# B: take only the lastcolumnof the data matrix.
#    Result = 1-dim Array

# Listing 2.5 Code for testingthe implementation of the kNN algorithm,
# using the preloaded Magic dataset.
N = length(O)                   # A
n = round(Int64, N/2)           # B
R = randperm(N)                 # C
indX = R[1:n]                   # D
X = I[indX, :]                  # E
x = O[indX]                     # F
indY = R[(n+1):end]             # G
Y = I[indY, :]                  # E
y = O[indY]
# A: number of data pints in the whole dataset(which is equivalent to the lenght of array O)
# B: the half of the above number
# C: a random permutation of all the indexes(essential for sampling)
# D: get some random indexes for the training set
# E: input values for training and testing set respectively
# F: target values for training and testing set respectively
# G: some random indexes for the testing set

z = apply_kNN(X, x, Y, 5)

# p.39 Saving your workspace into a data file
# Saving data into delimited files
writedlm("/data/mydata.dat", A, ";")

writecsv("/data/mydata.dat", A)

# Saving data into Native Julia format; other libraries are needed
# Pkg.add("HDF5")
# Pkg.add("JLD")
using JLD
f = open("mydata.jld", "w")
@write f A      # write variable A into a file f
@write f b      # write variable b into a file f
close(f)
# Alternative way of writing into .jld fformat
save("mydata.jld", "var_A", A, "var_B", b)
# if you wish to save all the variables in the workspace,
save("mydata.jld")
# to retrive the data stored in a .jld file,
D = load("mydata.jld")
# to access only a particular variable in a .jld file
b = load("mydata.jld", "var_b")
# to access the variables stored in a .jld file partially
f = jldopen("mydata.jld", "r")
dump(f, 20)     # reading the first 20 variables from the file

# Saving data into text files
f = open("/data/mydata.txt", "w")
write(f, SomeStringVariable)
write(f, AnotherStringVariable)
# ...
close(f)
# to save a string data to a data file which is already open
A = [123, 34423.23, -322, 981238651928736918263]
f = open("p43example.txt", "w")
for a in A
        write(f, string(a, "\n"))
end
close(f)
