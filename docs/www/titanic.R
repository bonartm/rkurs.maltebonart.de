# install.packages(ggplot2)
library(ggplot2)

# read in the data and define factor variables
titanic <- read.csv("./www/titanic.csv", stringsAsFactors = FALSE)
titanic$pclass <- as.factor(titanic$pclass)
titanic$sex <- as.factor(titanic$sex)

# apply logistic regression model
form <- survived ~ pclass + sex + age + pclass:sex + pclass:age + sex:age
m <- glm(form, data = titanic, family = "binomial")

# create artificial new data
dat <- expand.grid(sex = c("male", "female"), 
                   pclass = as.factor(c(1, 2, 3)), 
                   age = 0:70)

# predict the new data on linear scale together with se
pred <- predict(m, newdata = dat, type = "link", se.fit = TRUE)

# add prediction, upper, lower CI to the new data
# transform the prediction to [0,1]
dat$survived <- plogis(pred$fit)
dat$upper <- plogis(pred$fit + 1.96*pred$se.fit)
dat$lower <- plogis(pred$fit - 1.96*pred$se.fit)

# define some labels
facet_labels <- c("1" = "first class", "2" = "second class", "3" = "third class")
subtitle <- paste0("Logistic regression model equation: ", format(form), 
                   "\n95% confidence intervals, N: ", m$df.null + 1)

# plot the data
ggplot(dat, aes(x = age, y = survived, 
                color = sex, fill = sex, 
                ymin = lower, ymax = upper)) + 
  geom_line() + 
  geom_ribbon(linetype = 0, alpha = 0.1) + 
  facet_grid(~ pclass, labeller = as_labeller(facet_labels)) + 
  ggtitle("Survival rates on the titanic", subtitle) + 
  theme(legend.position = "top", 
        legend.title=element_blank(), 
        legend.justification = "left")
