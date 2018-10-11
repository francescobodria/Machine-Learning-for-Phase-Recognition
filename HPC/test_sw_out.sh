#PBS -l walltime=72:00:00

#PBS -l select=1:ncpus=12:host=wn06

#PBS -l place=exclhost

#PBS -M francesco.bodria@studenti.unipr.it

#PBS -m abe

cd $PBS_O_WORKDIR

module load matlab

matlab -nodisplay -r datacreating_sw_test_out

