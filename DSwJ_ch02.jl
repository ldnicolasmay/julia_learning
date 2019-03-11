# DSwJ_ch02.jl

# Chapter 2 - Core Julia

## 2.1 Variable Names

# these variable names are OK
z = 100
y = 10.0
s = "Data Science"
θ = 5.0
μ = 1.2
datascience = true
data_science = true

println(z, " ", y, " ", s, " ", θ, " ", μ, " ", datascience, " ", data_science)

# these variable names are not OK
# if = true
# else = 1.5


## 2.2 Operators

x = 2
y = 3
z = 4

## Arithmetic operators
x + y
x^y

## Updating operators
x += 2
y -= 2
z *= 2

## Numeric comparison
x == y
x != y
x <= z

## Operator precedence
x
y
z
x*y+z^2 # 4*1+8^2 => 4+64 => 68
x*(y+(z^2)) # 4*(1+(8^2)) => 4*(1+64) => 4*65 => 260
(x*y)+(z^2) # 68

## 2.3 Types

### 2.3.1 Numeric

## Computer's architecture type
Sys.WORD_SIZE

## Size of default primitive
typemax(Int)

## Size of specific primitive (same as default Int => Int64)
typemax(Int64)

## Some examples of the Int type

# Integers
literal_int = 1
println("typeof(literal_int): ", typeof(literal_int))

## Boolean values
x = Bool(0)
y = Bool(1)

## Integer overflow error
x = typemax(Int64)
x += 1
x == typemax(Int64)
x == typemin(Int64)

## Integer underflow error
x = typemin(Int64)
x -= 1
x == typemin(Int64)
x == typemax(Int64)

### 2.3.2 Floats

x1 = 1.0     # default float: Float64
typeof(x1)
x64 = 15e-5  # Float64
typeof(x64)
x32 = 2.5f-4 # Float32
typeof(x32)

## digit separation using an _
9.2_4 == 9.24 # why?

typeof(NaN)
isnan(NaN)
isnan(0/0)

typeof(Inf)
isinf(Inf)
isinf(1/0)

typeof(-Inf)
isinf(-Inf)
isinf(-11/0)

y1 = 2*3
isnan(y1)
isinf(y1)

y2 = 2/0
isnan(y2)
isinf(y2)

## Some examples of machine epsilon

eps()
println(eps())

## spacing between a floating point number x and
## adjacent number is at most eps * abs(x)

n1 = [1e-25, 1e-5, 1., 1e5, 1e25]
for i in n1
    println( *(i, eps() ))
end

### 2.3.3 Strings

# Strings are immutable
s1 = "Hi"
s2 = """I have a "quote" character"""
s3 = "I have a \"quote\" character"

str = "Data science is fun!"
str[1]
str[end]
str[4:7]
str[end-3:end]

# `string()` or `*` to concatenate strings
string(str, " Sure is :)")
str * " Sure is :)"

## Interpolation
"1 + 2 = $(1 + 2)"

word1 = "Julia"
word2 = "data"
word3 = "science"
"$word1 is great for $word2 $word3"

## Lexicographical comparison
s1 = "abcd"
s2 = "abce"
s1 == s2
s1 < s2
s1 > s2

## String functions
str = "Data science is fun!"

findfirst("Data", str)

occursin("ata", str ) # true

replace(str, "fun" => "great") # "Data science is great!"

## Regular expressions
## match alpha-numeric characters at the start of the str
occursin(r"^[a-zA-Z0-9]", str)

## match alpha-numeric characters at the end of the str
occursin(r"[a-zA-Z0-9]$", str) # false

## matches the first non-alpha-numeric character in the string
match(r"[^a-zA-Z0-9]", str)

## matches all the non-alpha-numeric characters in the string
collect(eachmatch(r"[^a-zA-Z0-9]", str))

findfirst("23", "a1b23c456")
findfirst(r"\d{2}", "a1b23c456")

occursin("23", "a1b23c456")
occursin(r"\d{4}", "a1b23c456")

repeat("blah", 3)

length("a1b23c456")

replace("a1b23c456", r"\d{2,3}" => "____")
replace("a1-bc23-def456", r"[0-9]{3}" => "^^^")
replace("a1-bc23-def456", r"[a-z]{2}" => "^^")

match(r"[a-z]{2}", "a1-bc23-def456")
matches = eachmatch(r"[a-z]{2}", "a1-bc23-def456")
for m in matches
    println(m)
end

for m in collect(matches)
    println(m)
end

### 2.3.4 Tuples

## A tuple comprising only floats
tup1 = (3.0, 9.1, 0.8, 1.9)
tup1
typeof(tup1)

## A tuple comprising strings and floats
tup2 = ("Data", 2.5, "Science", 8.8)
typeof(tup2)

## variable assignment
a,b,c = ("Fast", 1, 5.2)
a
b
c


## 2.4 Data Structures

### 2.4.1 Arrays

## A vector of length 5 containing integers
a0 = [1, 2, 3, 4, 5]
a1 = Array{Int64}(undef, 5)

