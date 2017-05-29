install.packages('ks')
data("unicef", package = 'ks')
plot(unicef)
x <- scale(unicef)

require(fpc)
set.seed(2018)
fit <- kmeansruns(x, krange = 6, runs = 100)

install.packages('broom')
library(broom) 
tidy(fit)

set.seed(2018)
fitasw <- kmeansruns(x, krange = 2:10, critout = TRUE, runs = 100, criterion = "asw")
round(fitasw$centers, 3)
com_view <- cbind(fitasw$cluster, unicef)
colnames(com_view) <- c("cluster", "Median_Under_5", "Median_Life_Exp")
head(com_view)

tab1 <- aggregate(data = com_view, Median_Under_5 ~ cluster, median)
tab2 <- aggregate(data = com_view, Median_Life_Exp ~ cluster, median)
med <- cbind(tab1, tab2)
med <- med[,-3]
med

var1 <- aggregate(data = com_view, Median_Under_5 ~ cluster, var)
var2 <- aggregate(data = com_view, Median_Life_Exp ~ cluster, var)
var <- cbind(var1, var2)
round(var, 3)

country <- rownames(x)
final_clusters <- lapply(1:2, 
                         function(cluster)
                         country[fitasw$cluster == cluster])

final_clusters[1]
final_clusters[2]








