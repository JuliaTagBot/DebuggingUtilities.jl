using DebuggingUtilities
using Test

function foo()
    x = 5
    @showln x
    x = 7
    @showln x
end

# The more laborious approach, in case one needs speed
function foofl()
    x = 5
    @showfl(@__FILE__, @__LINE__, x)
    x = 7
    @showfl(@__FILE__, @__LINE__, x)
end

io = IOBuffer()
DebuggingUtilities.showlnio[] = io

@test foo() == 7

str = chomp(String(take!(io)))
target = ("x = 5", "(in foo at", "x = 7", "(in foo at")
for (i,ln) in enumerate(split(str, '\n'))
    ln = lstrip(ln)
    @test startswith(ln, target[i])
end

io = IOBuffer()
DebuggingUtilities.showlnio[] = io
@test foofl() == 7
str = chomp(String(take!(io)))
target = ("x = 5", "(at file ", "x = 7", "(at file ")
for (i,ln) in enumerate(split(str, '\n'))
    ln = lstrip(ln)
    @test startswith(ln, target[i])
end

# Just make sure these run
io = IOBuffer()
DebuggingUtilities.showlnio[] = io
test_showline("noerror.jl")
@test_throws DomainError test_showline("error.jl")
time_showline("noerror.jl")

DebuggingUtilities.showlnio[] = stdout
nothing
