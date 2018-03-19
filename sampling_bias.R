# Generate population 
population <- rnorm(1000000, mean = 0, sd = 1)
hist(population)

# Try it out with size 10
size10 <- replicate(5, sample(population, size = 10, replace = TRUE))
hist(size10[,1])
size_10_means <- apply(size10, MARGIN = 2, FUN = mean)

# Put it in a function so we can rerun it easily
sample_means <- function(pop, num) {
  samples <- replicate(30, sample(pop, size = num, replace = TRUE))
  samples_means <- apply(samples, MARGIN = 2, FUN = mean)
  return(samples_means)
}

# Did it work?
sample_means(population, 10)

# Take samples of 10 at a time, 100 at a time, 1000 at a time
ten <- sample_means(population, 10)
hundred <- sample_means(population, 100)
thousand <- sample_means(population, 1000)

# Combine to make a boxplot
df <- as.data.frame(cbind(ten, hundred, thousand))
boxplot(df, main = "The distribution of means for 30 samples")

# Go back and see what happens if you vary how many samples you take