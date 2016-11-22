# Data Types
x = 123
y = "hello world"

typeof(x)
typeof(y)

z = Int32(x)
typeof(z)

w = Int32("whatever")

x = BigInt()
typeof(x)


# Arrays
# Array basics
p = [1, 2322433423, 0.12312312, "false", 'c', "whatever"]
p[3]

p[0]
p[100]

p[end]

z = Array(Int64, 3, 4)
println(z)

z = Array(Any, 3, 1)
println(z)

# Accessing multiple elements in an Array
p[1:3]
println(p[1:3])         # to get the first 3 elements
println(p[(end - 2):end])       # to get the last 3 elements

println(p[[1, 4]])      # to get the first and 4th elements
println(p[1, 4])

# Multidimensional Arrays
A = Array(Int64, 3, 4); A[:] = 1:12
println(A)              # elements are filled into columns first
A[2, 3]
A[2, :]         # all elements in the second row
A[:,:]          # equals to A, all elements in a matrix
A[:]            # all elements in a single file, one dimensional Array

# Dictionaries
a = Dict()
# this creates an empty dictionary
b = Dict("one" => 1, "two" => 2, "three" => 3, "four" => 4)
# this creates a dictionary with predefinded entries.
# there's no order in dictionaries

b["three"]
b["five"]

# Basic Commands and Functions
# print(), println()
# type ?print, ?println in the console for help documents
x = 123; y = 345; print(x, " ", y)
print(x, y); print('!')
println(x); println(y); println('!')

# typemax(), typemin()
# Syntax: typemax(DataType), typemin(DataType)
# returns the highest or lowest value resentable by the given numeric DataType
typemax(Int64)
typemin(Int32)
typemax(Float64)

# Collect()
# Syntax: collect(ElementType, X)
1:5
collect(1:5)

# show()
# Syntax: show(X), where X is any data type(usually an array or dictionary)
show([x y])
a = collect(1:50); show(a)

# linspace()
# ?linspace
linspace(0, 10)
show(collect(linspace(0, 10)))
show(collect(linspace(0, 10, 6)))


# Mathematical Functions
# round(), ?round
round(1.5)
round(2.5)
round(3.5)
round(4.5)

round(123.45)
round(100.69)

round(100.69, 1)
round(123.45, -1)
round(Int64, 19.39)

# rand() ~ U(0, 1), randn() ~ N(0, 1)
show(rand(10))
show(rand(5, 3))
show(rand(Int8, 10))
show(rand(Bool, 10))    # returns random Boolean values
show(rand(1:6, 10))     # returns 10 values between 1 and 10, with reputation

show(randn(10))
show(40 + 5 * randn(10))        # ~ N(40, 5)
srand(12345)            # random seed
show(randn(6))
srand(12345)
show(randn(6))          # fixing a random seed will lead to getting the same result every time
srand(12345)
show(10 * randn(10) - 40)
srand(12345)
show(-40 + 10 * randn(10))      # both formula follows N(-40, 10)

# sum()
sum([1, 2, 3, 4])
A = Array(Int64, 3, 4); A[:] = 1:12; show(A)
sum(A)

show(sum(A, 1))         # sum of rows(sum across dimension 1)
show(sum(A, 2))         # sum of columns(sum across dimension 2)

sum([true, false, true, false, true])

# mean()
mean([1, 2, 3])
mean([1.34, pi])
mean([true, false])

show(mean(A, 1))
show(mean(A, 2))

# Array and Dictionary Functions
# in()
x = [23, 1583, 0, 953, 10, -3232, -123]
1234 in x
10 in x

# append!(Array1, Array2), append Array2 to Array1
a = ["some phrase", 1234]; b = [43.321, 'z', false]
append!(a, b); show(a)

# pop!(Dict, Key, default),
z = Dict("w" => 25, "q" => 0, "a" => true, "b" => 10, "x" => -3.34)
pop!(z, "a")
print(z)
pop!(z, "whatever", -1)

# push!(1-D Array, Value)
z = [235, "something", true, -3232.34, 'd']
push!(z, 12345)

# splice!(Array or collection, index, replacement value(optional))
splice!(z, 5)
show(z)
splice!(z, 3, '~')
show(z)

# insert!(Array or collection, index, replacement value
insert!(z, 4, "julia rocks!")
show(z)

# sort(Array, dimension, reverse(default = false), ...) will not change the original array
# sort!(Array, dimension, reverse(default = false), ...) will change the original array
x = [23, 1583, 0, 953, 10, -3232, -123]
show(sort(x))
show(x)         # the origianl array has not been changed
sort!(x); show(x)       # # the origianl array has been changed
sort!(x, rev = true)
show(x)         # from the largest to the smallest

show(sort(["Smith", "Brown", "Black", "Anderson", "Johnson", "Howe", "Holmes"]))

# get(D, K, default value to return if the key is not found in the dictionary)
b = Dict("one" => 1, "two" => 2, "three" =>3, "four" => 4)
get(b, "two", "String not found!")
get(b, "whatever", "String not found!")

# keys(D), values(D)
b = Dict("one" => 1, "two" => 2, "three" =>3, "four" => 4)
keys(b)
show(keys(b))
values(b)
show(values(b))

# length(X), size()
x =[23, 1583, 0, 953, 10, -3232, -123]
length(x)
length(rand(4, 5))      # returns the number of elements in an array
size(rand(4, 5))        # returns the dimension of an array
y = "julia rocks!"
length(y)
size(y)         # size() does not work on a string
size(x)         # returns the value in a tuple

# Miscellaneous Functions
# time()
t = time()

# Conditionals
# if - else
x = 2; y = 1; c = 0; d = 0
if x >=1
        c += 1
else
        d += 1
end
show([c, d])

if x ==2
        c += 1
        if y < 1
                d += 1
        else
                d -= 1
        end
end
show([c, d])

x = 0; c = 0; d = 0
if x > 0
        c += 1
elseif x == 0
        d += 1
else
        println("x is negative")
end
show([c, d])

# Snippet 1
x = 123
if x > 0
        "x is positive"
else
        "x is not positive"
end

# Snippet 2; ternary operator
x = 123
result = x > 0 ? "x is positive" : "x is not positive"

x = -123
result = x > 0 ? "x is positive" : "x is not positive"

 # ternary operator can be nested as well
x = 0
result = x > 0? "x is positive" : x < 0 ? "x is negative" : "x is zero"

# string()
string(2134)
string(1234, true, "Smith", ' ', 53.3)

# map(function, Array)
show(map(length, ["this", "is", "a", "map()", "test"]))

# version()
VERSION

# Operators, Loops, and Conditionals
# Alphanumeric operators(<, >, ==, <=, >=, !=)
"alice" < "bob"
"eve" < "bob"

# Logical operators(&&, ||)
x = 50; y = -120; z = 323
(x > 1) && (x < 100)
(y > 1) && (y < 100)
(z > 1) && (z < 100)
(x > 1) && (y > 1) && (z != 0)

x = 0.1; y = 12.1
(x <= -1) || (x >= 1)
(y <= -1) || (y >= 1)
((x > 1) && (x >1)) || ((x == 0) && (y != 0))

# Loops
# for-loops
s = 0
for i = 1:2:10
        s += i
        println("s = ", s)
end

# while-loop
c = 1
while c < 100
        println(c)
        c *= 2
end

# Break Command
X = [1, 4, -3, 0, -1, 12]
for i in 1:length(X)
        if X[i] == -1
                println(i)
                break
        end
end