## A 2x2 matrix containing integers
a2 = Array{Int64}(undef, (2,2))

## A 2x2 matrix containing Any type
a3 = Array{Any}(undef, (2,2))

## A 3-element row "vector"
a4 = [1, 2, 3]

## A 1x3 column vector -- a 2-D matrix
a5 = [1 2 3]

## A 2x3 matrix, where `;` is used to sepearate rows
a6 = [80 81 82; 90 91 92]

## Notice that the array a4 does not have a second dimension, i.e., it is
## neither a 1x3 vector nor a 3x1 vector. In other words, Julia makes a
## distinction between Array{T,1} and Array{T,2}.
a4 # Array{Int64,1}
a5 # Array{Int64,2}(..., (1,3))
Array{Int64,1}(undef,3)
Array{Int64,2}(undef,(2,3))

## Arrays containing elements of a specific type can be constructed like this
a7 = Float64[3.0 5.0; 1.1 3.5]

## Arrays can be explicitly created like this
Vector(undef, 3)

Matrix(undef, 2,2)

## A 3-element float array
a3 = collect(Float64, 3.0:-0.5:1.0)

## Julia has many built-in functions that generate specific kinds of arrays
zeros(Int8, 3)
zeros(Int16, (2,3))

ones(Float32, 4)
ones(Float16, (3,5))

randn(Float64, 1)
randn(Float32, 3)
randn(Float16, (5,4))

# using Pkg
# Pkg.add("LinearAlgebra")
using LinearAlgebra # for `I` identity matrix
Matrix(I, (3,3))
Matrix{Int8}(I, (3,3))

A = Array{Int32}(undef, (3,3))
fill!(A, 3)
B = Array{Irrational}(undef, (2,2))
fill!(B, π)

# vertically concatenate arrays
vcat(A, A)

# horizontally concatenate arrays
hcat(A, A)

B = [80 81 82 ; 90 91 92]
rand(B, 2)
length(B)
size(B)
ndims(B)
reshape(B, (3,2))

# A copy of B, where elements are recursively copied
B2 = deepcopy(B)

B
## slicine arrays
B[1] # B[1,1]
B[1] == B[1,1]
B[2] # B[2,1]
B[2] == B[2,1]
B[3] # B[1,2]
B[3] == B[1,2]
B[5] == B[1,3]

B[1:2]
B[1:2,]
B[1:2,1]
B[1:2,2]
B[1:2,2:3]
B[:,:]
B[1:end,1:end]

# Another way to build an array is comprehensions
A1 = [sqrt(i) for i in [16, 25, 64]]
A2 = [i^2 for i in [1, 2, 3]]


### 2.4.2 Dictionaries

# Dictionaries in Julia are analogous to lists in R

## Three dictionaries
D0 = Dict()
D1 = Dict(1 => "red", 2 => "white")
D2 = Dict{Integer, String}(1 => "red", 2 => "white")

## Dictionaries can be created using a loop
foods = ["salmon", "maple syrup", "tourtiere"]
foods_dict = Dict{Int, String}()
# enumerate(foods)
for (i, food) in enumerate(foods)
    foods_dict[i] = food
end

foods_dict

## Dictionaries can also be created using the generator syntax
wines = ["red", "white", "rose"]
wines_dict = Dict{Int,String}(i => wines[i] for i in 1:length(wines))

# Values in a Dict can be accessed using `[]` or `get()`
# The presence of a key can be checked with `haskey()` and
# a particular key can be accessed using `getkey()`

foods_dict[1]

# `get()` does the same as `[]` and you can also provide a default value
get(foods_dict, 1, "unknown")
get(foods_dict, 7, "unknown")

# we can check to see if a key in a Dict exists
haskey(foods_dict, 1)
haskey(foods_dict, 7)

# `getkey()` returns the key at a given index
getkey(foods_dict, 1, 999)
getkey(foods_dict, 7, 999)

# `[]` can also be used to reassign values to an existing key
println(foods_dict)
foods_dict[1]
foods_dict[1] = "lobster"
foods_dict[1]

# Two common ways to add new entries
foods_dict[4] = "bannock"
println(foods_dict)
get!(foods_dict, 5, "chevre")
println(foods_dict)

# Why the `!` in `get!()`?
# https://docs.julialang.org/en/v1/manual/style-guide/#Append-!-to-names-of-functions-that-modify-their-arguments-1

# The advantage of `get!()` is that it won't add the new entry if
# a value is already associated with the key
println(foods_dict)
get!(foods_dict, 4, "toutiere")
println(foods_dict)

# deleting entries by key
println(foods_dict)
delete!(foods_dict, 4)
println(foods_dict)

# we can also pop off value by key
deleted_food_value = pop!(foods_dict, 3, 999)
deleted_food_value
println(foods_dict)

# Dict keys can be coerced into arrays
collect(keys(foods_dict))

# Dict values can be coerced into arrays
collect(values(foods_dict))

# we can iterate over both keys and values
for (k, v) in foods_dict
    println("foods_dict -- key: ", k, " value: ", v)
end

