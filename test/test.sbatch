#!/bin/bash

#  set the number of nodes
#SBATCH --nodes=1

#  set max wall-clock time (D-HH:MM:SS)
#SBATCH --time=0-12:00:00

#  set partition/queue to use
#SBATCH --partition=day-long-cpu

#  set name of job
#SBATCH --job-name=test_job

#  set name of output file
#SBATCH --output=test.output

#  mail alert at start, end and abortion of execution
#SBATCH --mail-type=ALL

#  send mail to this address
#SBATCH --mail-user=broque@clarku.edu

echo "Hello World"
