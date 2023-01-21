#!/bin/bash
#SBATCH --job-name=Cups_3dlmer_BFvsParent_PM
#SBATCH --output=output/Cups_3dlmer_BFvsParent_PM.log
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

3dLMEr -prefix 3dLMEr_pm -jobs 28 \
 -model 'decision*grade_6+(1+grade_6|Subj)' \
 -qVars "grade_6" \
 -qVarCenters "0" \
 -gltCode Uncertain_PM_BF 'decision : 1*unc_pm_bf' \
 -gltCode Uncertain_PM_Parent 'decision : 1*unc_pm_pa' \
 -gltCode Uncertain_PM_BF-Uncertain_PM_Parent  'decision : 1*unc_pm_bf -1*unc_pm_pa' \
 -gltCode grade_6.Uncertain_PM_BF  'decision : 1*unc_pm_bf grade_6 : ' \
 -gltCode grade_6.Uncertain_PM_Parent  'decision : 1*unc_pm_pa grade_6 : ' \
 -gltCode grade_6.Uncertain_PM_BF-Uncertain_PM_Parent  'decision : 1*unc_pm_bf -1*unc_pm_pa grade_6 : ' \
 -gltCode grade6.Uncertain_PM_BF  'decision : 1*unc_pm_bf grade_6 : 0' \
 -gltCode grade7.Uncertain_PM_BF  'decision : 1*unc_pm_bf grade_6 : 1' \
 -gltCode grade8.Uncertain_PM_BF  'decision : 1*unc_pm_bf grade_6 : 2' \
 -gltCode grade9.Uncertain_PM_BF  'decision : 1*unc_pm_bf grade_6 : 3' \
 -gltCode grade6.Uncertain_PM_Parent   'decision : 1*unc_pm_pa grade_6 : 0' \
 -gltCode grade7.Uncertain_PM_Parent   'decision : 1*unc_pm_pa grade_6 : 1' \
 -gltCode grade8.Uncertain_PM_Parent   'decision : 1*unc_pm_pa grade_6 : 2' \
 -gltCode grade9.Uncertain_PM_Parent   'decision : 1*unc_pm_pa grade_6 : 3' \
 -gltCode grade6.Uncertain_PM_BF-Uncertain_PM_Parent   'decision : 1*unc_pm_bf -1*unc_pm_pa grade_6 : 0' \
 -gltCode grade7.Uncertain_PM_BF-Uncertain_PM_Parent   'decision : 1*unc_pm_bf -1*unc_pm_pa grade_6 : 1' \
 -gltCode grade8.Uncertain_PM_BF-Uncertain_PM_Parent  'decision : 1*unc_pm_bf -1*unc_pm_pa grade_6 : 2' \
 -gltCode grade9.Uncertain_PM_BF-Uncertain_PM_Parent  'decision : 1*unc_pm_bf -1*unc_pm_pa grade_6 : 3' \
 -dataTable \
