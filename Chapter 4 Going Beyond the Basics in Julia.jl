# String Manipulation
q = "Learning the ropes of Julia"
q[14:18]
q[23]
q[[1, 6, 10, 12]]       # A
#
"""A: note that the outer set of brackets are for referncing the q variable,
while the inner ones are for dfining the array of indexes(characters) to be
accssed in that variable. If this seems confusing, try breaking it up into two parts:
indexes = [1, 6, 10, 12] and q[indexes]
"""

# split(String, Separator)
s = "Winter is coming!"
show(split(s))          # default separator is ' ', a whitespace
s = "Julia"
show(split(s, ""))

# join(Array, connector string)
z = [235, "something", true, -3232.34, 'd', 12345]
join(z, " ")
join(z)     # this is same as join(z, "")

# Regex functions(regular expression functions)
# Syntax: r"re"
pattern = r"([A-Z])\w+" # re for all capital letters in Latin based languages

# ismatch(Re, String)
s = "The days of the week are Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, and Sunday."
p = r"([A-Z])\w+"
ismatch(p, s)
ismatch(p, "some random string withouth any capitalized words in it")

# match(Re, string, index)
m = match(p, s)
m.match
m.offset

# matchall(Re, string)
matchall(p, s)
show(matchall(p, s))

# eachmatch(Re, string)
eachmatch(p, s)
for m in eachmatch(p, s)
        println(m.match, " - ", m.offset)
end

# Custom Functions
res(x::Array) = x - mean(x)
A = Array(Int8, 4, 5); A[:] = 1:20
show(res(A))

# Anonymous Functions
X = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
mx = mean(X)
show(map(x -> x - mx, X))

# Multiple dispatch, the function with the same name which takes different input variables will work differently
res(x::Number) = x
show(res(5))
show(res([1, 2, 3, 4, 5]))

# Function example
function hdist(X::AbstractString, Y::AbstractString)
        # Hamming Distance between two strings
        lx = length(X)
        ly = length(Y)
        if lx != ly
                retrun -1
        else
                lettersX = split(X, "")
                lettersY = split(Y, "")
                dif = (lettersX .== lettersY)
                return sum(dif)
        end
end

hdist("happy", "hurry")

methods(median)

# Implementing a Simple Algorithm
function skewness_type(X::Array)
        X = X[:]
        M = median(X)
        m = mean(X)
        if m > M
                output = "Positive"
        elseif m < M
                output = "Negative"
        else
                output = "Balanced"
        end
        return output
end

skewness_type([1, 2, 3, 4, 5])
skewness_type([1, 2, 3, 4, 100])
skewness_type([-100, 2, 3, 4, 5])

A = rand(Int64, 5, 4)
# to get the function work in matrices, make them into 1-D Array in the function
skewness_type(A)

# Creating A complete Solution
function mode{T<:Any}(X::Array{T})
        ux = unique(X)
        n = length(ux)
        z = zeros(n)
        for x in X
                ind = findin(ux, x)
                z[ind] += 1
        end
        m_ind = findmax(z)[2]
        return ux[m_ind]
end

function missing_values_indexes{T<:Any}(X::Array{T})
        ind = []
        n = length(X)
        for i in 1:n
                if isempty(X[i])
                        push!(ind, i)
                end
        end
        return ind
end

function feature_type{T<:Any}(X::Array{T})
        n = length(X)
        ft = "Discreet"
        for i in 1:n
                if length(X[i]) > 0
                        tx = string(typeof(X[i]))

                        if tx in ["ASCIIString", "Char", "Bool"]
                                ft = "Discreet"
                                break
                        elseif contains(tx, "Float")
                                ft = "Continuous"
                        end
                end
        end
        return ft
end

function main{T<:Any}(X::Array{T})
        N, n = size(X)
        y = Array(T, N, n)
        for i in 1:n
                F = X[:, i]
                ind = missing_values_indexes(F)
                if length(ind) > 0
                        ind2 = setdiff(1:N, ind)
                        if feature_type(F) == "Discreet"
                                y = mode(F[ind2])
                        else
                                y = median(F[ind2])
                        end
                        F[ind] = y
                end
                Y[:, i] = F
        end
        return Y
end

# p.99 Problem 3
function mode{T<:Any}(X::Array{T})
        if typeof(X) != "Arr"
        ux = unique(X)
        n = length(ux)
        z = zeros(n)
        for x in X
                ind = findin(ux, x)
                z[ind] += 1
        end
        m_ind = findmax(z)[2]
        return ux[m_ind]
end

# p.99 Problem 4
function count_words(X::AbstractString)
        split_words = split(X, " ")
        return length(split_words)
end
count_words("how many words does this have")

using Base.Test
@test count_words("one") == 1
@test count_words("two words") == 2
@test count_words("This has 4 words") == 4
@test count_words("is number considered as word 1 2 3 4 5") == 10
@test count_words("thiswillbelongasswordbutstillone") == 1

# p.99 Problem 5
function counts_chars(X::AbstractString)
        spaces = 0
        characters = 0
        len = length(X)
        splitted_string = split(X, "")
        for i in 1:len
                if splitted_string[i] == " "
                        spaces += 1
                else
                        characters += 1
                end
        end
        return characters / len
end


@test counts_chars("Test1") == 1
@test counts_chars("     ") == 0
@test counts_chars("tesT2 ") == 5/6
@test counts_chars("This is 4th TEST!!!  ") == 16/21
@test counts_chars("1234 6789 ") == 8/10

# p.99 Problem 6
function counting_nums{T<:Numbers}(X::Array{T})



end



A = randn(2, 2)
num_string = join(map(string, A))
show(num_string)
p = r"[0-9]\w+"
nums = join(matchall(p, num_string))
numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
num_zeros = 0
num_dist = Dict()
for i in 1:length(num)
        if num[i] == 0


X = [1, 2, 3, 1, 2, 1, 1, 1]
ux = unique(X)
n = length(ux)
z = Dict()
z.keys = ux
z[1]
for x in X
        ind = findin(ux, x)
        z[ind] += 1
end

println(z)
