#!/bin/bash
#SBATCH --job-name=Cups_3dlmer_BFvsParent_NoPM_quad
#SBATCH --output=output/Cups_3dlmer_BFvsParent_NoPM_quad.log
#SBATCH --time=3-00:00:00
#SBATCH --cpus-per-task=15
#SBATCH --ntasks=1
#SBATCH --mem=40g
#SBATCH --partition=general
#SBATCH --constraint="[rhel7|rhel8]"

module load afni/20.3.00 
module load r/3.6.0 

echo 'R_LIBS_USER="~/R/libs"' >  $HOME/.Renviron
export R_MAX_VSIZE=32000000000

3dLMEr -prefix 3dLMEr_nopm_quad -jobs 28 \
 -model 'decision*grade_6_2+decision*grade_6+(1+grade_6_2+grade_6|Subj)' \
 -qVars "grade_6_2,grade_6" \
 -qVarCenters "0,0" \
 -gltCode Uncertain_BF 'decision : 1*unc_bf' \
 -gltCode Uncertain_Parent 'decision : 1*unc_pa' \
 -gltCode Uncertain_BF-Uncertain_Parent  'decision : 1*unc_bf -1*unc_pa' \
 -gltCode grade_6_2.Uncertain_BF  'decision : 1*unc_bf grade_6_2 : ' \
 -gltCode grade_6_2.Uncertain_Parent  'decision : 1*unc_pa grade_6_2 : ' \
 -gltCode grade_6_2.Uncertain_BF-Uncertain_Parent  'decision : 1*unc_bf -1*unc_pa grade_6_2 : ' \
 -dataTable \
