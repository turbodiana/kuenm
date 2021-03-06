#' Helper function to describe results from other functions
#'
#' @param process (character) name of the function which results derive from. Options include:
#' "kuenm_projchanges", "kuenm_modvar", "kuenm_hierpart", "kuenm_mmop", and "kuenm_mopagree".
#' @param result.table (data.frame) data.frame with the description of results. Only used when
#' \code{process} = "kuenm_projchanges" or "kuenm_mopagree".
#' @param out.dir (character) name of the output directory where description file will be written.
#'
#' @export

result_description <- function(process, result.table, out.dir) {
  if (file.exists(paste0(out.dir, "/Result_description (", process,").txt"))) {
    unlink(paste0(out.dir, "/Result_description (", process,").txt"))
  }

  # Description of results of detecting changes in projections
  if (process == "kuenm_projchanges"){
    sink(paste0(out.dir, "/Result_description (", process,").txt"))
    cat("Description of results generated by the function kuenm_projchanges\n\n\n")
    cat("A folder or folders named starting with Changes contain all results per extrapolation type.
Each folder contains subfolders per each period of projection. Inside the period folders,
subfolders per each scenario of projection can be found.\n\n")
    cat("Inside each Scenario folder you will find:\n")
    cat("\t- A folder (Binary) containing all binarized (thresholded) models.\n")
    cat("\t- A raster file of the comparison of continuous median models of current and projection
\t  periods. Name = continuous_comparison.\n")
    cat("\t- A raster file of the comparison of binary models considering agreement among distinct GCMs if
\t  more than one of them where used. Name: binary_comparison.\n\n")
    cat("Description of values in rasters resulted from  comparisons:\n")
    cat("\t- Continuous comparison generally ranges from -1 to 1. Although the range may vary, negative
\t  values represent decrease in suitability and positive values represent increase of this variable;
\t  values close to zero represent more stability.\n")
    cat("\t- The table below indicates what each value in binary comparison represents.\n\n")
    sink()
    suppressWarnings(
      write.table(result.table,
                  paste0(out.dir, "/Result_description (", process,").txt"),
                  sep = "\t", append = TRUE, quote = FALSE, row.names = FALSE)
    )
  }

  # Description of results of creating maps of variance
  if (process == "kuenm_modvar"){
    sink(paste0(out.dir, "/Result_description (", process,").txt"))
    cat("Description of results generated by the function kuenm_modvar\n\n\n")
    cat("A folder or folders named starting with Variation contain all results per extrapolation type.
Each folder contains subfolders per each area of projection. Inside these subfolders,
a raster file for each source of variation will be found.
\nValues in these raster files represent the variance coming from each source of
variation. These values start from zero and are comparable among distinct sources
of variation. \n\nUsing a continuous color scale to plot maps is recommended.")
    sink()
  }

  # Description of results of hierarchical partitioning analyses
  if (process == "kuenm_hierpart"){
    sink(paste0(out.dir, "/Result_description (", process,").txt"))
    cat("Description of results generated by the function kuenm_hierpart\n\n\n")
    cat("A folder or folders named starting with HP_results contain all results per extrapolation type.
Each folder contains subfolders per each area/time of projection in which more than
one source of variation is considered. Per each area of projection, a folder contains
csv files with the numerical results of hierarchical partitioning analyses. If the
argument keep.tables was defined as TRUE, an additional folder containing csv files
with all sampled data per each iteration can be found. A bar-plot summarizing the
total effects of each source of variation on the overall variance can also be found
in each HP_results folder.\n\n")
    cat("Description of csv files resulted from hierarchical partitioning analyses:\n")
    cat("\t- hierpart_Goodness_fit.csv contains values that represent how well the satistical
\t  model fitted the data.\n")
    cat("\t- hierpart_Raw_effects.csv contains values of Independent, Joint, and Total effects
\t  for all iterations of the hierarchical partitioning analysis.\n")
    cat("\t- hierpart_Mean_effects.csv contains mean values of Independent, Joint, and Total
\t  effects from all iterations.\n")
    cat("\t- hierpart_Total_effects_percent.csv contains values of total effects for all
\t  iterations, expressed as percentages. These values are used to create the bar-plot.\n")
    sink()
  }

  # Description of results of MOP analyses for multiple layers
  if (process == "kuenm_mmop"){
    sink(paste0(out.dir, "/Result_description (", process,").txt"))
    cat("Description of results generated by the function kuenm_mmop\n\n\n")
    cat("A folder or folders named as the sets of variables analyzed contain all results of
extrapolation risk analyses using the MOP metric.\n\n")
    cat("Inside each set folder, raster files resulted from MOP analyses can be found. The names
of the raster layers will help to identify the specific time period, RCP (emission scenario),
and/or GCM (general circulation model), to which each raster corresponds.\n\n")
    cat("Values in raster files range from zero to one, where zero represents strict extrapolative
areas, and other values represent levels of similarity between the calibration area and
the specific scenario of projection. Areas of strict extrapolation (values of zero), should be
interpreted carefully.\n\n")
    cat("Representing strict extrapolative areas separate from areas with distinct levels of
similarity is recommended. However, if multiple GCMs where used, users may find convenient to
use the kuenm_mopagree function, which creates raster layers of strict extrapolative areas
agreement among distinct GCMs.")
    sink()
  }

  # Description of results of agreement of extrapolative areas derived from MOP analyses
  if (process == "kuenm_mopagree"){
    sink(paste0(out.dir, "/Result_description (", process,").txt"))
    cat("Description of results generated by the function kuenm_mopagree\n\n\n")
    cat("A folder or folders named as the sets of variables analyzed contain all results of agreement
of strict extrapolative areas among distinct GCMs, per each RCP (emission scenario).\n\n")
    cat("Inside each set folder raster files resulted from exploring the agreement of strict
extrapolative areas among GCMs can be found. The names of the raster layers will help
to identify the specific time period and RCP (emission scenario) to which each raster
corresponds. A raster layer of MOP results for the current period can also be found here.\n\n")
    cat("Values in raster files range from zero to a number equal to the number of GCMs
used to perform model projection. The table below indicates what each value in raster
layers of agreement represents. Values in raster layer for the current period should be
interpreted as in the MOP results.\n\n")
    sink()
    suppressWarnings(
      write.table(result.table,
                  paste0(out.dir, "/Result_description (", process,").txt"),
                  sep = "\t", append = TRUE, quote = FALSE, row.names = FALSE)
    )
  }
}
