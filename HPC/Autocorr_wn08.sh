#PBS -l walltime=60:00:00

#PBS -l select=1:ncpus=12:host=wn08

#PBS -l place=exclhost

#PBS -M francesco.bodria@studenti.unipr.it

#PBS -m abe

cd $PBS_O_WORKDIR

module load matlab

matlab -nodisplay -r Autocorr_data_creating_08

