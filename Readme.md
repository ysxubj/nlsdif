fitdif.r
=============

- **Author**: Sean R. Mulcahy
- **License**: [MIT](http://www.opensource.org/licenses/mit-license.php)
- [Source code on Github](https://github.com/srmulcahy/fitdif)

`fitdif.r` is an R function fits measured diffusion couple profiles using the equation of Crank, 1975.  The function takes as input measured compositions along a traverse, starting values for the upper and lower concentrations and returns best fit values and uncertainties for each parameter and solves for diffusivity (Dt).

We used a similar approach in the paper by Renne et al., *In Press* to fit Ba diffusion profiles in feldspar in order to model temperature-time histories and argon retention in magmatic phenocrysts.

## References ##
1. Crank, J., 1975. The mathematics of diffusion, Oxford, 421 p.
2. Renne, P.R., Mulcahy, S.R., Morgan, L.E., Cassata, W.S., Kelley, S.P., Hlusko, L., and Njau, J., 
  Retention of inherited Ar by alkali feldspar xenocrysts in a magma: Kinetic constraints from Ba zoning profiles: 
  *Geochimica et Cosmochimica Acta*.
  ([doi](http://dx.doi.org/10.1016/j.gca.2012.06.029))


Quick start
-----------

Download or fork the R code and data set file and cd to the working directory.  Within R:

```r
df <- read.table("dataset.csv", header = T, sep = ",")
fitdif(df$x, df$c, df$sd, 0.02, 0.07)
```

The function will plot the fitted diffusion profile and return the best fit non-linear least squares results.

```r
Formula: c ~ 0.5 * (c2 + c1) + 0.5 * (c2 - c1) * erf((x + Dx)/(2 * sqrt(Dt)))

Parameters:
    Estimate Std. Error t value Pr(>|t|)    
c1 0.0222907  0.0003162  70.501  < 2e-16 ***
c2 0.0674114  0.0006946  97.049  < 2e-16 ***
Dt 2.4561664  0.3861678   6.360 7.93e-09 ***
Dx 0.0669055  0.1333017   0.502    0.617    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 

Residual standard error: 0.7069 on 91 degrees of freedom

Number of iterations to convergence: 7 
Achieved convergence tolerance: 8.107e-06
```
