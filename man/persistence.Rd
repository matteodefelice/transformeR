% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/persistence.R
\name{persistence}
\alias{persistence}
\title{Persistence climatology (Temporal autocorrelation at given time lag)}
\usage{
persistence(grid, lag = 1, ci = NULL, parallel = FALSE, max.ncores = 16,
  ncores = NULL)
}
\arguments{
\item{grid}{Input grid (most likely annually aggregated)}

\item{lag}{Time lag at which to calculate persistence. Default is 1.}

\item{ci}{Coverage probability for confidence interval (in the range (0-1)). Default to \code{NULL}, and ignored.}

\item{parallel}{Logical. Should parallel execution be used?}

\item{max.ncores}{Integer. Upper bound for user-defined number of cores.}

\item{ncores}{Integer number of cores used in parallel computation. Self-selected number of
cores is used when \code{ncpus = NULL} (the default), or when \code{maxcores} exceeds the default \code{ncores} value.}
}
\value{
A climatology grid (i.e., \code{"time"} dimension size = 1).
}
\description{
Computes the persistence climatology (i.e., the temporal autocorrelation at a given time lag)
}
\details{
The function is a wrapper of \code{\link[stats]{acf}} to compute the autocorrelation function. Significance at the given confidence 
interval is calculated as in \code{\link[stats]{plot.acf}}

In case of any missing values within the series, NA will be returned.

If \code{ci} is specified (e.g. \code{ci=0.95}), two global attributes are appended: 
\itemize{
\item \code{"signif:ci"}, indicating the confidence interval chosen
\item \code{"is.signif"}, which is a logical matrix of dimension \code{lat x lon} indicating which points exhibit a 
significant persistence
}
}
\section{Parallel Processing}{


Parallel processing is enabled using the \pkg{parallel} package. 
Parallelization is undertaken by a FORK-type parallel socket cluster formed by \code{ncores}.
If \code{ncores} is not specified (default), \code{ncores} will be one less than the autodetected number of cores.
The maximum number of cores used for parallel processing can be set with the \code{max.ncores} argument, 
although this will be reset to the auto-detected number of cores minus 1 if this number is exceeded. Note that not all 
code, but just some critical loops within the function are parallelized.

In practice, parallelization does not always result in smaller execution times, due to the parallel overhead.
However, parallel computing may potentially provide a significant speedup for the 
particular case of large multimember datasets or large grids.
 
Parallel computing is currently not available for Windows machines.
}

\seealso{
\code{\link{plotClimatology}}, for conveniently plotting persistence climatology maps.
}
\author{
J Bedia
}
