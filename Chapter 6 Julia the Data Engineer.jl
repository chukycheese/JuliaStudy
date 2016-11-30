using DataFrames, DataArrays
df = DataFrame()    # an empty data frame



da = DataArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
# if you have a couple of data arrays; da1, da2
da1 = DataArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
da2 = DataArray([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])

df[:var1] = da1    # :var1 - the column name for da1
df[:var2] = da2    # :var2 - the column name for da2
show(df)

# Data Frames Basic
# Variable names in a data frame
names(df)    # shows the names of variables, similar to colnames

# renaming the names for variables
rename!(df, [:var1, :var2], [:length, :width])
show(names(df))

# here's another way of doing it
rename!(df, :width, :height)    # change the name :width to :height
show(names(df))

# Accessing particular variables in data frames
show(df[:length])

# here's another way
var_name = "height"
show(df[Symbol(var_name)])

Symbol(var_name) == :height

df[1], df[2]    # indexing columns from data frames

showcols(df)

show(head(df))
show(tail(df))

describe(df)

# Filtering sections of a data frame
show(df[1:5, [:length]])    # the first 5 rows from :length

show(df[df[:length] .> 2, :])    # selecting all variables with :length bigger than 2

ind = df[:length] .> 2
println(ind)
df[ind, :]

# Applying Functions to a Data Frame's variables

# applying functions column-wise
colwise(maximum, df)

# applying functions to seleceted columns
colwise(mean, df[[:length, :height]])

# Working with Data Frames
df[:weight] = DataArray([10, 20, -1, 15, 25, 5, 10, 20, -1, 5])
df[df[:weight] .== -1, :weight] = NA
mean(df[:weight])    # returns NA because of two NAs in df[:weight]

# How find NA
isna(df[:weight])    # returns Boolean values

find(isna(df[:weight]))    # returns indices of NA values

# Fill NAs with the mean
m = round(Int64, mean(df[!isna(df[:weight]), :weight]))
df[isna(df[:weight]), :weight] = m
show(df[:weight])

# Altering Data Frames
# How to delete data
delete!(df, :length)    # ! makes the function apply to the dataset directly

# If you want to meddle with the rows, use the push!() and @data() commands:
push!(df, @data([6, 15]))    # add a row with values of (6, 15)
show(df)

# If you wish to delete certain rows, you can do that using the deleterows!() command:
deleterows!(df, 9:11)    # delete rows using range
show(df)

deleterows!(df, [1,2,4])    # delete rows using array
df

# Sorting the Contents of a Data Frame
by(df, :weight, nrow)

sort!(df, cols = [order(:height), order(:weight)])


# Importing and Exporting Data

# Accessing .JSON data files
# Pkg.add("JSON")
import JSON

f = open("file.json")    # open a .json file
X = JSON.parse(f)        # read in a .json file and store in variable X
close(f)                 # close a .json file

# Storing data in .JSON file
f = open("test.json", "w")    # open a file name "test.json" with writing mode
JSON.Print(f, X)              # write X into a file "test.json"
close(f)                      # close the file

# Loading DataFiles into Data Frames
df = readtable("CaffeineForTheForce.csv")
df = readtable("CaffeineForTheForce.csv", nastrings = ["N/A", "-", ""])    # remove NA's while reading data in

# Saving Data Frames into data files
writetable("dataset.csv", df)
writetable("dataset.tsv", df)


# Cleaning up data

# Cleaning up text data
# Store all characters in a variable Z, removing all things, other than space, metioned above
S = "One efficient way of Stripping a given text(stored in variable S) of most of the irrelevant characters is the following:"
Z = ""
for c in S
    if lowercase(c) in "qwertyuiopasdfghjklzxcvbnm "
        Z = string(Z, c)
    end
end
Z







Pkg.add("ExcelReaders")
using ExcelReaders






# Caffeine for the Force dataset as Data Frame
data = readtable("C:\\dev\\Julia\\JuliaStudy\\Data files-selected\\CaffeineForTheForce\\CaffeineForTheForce.csv")

typeof(data)
size(data)
show(head(data))

show(names(data))
show(unique(data[:MoviesWatched]))
# some weird values, such as -, 44, 77

length(data[:MoviesWatched][data[:MoviesWatched] .== "-"])
length(data[:MoviesWatched][data[:MoviesWatched] .== "44"])
length(data[:MoviesWatched][data[:MoviesWatched] .== "77"])

data[:MoviesWatched][data[:MoviesWatched] .== "44"] = "4"
data[:MoviesWatched][data[:MoviesWatched] .== "77"] = "7"

show(colwise(unique, data))
