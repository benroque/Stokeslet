#!/bin/bash

#  set the number of nodes
#SBATCH --nodes=1

#  set max wall-clock time (D-HH:MM:SS)
#SBATCH --time=0-24:00:00

#  set partition/queue to use
#SBATCH --partition=day-long-cpu

#  set name of job
#SBATCH --job-name=Magnetic_Free

#  set name of output file
#SBATCH --output=Magnetic_Free.output

#  mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

#  send mail to this address
#SBATCH --mail-user=broque@clarku.edu

module load matlab

matlab -nodisplay < Magnetic_Free.m
