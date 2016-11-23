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
# mode를 찾는 함수
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
# 입력된 String 에 포함된 단어의 갯수를 세는 함수
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
# 입력된 String 에 포함된 character 의 갯수를 반환하는 함수
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
# 숫자 Array 를 받아서 Character Vector 로 반환해주는 함수
function num_to_string{T<:Number}(X::Array{T})::Vector{Char}
        whole_string = join(X, "")
        numbers = []
        for i in collect(whole_string)
                if i in "1234567890"
                        push!(numbers, i)
                end
        end

        return numbers
end

@test num_to_string([123, 321]) == ['1', '2', '3', '3', '2', '1']
@test num_to_string([123, 456]) == ['1', '2', '3', '4', '5', '6']
@test num_to_string([1.23, 45.6]) == ['1', '2', '3', '4', '5', '6']
@test num_to_string([-1.23, 45.6]) == ['1', '2', '3', '4', '5', '6']

# 입력된 숫자 Array 에 있는 0-9까지의 갯수를 Dictionary 형태로 반환해주는 함수
function counting_nums{T<:Number}(X::Array{T})
        x = num_to_string(X)
        cm = Dict{Char, Int}()
        for v in x
                cm[v] = get(cm, v, 0) + 1
        end
        return cm
end

# Pkg.add("StatsBase")

# using Base.Test
@test counting_nums([1.2, 2.3]) == Dict('1' => 1, '2' => 2, '3' => 1)
@test counting_nums([1.5, 2.7]) == Dict('1' => 1, '2' => 1, '5' => 1, '7' => 1)
@test counting_nums([1.5 2.7; -1.2 2.2]) == Dict('1' => 2, '2' => 4, '5' => 1, '7' => 1)

function most_common_digit{T<:Number}(num_array::Array{T})
        num_dist = counting_nums(num_array)
        most_freq_num_ind = indmax(values(num_dist))
        dict_keys = collect(keys(num_dist))
        return dict_keys[most_freq_num_ind]
end

most_common_digit([1.5 2.7; -1.2 2.2])

@test most_common_digit([1.5 2.7; -1.2 2.2]) == '2'
@test most_common_digit([1.5 2.7; -1.1 1.1]) == '1'
@test most_common_digit([1.5123 2.74123; -1.333 2.333]) == '3'


Pkg.add("UnicodePlots")
using UnicodePlots

# counting_nums() 에서 반환되는 Dictionary 를 오름차순으로 정렬해주는 함수
function dict_sort(X::Dict)::Tuple{Vector{String}, Vector{Int}}
        dict_key = sort(collect(keys(X)))
        dict_values = []
        for k in dict_key
                push!(dict_values, X[k])
        end
        return (map(string, dict_key), dict_values)
end

# 숫자의 Array를 받아서 0-9까지의 숫자로 반환해주는 함수
function num_to_int{T<:Number}(X::Array{T})::Vector{Int}
        whole_string = join(X, "")
        numbers = []
        for i in collect(whole_string)
                if i in "1234567890"
                        push!(numbers, parse(Int, i))
                end
        end

        return numbers
end

histogram(num_to_int([big(pi)]))

# pi를 받아서 0-9까지 각 숫자의 갯수를 세어보자
function count_pi(n::BigFloat)
        println(n)
        big_num = num_to_int([n])
        big_num_dict = counting_nums(big_num)
        (k, v) = dict_sort(big_num_dict)
        println(barplot(k, v))
        println(histogram(big_num, bins = 10))
end

count_pi(big(pi))
