! hf, basis set spec.
! orbital printing

memory,2,G 
! memory specification, note that molpro uses more than this memory when parallelized

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
put,molden,hf.molden;
! orbital plotting








