#!/bin/bash

#SBATCH --job-name=Image_Charge
#SBATCH --output=Image_Charge.out
#SBATCH --error=Image_Charge.err
#SBATCH --nodes=1
#SBATCH --ntasks=1

module load matlab

matlab -nodisplay < Image_Charge.m
