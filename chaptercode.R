library(rlang)
library(ggplot2)
library(scales)


# Intro to factory function

power1 <- function(exp) {
  function(x) {
    x ^ exp
  }
}

square <- power1(2)
cube <- power1(3)

square(3)
cube(3)




# Environments

square

cube

env_print(square)

env_print(cube)

env_print(power1)


fn_env(square)$exp

fn_env(cube)$exp

fn_env(power1)$exp



# Forced evaluation

x <- 2

square <- power1(x)

x <- 3

square(2)

2*2*2





power2 <- function(exp) {
  force(exp)
  function(x) {
    x ^ exp
  }
}


x <- 2

square <- power2(x)

x <- 3

square(2)





# Stateful functions

new_counter <- function() {
  i <- 0
  
  function() {
    i <<- i + 1
    i
  }
}

counter_one <- new_counter()

counter_two <- new_counter()


counter_one()

counter_one()

counter_two()



# Garbage collection

f1 <- function(n) {
  x <- runif(n)
  m <- mean(x)
  function() m
}

g1 <- f1(1e6)
lobstr::obj_size(g1)

f2 <- function(n) {
  x <- runif(n)
  m <- mean(x)
  rm(x)
  function() m
}

g2 <- f2(1e6)
lobstr::obj_size(g2)
