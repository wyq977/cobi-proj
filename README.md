# cobi-proj Setup

## Install

1. __cmake__ install on ubuntu: https://apt.kitware.com/
2. __vtk__: https://vtk.org/Wiki/VTK/Configure_and_Build#Download_a_Release / conda install -c conda-forge vtk

## ETHZ euler

To use vtk version 8.1.1, one has to load the following modules, see: https://scicomp.ethz.ch/wiki/VTK

```shell
module load new gcc/4.8.2 open_mpi/1.6.5 java/1.8.0_91 netcdf/4.3.2 python/3.6.1 qt/5.8.0 vtk/8.1.1	
```

To use newer version of cmake
```shell
module load new gcc/4.8.2 cmake/3.11.4	
```