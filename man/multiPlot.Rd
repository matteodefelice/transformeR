% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotMeanGrid.R
\name{multiPlot}
\alias{multiPlot}
\title{Make multi-panel plots}
\usage{
multiPlot(gridData, split.dim.name, titles, multi.member)
}
\arguments{
\item{gridData}{a grid dataset as returned by any of the loading functions}

\item{name}{of the dimension used for splitting: either \code{var} or \code{member} for multi-predictor and
multi-member displays respectively}
}
\value{
Prints the graphical display
}
\description{
Sub-routine of \code{\link{plotMeanGrid}} for dividing the graphical window into different subplots,
for multi-member or multi-variable displays
}
\author{
J Bedia
}
\keyword{internal}
