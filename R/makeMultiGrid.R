#     makeMultiGrid.R Multigrid constructor
#
#     Copyright (C) 2017 Santander Meteorology Group (http://www.meteo.unican.es)
#
#     This program is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
# 
#     This program is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
# 
#     You should have received a copy of the GNU General Public License
#     along with this program.  If not, see <http://www.gnu.org/licenses/>.




#' @title Multigrid constructor 
#' @description Constructs a (possibly multimember) multigrid from different (multimember) grids.
#' A multigrid can be considered as a \dQuote{stack} of grids with similar spatiotemporal extents,
#'  useful to handle sets of predictors as a single block.
#' @param ... Input grids to form the multigrid. These must be compatible in time and space (see details). 
#' For flexibility, they can be introduced as a list or directly as consecutive arguments.
#' @param spatial.tolerance numeric. Coordinate differences smaller than \code{spatial.tolerance} will be considered equal 
#' coordinates. Default to 0.001 --assuming that degrees are being used it seems a reasonable rounding error after interpolation--.
#' This value is passed to the \code{\link{identical}} function to check for spatial consistency of the input grids.
#' @param skip.temporal.check Logical. Should temporal matching check of input fields be skipped?
#' Default to \code{FALSE}. This option can be useful in order to construct multigrids 
#' from grids of different temporal characteristics. See details.
#'  (e.g., a multi-seasonal multifield), to be passed to \code{\link{plotClimatology}}
#' @return A (multimember) multigrid object encompassing the different input (multimember) grids
#' @details The function makes a number of checks in order to test the spatiotemporal compatibility of the input multi-member grids.
#'  Regarding the temporal concordance, it can be skipped by setting the argument \code{skip.temporal.check} to \code{TRUE}.
#'  It is implicitly assumed that all temporal data from the different
#'  multimember grids correspond to the same time zone ("GMT"). The time zone itself is not important, as long as it is the
#'  same across datasets, because temporal consistency is checked on a daily basis (not hourly), allowing the inclusion of 
#'  predictors with different verification times and temporal aggregations. For instance, instantaneous geopotential at 12:00 
#'  is compatible with mean daily surface temperature, always that both variables correspond to the same days. Different time 
#'  resolutions are not compatible and will return an error (for instance, 6-hourly data is incompatible with daily values, 
#'  because their respective time series for a given season have different lengths).
#'  
#'  The spatial consistency of the input grids is also checked. In order to avoid possible errors from the user, the spatial
#'   consistency (i.e., equal XY coordinates) of the input grids must be ensured before attempting the creation of the multigrid,
#'   otherwise giving an error. This can be achieved either through the specification of the same 'lonLim' and 'latLim' argument
#'   values when loading the grids, or using the \code{\link{interpGrid}} interpolator in conjuntion with the \code{\link{getGrid}}
#'   method.
#'  
#'  
#' @note A multigrid can not be passed to the interpolator \code{\link{interpGrid}} directly. Instead, the 
#' multimember grids should be interpolated individually prior to multigrid construction.  
#' @export
#' @importFrom abind abind
#' @author J. bedia 
#' @seealso \code{\link{interpGrid}} for spatial consistency of input grids.
#' 
#' @examples 
#' # Creation of a multigrid from three different grids:
#' data(iberia_ncep_ta850)
#' data(iberia_ncep_hus850)
#' data(iberia_ncep_psl)
#' # An example of different temporal aggregations, temporally compatible: 
#' # sea-level pressure is a daily mean, while specific humidity and air temperature 
#' # (850 mb surface isobaric pressure level) are instantaneous data verifying at 12:00 UTC:
#' # air temperature
#' range(iberia_ncep_ta850$Dates$start)
#' range(iberia_ncep_ta850$Dates$end) # start and end are identical (instantaneous)
#' # sea-level pressure
#' range(iberia_ncep_psl$Dates$start)
#' range(iberia_ncep_psl$Dates$end) # start and end differ in 24 h (daily mean)
#' mf <- makeMultiGrid(iberia_ncep_hus850, iberia_ncep_psl, iberia_ncep_ta850)
#' # The new object inherits the global attributes from the first grid, as it is assumed
#' # that all input grids come from the same data source:
#' attributes(mf)
#' # The data structure has now one additional dimension ("var"), along which the data arrays
#' # have been binded:
#' str(mf$Data)
#' plotMeanGrid(mf)
#' 
#' # Example of multimember multigrid creation from several multimember grids:
#' # Load three different multimember grids with the same spatiotemporal ranges:
#' data(tasmax_forecast)
#' data(tasmin_forecast)
#' data(tp_forecast)
#' mm.mf <- makeMultiGrid(tasmax_forecast, tasmin_forecast, tp_forecast)
#' # 'plotMeanGrid' can just handle the multi-member mean for each variable in this case:
#' plotMeanGrid(mm.mf)


