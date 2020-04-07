! simple hf calc, basis set spec.
! casscf 

memory,2,G 
! memory specification, 
! note that molpro uses more than this memory when parallelized

basis={
Lu=cc-pvdz;
F=cc-pvdz
}
! setting individual basis for each atom

symmetry,nosym
Angstrom

geometry={
         lu;                          !z-matrix
         f,lu,2.0;
         }

{hf 
wf,79,0,1}
! simple hf calc, wf also specify spin & charge


{casscf
closed,37
occ, 44
wf,79,0,1
state,1,1
RESTRICT,-1,-1,orbital list
}
! casscf calc, restrict is used for convergence 





