! simple hf calc, basis set spec.
! casscf 
! loops
 
memory,2,G 
! memory specification, note that molpro uses more than this memory when parallelized
SET,DKHO=101

basis={
Lu=cc-pvtz-x2c;
F=cc-pvtz
}
! relativitic basis sets

symmetry,nosym
Angstrom

geometry={
         lu;                          !z-matrix
         f,lu,distances(i);
         }

distances=[1.7,1.75,1.8,1.85,1.9,1.95,2.0,2.05,2.1,2.15,2.2,2.25,2.3,2.35,2.4]
! specify distances

!list of distances
i=0                                   !initialize a counter
do ir1=1,#distances                   !loop over distances for O-H1
i=i+1                                 !increment counter
r1(i)=distances(ir1)                  !save r1 for this geometry


geometry={
         lu;                          !z-matrix
         f,lu,2.0;
         }

{hf 
wf,79,0,1}
! simple hf calc, wf also specify spin & charge

en1(i)=energy

{casscf
closed,37
occ, 44
wf,79,0,1
state,1,1
RESTRICT,-1,-1,orbital list
}
! casscf calc, restrict is used for convergence 

en2(i)=energy

rs2c,root=2 , shift=0.5
! caspt2, contractied

en3(i)=energy
enddo

{table,r1,en1,en2,en3   !produce a table with results
head, r1,hf, casscf, caspt2    !modify column headers for table
save,luf_es.tab                          !save the table in file h2o.tab
title,luf, es scan,   !title for table
sort,1}

! making tables with molpro 