makeMultiGrid <- function(..., spatial.tolerance = 1e-3, skip.temporal.check = FALSE) {
      field.list <- list(...)
      if (length(field.list) == 1) {
                  field.list <- unlist(field.list, recursive = FALSE)
      }
      stopifnot(is.logical(skip.temporal.check))
      if (length(field.list) < 2) {
            stop("The input must be a list of at least two grids", call. = FALSE)
      }
      tol <- spatial.tolerance
      for (i in 2:length(field.list)) {
            # Spatial test
            if (!isTRUE(all.equal(field.list[[1]]$xyCoords, field.list[[i]]$xyCoords, check.attributes = FALSE, tolerance = tol))) {
                  stop("Input data is not spatially consistent")
            }
            # temporal test
            if (!skip.temporal.check) {
                  if (!identical(as.POSIXlt(field.list[[1]]$Dates$start)$yday, as.POSIXlt(field.list[[i]]$Dates$start)$yday) | !identical(as.POSIXlt(field.list[[1]]$Dates$start)$year, as.POSIXlt(field.list[[i]]$Dates$start)$year)) {
                        stop("Input data is not temporally consistent")
                  }
            }
            # data dimensionality
            if (!identical(dim(field.list[[1]]$Data), dim(field.list[[i]]$Data))) {
                  stop("Incompatible data array dimensions")
            }
            if (!identical(attr(field.list[[1]]$Data, "dimensions"), attr(field.list[[i]]$Data, "dimensions"))) {
                  stop("Inconsistent 'dimensions' attribute")
            }
      }
      ## $Variable attrs ----------
      aux.list <- lapply(1:length(field.list), function(x) field.list[[x]]$Variable)
      varName <- vapply(1:length(aux.list), FUN.VALUE = character(1), FUN = function(x) paste(aux.list[[x]]$varName, aux.list[[x]]$level, sep = ""))
      level <- sapply(1:length(aux.list), function(x) ifelse(is.null(aux.list[[x]]$level), NA, aux.list[[x]]$level))      
      attr.mf <- lapply(1:length(aux.list), function(x) attributes(aux.list[[x]]))
      aux.list <- NULL
      field.list[[1]]$Variable <- list("varName" = varName, "level" = level)      
      if (length(attr.mf[[1]]) > 1) {
            attr.list <- lapply(2:length(attr.mf[[1]]), function(x) {
                  unlist(sapply(attr.mf, "c")[x,])
            })
            names(attr.list) <- names(attr.mf[[1]])[-1]
            attributes(field.list[[1]]$Variable) <- attr.list
      }
      names(field.list[[1]]$Variable) <- c("varName", "level")
      ## Climatologies ----------
      climfun <- attr(field.list[[1]]$Data, "climatology:fun")
      ## $Dates -------------------
      field.list[[1]]$Dates <- lapply(1:length(field.list), function(x) field.list[[x]]$Dates)
      dimNames <- attr(field.list[[1]]$Data, "dimensions")
      field.list[[1]]$Data <- unname(do.call("abind", c(lapply(1:length(field.list), function(x) field.list[[x]]$Data), along = -1))) 
      attr(field.list[[1]]$Data, "dimensions") <- c("var", dimNames)
      if (!is.null(climfun)) attr(field.list[[1]]$Data, "climatology:fun") <- climfun 
      return(field.list[[1]])
}
# End
