# DebuggingUtilities

[![Build Status](https://travis-ci.org/timholy/DebuggingUtilities.jl.svg?branch=master)](https://travis-ci.org/timholy/DebuggingUtilities.jl)

This package contains simple utilities that may help debug julia code.

# Installation

Install with

```jl
pkg> dev https://github.com/timholy/DebuggingUtilities.jl.git
```

When you use it in packages, you should `activate` the project and add
DebuggingUtilities as a dependency use `project> dev DebuggingUtilities`.

# Usage

## @showln

`@showln` shows variable values and the line number at which the
statement was executed. This can be useful when variables change value
in the course of a single function. For example:

```jl
using DebuggingUtilities

function foo()
    x = 5
    @showln x
    x = 7
    @showln x
    nothing
end
```
might, when called (`foo()`), produce output like
```
            x = 5
            (in foo at ./error.jl:26 at /tmp/showln_test.jl:5)
            x = 7
            (in foo at ./error.jl:26 at /tmp/showln_test.jl:7)
```

## test_showline

This is similar to `include`, except it displays progress. This can be
useful in debugging long scripts that cause, e.g., segfaults.

## time_showline

Also similar to `include`, but it also measures the execution time of
each expression, and prints them in order of increasing duration.
