#' @title Grid containing NCEP reanalysis data of specific humidity at 850mb for the Iberian Peninsula.
#' @description The data are daily means, wintertime (DJF) period 1991-2010. 
#' @format A grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @name iberia_ncep_hus850
#' @examples
#' data(iberia_ncep_hus850)
#' plotClimatology(climatology(iberia_ncep_hus850),
#'                 backdrop.theme = "countries", scales = list(draw = TRUE))
NULL

#' @title Grid containing NCEP reanalysis data of sea-level pressure for the Iberian Peninsula.
#' @description The data correspond to the wintertime (DJF) period 1991-2010, and it consists of daily mean data, computed as the
#' mean of the four 6-hourly model outputs. 
#' @format A grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @name iberia_ncep_psl
#' @examples
#' data(iberia_ncep_psl)
#' plotClimatology(climatology(iberia_ncep_psl),
#'                 backdrop.theme = "countries", scales = list(draw = TRUE))
NULL

#' @title Grid containing NCEP reanalysis data of air temperature at 850mb for the Iberian Peninsula.
#' @description The data correspond to the wintertime (DJF) period 1991-2010, and it consists of daily mean data 
#' @format A grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @name iberia_ncep_ta850
#' @examples
#' data(iberia_ncep_ta850)
#' plotClimatology(climatology(iberia_ncep_ta850),
#'                 backdrop.theme = "countries", scales = list(draw = TRUE))
NULL

#' @title Multimember grid containing a seasonal forecast of maximum surface temperature for Europe
#' @description CFSv2 forecast of maximum daily temperature for July 2001 over Europe. Lead-month 2, first 9 members.
#' @format A multimember grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @references 
#' Saha, S. \emph{et al.}, 2013. The NCEP Climate Forecast System Version 2. J Clim 130925135638001. doi:10.1175/JCLI-D-12-00823.1
#' @name tasmax_forecast
#' @examples
#' data(tasmax_forecast)
#' plotClimatology(climatology(tasmax_forecast), backdrop.theme = "coastline")
NULL

#' @title Multimember grid containing a seasonal forecast of minimum surface temperature for Europe
#' @description CFSv2 forecast of minimum daily temperature for July 2001 over Europe. Lead-month 2, first 9 members.
#' @format A multimember grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @references 
#' Saha, S. \emph{et al.}, 2013. The NCEP Climate Forecast System Version 2. J Clim 130925135638001. doi:10.1175/JCLI-D-12-00823.1
#' @name tasmin_forecast
#' @examples
#' data(tasmin_forecast)
#' plotClimatology(climatology(tasmin_forecast), backdrop.theme = "coastline")
NULL

#' @title Multimember grid containing a seasonal forecast of precipitation for Europe
#' @description CFSv2 forecast of daily accumulated precipitation for July 2001 over Europe. Lead-month 2, first 9 members.
#' @format A multimember grid
#' @source \url{http://www.meteo.unican.es/ecoms-udg}
#' @references 
#' Saha, S. \emph{et al.}, 2013. The NCEP Climate Forecast System Version 2. J Clim 130925135638001. doi:10.1175/JCLI-D-12-00823.1
#' @name tp_forecast
#' @examples
#' data(tp_forecast)
#' plotClimatology(climatology(tasmax_forecast, clim.fun = list(FUN = sum)),
#'                 backdrop.theme = "coastline")
NULL

#' @title Grid containing E-OBS daily data of mean temperature for the Iberian Peninsula (DJF, 1998-2000).
#' @description EOBS_Iberia_tas is a grid object returned by \code{loadECOMS} from package \pkg{loadeR.ECOMS}
#' @format A grid
#' @name EOBS_Iberia_tas
#' @docType data
#' @keywords gridded observations
#' @source  subset of the E-OBS observational gridded dataset
#' @seealso \code{\link{makeMultiGrid}}, \code{\link[loadeR]{loadGridData}}
#' @examples 
#' data("EOBS_Iberia_tas")
#' plotClimatology(climatology(EOBS_Iberia_tas),
#'                 backdrop.theme = "countries", scales = list(draw = TRUE))
NULL


#' @title Grid containing E-OBS daily data of precipitation for the Iberian Peninsula (DJF, 1998-2000).
#' @description EOBS_Iberia_tp is a grid object returned by \code{loadECOMS} from package \pkg{loadeR.ECOMS}
#' @format A grid
#' @name EOBS_Iberia_tp
#' @docType data
#' @keywords gridded observations
#' @source  subset of the E-OBS observational gridded dataset
#' @seealso \code{\link{makeMultiGrid}}, \code{\link[loadeR]{loadGridData}}
#' @examples 
#' data("EOBS_Iberia_tp")
#' total.precip.annual <- aggregateGrid(EOBS_Iberia_tp,
#'                                      aggr.m = list(FUN = sum),
#'                                      aggr.y = list(FUN = sum))
#' plotClimatology(climatology(total.precip.annual), 
#'                 backdrop.theme = "countries", scales = list(draw = TRUE),
#'                 main = "Mean Total DJF precip (mm) 1998-2000")

NULL

#' @title Station daily precipitation dataset in Iberia
#' @description Station data from the VALUE_ECA_86_v2 dataset containing daily precipitation for stations in the Iberian Peninsula.
#' @format Station data
#' @name VALUE_Iberia_tp
#' @docType data
#' @source  Subset of VALUE station data. Full dataset is accessible 
#' for download in \url{http://meteo.unican.es/work/downscaler/data/VALUE_ECA_86_v2.tar.gz}.
NULL

#' @title Station mean temperature dataset
#' @description Station data from the VALUE_ECA_86_v2 dataset containing daily mean temperature for for stations in the Iberian Peninsula.
#' @format Station data
#' @name VALUE_Iberia_tas
#' @docType data
#' @source  Subset of VALUE station data. Full dataset is accessible 
#' for download in \url{http://meteo.unican.es/work/downscaler/data/VALUE_ECA_86_v2.tar.gz}.
NULL


#' @title Station daily precipitation data
#' @description Station data from the VALUE_ECA_86_v2 dataset containing daily precipitation for the Igueldo-SanSebastian station. 
#' @format Station data
#' @name VALUE_Igueldo_tp
#' @docType data
#' @source  Subset of VALUE station data. Full dataset is accessible 
#' for download in \url{http://meteo.unican.es/work/downscaler/data/VALUE_ECA_86_v2.tar.gz}.
NULL

#' @title Grid containing NCEP reanalysis data of precipitation for the Iberian Peninsula.
#' @description NCEP_Iberia_tp is a grid object returned by loadECOMS from package loadeR.ECOMS
#' @format A grid
#' @name NCEP_Iberia_tp
#' @docType data
#' @keywords NCEP reanalysis
#' @source  subset of NCEP reanalysis data, which is accessible through the \strong{ECOMS User Data Gateway (ECOMS-UDG)} 
NULL