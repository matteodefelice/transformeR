% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subsetGrid.R
\name{subsetSeason}
\alias{subsetSeason}
\title{Monthly subset of a grid}
\usage{
subsetSeason(grid, season = NULL)
}
\arguments{
\item{grid}{Input grid to be subset (possibly a multimember/multigrid).}

\item{season}{An integer vector indicating the months to be subset.}
}
\value{
A grid (or multigrid) that is a logical subset of the input grid along its 'time' dimension.
}
\description{
Retrieves a grid that is a logical subset of the input grid along its 'time' dimension,
 on a monthly basis. Multimember multigrids are supported. Subroutine of \code{\link{subsetGrid}}.
}
\details{
An attribute 'subset' with value 'subsetSeason' is added to the Dates slot of the output subset.
}
\seealso{
Other subsetting: \code{\link{subsetDimension}},
  \code{\link{subsetGrid}}, \code{\link{subsetMembers}},
  \code{\link{subsetRuntime}}, \code{\link{subsetSpatial}},
  \code{\link{subsetVar}}, \code{\link{subsetYears}}
}
\author{
J. Bedia
}
\keyword{internal}
