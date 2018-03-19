# Plot power curves for two tailed t-test 

library(pwr)

# test out the function
?pwr.t.test
pwr.t.test(n = 35, power = 0.9, sig.level = 0.05, alternative = "two.sided")

# To plot we need the output for a range of values for both d and power
# Range of t-test effect sizes 
effect_sizes <- seq(0.1, 0.75, 0.05)
num_effects <- length(effect_sizes)

# Range of power values
power_val <- seq(0.4, 0.9, 0.1)
num_power <- length(power_val)

# Create matrix of sample sizes needed
# to have a certain amount of power to detect
# an effect of a certain size
mat_size <- numeric(num_effects*num_power)
sample_sizes <- matrix(mat_size, nrow = num_effects, ncol = num_power)

# Populate the matrix
for (pow in 1:num_power) {
  for (eff in 1:num_effects) {
    result <- pwr.t.test(n = NULL, 
                       d = effect_sizes[eff],
                       power = power_val[pow], 
                       sig.level = 0.05,
                       alternative = "two.sided")
    sample_sizes[eff, pow] <- result$n
  }
}

# Did we do it correctly?
sample_sizes
effect_sizes
power_val

# Set up canvas
# Power as a function of sample size, by effect size, 
# at constant significance level of 0.05
xrange <- range(effect_sizes)  
yrange <- round(range(sample_sizes))

colors <- rainbow(length(power_val))

plot(xrange, yrange, type = "n", 
     xlab = "Effect size (d)", 
     ylab = "Sample size (N)")

# Populate the graph
for (pow in 1:num_power) {
  lines(effect_sizes, sample_sizes[,pow], type = "l", lwd = 2, col = colors[pow])
}

# Annotate graph
title("Sample size needed to detect an effect (d) \nusing a two-tailed t-test\nsignificance level = 0.05")
legend("topright", title = "Power", as.character(power_val), fill = colors)