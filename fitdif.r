#' Fit diffusion profiles by non-linear least squares.
#'
#' This function fits measured diffusion couple profiles using
#'   the equation of Crank, 1975.  The function takes as input
#'   measured compositions along a traverse, starting values for 
#'   the upper and lower concentrations and returns best fit values
#'   and uncertainties for each parameter and solves for diffusivity (Dt).
#' 
#' @param x cector of measured distance values
#' @param c Vector of measured concentration values
#' @param sd cector of absolute uncertainty in concentration
#' @param c1 starting guess for lower concentration
#' @param c2 starting guess for higher concentration
#' @param dt starting guess for diffusivity (Dt)
#' @param dt starting guess for any shift in x to center profile at zero
#' @return prints paramter estimates and plots ggplot of profile
#'
#' @references Crank, J., 1975. The mathematics of diffusion, Oxford, 421 p.
#'
#' @author Sean Mulcahy
#' @export
#' @examples
#' df <- read.table("dataset.csv", header = T, sep = ",")
#' fitdif(df$x, df$c, df$sd, 0.02, 0.07)

fitdif <- function(x, c, sd, c1, c2, dt = 1, dx = 0){
	require(ggplot2)
	
	# define the error function
	erf <- function(x) {
		2 * pnorm(x * sqrt(2)) - 1
	}

	# diffusion couple equation of Crank, 1975
	fit <- (nls(c ~ 0.5 * (c2 + c1) + 0.5 * (c2 - c1) * erf((x + Dx) / (2 * sqrt(Dt))), data = df, weight = 1 / (sd**2), start = list(c1 = c1, c2 = c2, Dt = dt, Dx = dx)))

	# best fit profile
	df$pr <- predict(fit)
	
	# model results
	res <- summary(fit)
	print(res)
	
	# plot data and best fit profile with ggplot2
	
	p <- ggplot(df, aes(x, c, ymin = c - sd, ymax = c + sd)) + 
		geom_errorbar(width = 0, colour = "grey70") +
		geom_point() + 
		geom_line(data = df, aes(x = x, y = pr), colour = "red") +
		#geom_line(data = pr, aes(x = x, y = lwr), colour = "red", lty="dashed") +
		#geom_line(data = pr, aes(x = x, y = upr), colour = "red", lty="dashed") +
		labs(x = "Distance", y = "Concentration") + 
		theme_bw()
		
	p
}