# or we can just loop over values
for v in values(foods_dict)
    println("foods_dict -- value: ", v)
end


## 2.5 Control Flow

### 2.5.1 Compound Expressions

# A `begin` block
b1 = begin
    c = 20
    d = 5
    c * d
end
println("b1: ", b1)

# A chain ... does the same as a `begin` block
b2 = ( c = 20; d = 5; c * d )
println("b2: ", b2)

### 2.5.2 Conditional evaluation

# if - elseif - else

# An if-else construct
k = 1
if k == 0
    "zero"
else
    "not zero"
end

# An if-elseif-else construct
k = 11
if k % 3 == 0
    0
elseif k % 3 == 1
    1
else
    2
end

# Ternary operator a ? b : c => if a then b else c
# A short circuit evalution
b = 10; c = 20;
b < c ? "less than" : "not less than"
println("SCE -- b < c: ", b < c ? "less than" : "not less than")

# A short-circuit evaluation with nesting
d = 10; f = 10;
d < f ? "less than" : d > f ? "greater than" : "equal"
d = 9; f = 10;
d < f ? "less than" : d > f ? "greater than" : "equal"
d = 10; f = 9;
d < f ? "less than" : d > f ? "greater than" : "equal"

using Base.MathConstants
e
println(e)

### 2.5.3 Loops

#### 2.5.3.1 Basics

str = "Julia"

## A for loop for a string, iterating by index
for i = 1:length(str)
    println(str[i])
end

## A for loop for a string, iterating by container element
for s in str
    println(s)
end

## A nested for loop
for s in str, j = 1:length(str)
    println((s, j))
end

## Another nested for loop
odd = [1, 3, 5] # 1:2:5
even = [2, 4, 6] # 2:2:6
for i in odd, j in even
    println("i*j: ", i * j)
end

## Example of an infinite while loop (nothing inside the loop can falsify
## the condition x<10)

#=
n=0
x=1
while x<10
    global n
    n=n+1
end
=#

n = 0
while n < 10
    global n
    print(n, " ")
    n += 1
end

#### 2.5.3.2 Loop termination

# using the `break` keyword
i = 0
while true
    global i
    sq = i^2
    println("i: $i --- sq: $sq")
    if sq > 16
        break
    end
    i += 1
end

for i = 1:10
    sq = i^2
    println("i: $i --- sq: $sq")
    if sq > 16
        break
    end
end

## using the `continue` keyword
for i in 1:5
    if i % 2 == 0
        continue
    end
    sq = i^2
    println("i: $i --- sq: $sq")
end

#### 2.5.3.3 Exception handling

# Generate an exeption
log(-1)

## `throw`
for i in [1, 2, -1, 3]
    if i < 0
        throw(DomainError(i, "here's the message when throwing the error"))
    else
        println("i: $(log(i))")
    end
end

## error
for i in [1, 2, -1, 3]
    if i < 0
        error("i is a negative number")
    else
        println("i: $(log(i))")
    end
end

## try/catch
for i in [1, 2, -1, "A"]
    try log(i)
    catch ex
        if isa(ex, DomainError)
            println("i: $i -- DomainError")
            log(abs(i))
        else
            println("i: $i")
            println(ex)
            error("Not a DomainError")
        end
    end
end


## 2.6 Functions

function add(x, y)
    return(x + y)
end

add(2, 3)

addnew = add
addnew(3, 5)

# simple function written in assignment form
add2(x, y) = x + y
add2(5, 8)

# argument passing is done by reference...
# so changes to an array passed to a function that are made INSIDE the function
# will affect the array in memory (and so also outside the function)
function f1!(x)
    x[1] = 9999
    return(x)
end

ia = Int64[0, 1, 2]
println("ia: ", ia)

f1!(ia)
println("ia after being passed to `f1!`: ", ia)

## operators are functions
2*3
*(2, 3)

# anonymous functions are possible
# here's example of using `map()` with an anonymous function
a = [1, 2, 3, 1, 2, 1]
using Statistics
mu = mean(a)
sd = std(a)

b = map(x -> (x - mu)/sd, a)
println(b)

# optional arguments
function fibonacci(n = 20)
    if n <= 1
        return(1)
    else
        return(fibonacci(n-1) + fibonacci(n-2))
    end
end
fibonacci(5)
fibonacci(20)
fibonacci()

## Tip3: Function with a ! in the name
a1 = [2,3,1,6,2,8]
println(a1)
sort!(a1)
println(a1)

## Tip 4
## Do not wrap abs() in an anonymous function
A = [1, -0.5, -2, 0.5]
println(map(x -> abs(x), A))
## Rather, do this
println(map(abs, A))

## Tip 5, type promotion
times1a(y) = *(y, 1)   # good
times1b(y) = *(y, 1.0) # not good
times1a(1/2)
times1a(2) # preserves type
times1a(2.0)
times1b(1/2)
times1b(2) # changes type unnecessarily
times1b(2.0)

## Tip 6, function with typed arguments
times1c(y::Float64) = *(y, 1)
times1c(2)
times1c(2.0)
times1c(float(2))
