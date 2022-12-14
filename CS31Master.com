#!/bin/csh -f


#Parametres
set mpath= models


foreach BLABLA (\
4825g1.5z-3.00a0.40t1.5.interpol\
)

set Etoile     = 'CS31082-001'
set deltalam   = '0.01'
set MODEL      = ${BLABLA}
set PARAMETERFILE = 'parameter.dat'
set METALLIC   = '-2.9'
set TURBVEL    = '1.8'

set MOLECULE_LIST = 'LISTE_molecules_all_v12.1.dat'

set Fe_ab=4.60
set C_ab=5.82
set N_ab=5.22
set O_ab=6.52
set Mg_ab=5.04


date
set lam_min    = '3700'
set lam_max    = '3800'
set SUFFIX     = _${lam_min}-${lam_max}.spec


set result     = EtoileCS31-Test.spec


#######################################################################

#Abonds

foreach Be_ab (-2.4)

foreach C_ab (5.82)
foreach N_ab (5.22)
foreach O_ab (6.52)


foreach Na_ab (3.70)
foreach Mg_ab (5.04)
foreach Al_ab (2.83)
foreach Si_ab (4.89)
foreach S_ab  (4.54)#
foreach K_ab  (2.87)#
foreach Ca_ab (3.87)
foreach Sc_ab (0.30)
foreach Ti_ab (2.4)
foreach V_ab (1.25)
foreach Cr_ab (2.43)
foreach Mn_ab (2.14)
foreach Co_ab (2.28)
foreach Ni_ab (3.37)
foreach Cu_ab (0.50)
foreach Zn_ab (1.88)
foreach Ge_ab (0.1)

foreach As_ab (-0.53)#
foreach Se_ab (0.45)#


foreach Sr_ab (0.72)
foreach Y_ab (0.00)
foreach Zr_ab (0.43)
foreach Nb_ab (-0.55)
foreach Mo_ab (-0.11)
foreach Ru_ab (0.36)
foreach Rh_ab (-0.42)
foreach Pd_ab (-0.05)
foreach Ag_ab (-0.81)
foreach Cd_ab (-1.13)#
#Sn
foreach Ba_ab (+0.40)
foreach La_ab (-0.60)
foreach Ce_ab (-0.31)
foreach Pr_ab (-0.86)
foreach Nd_ab (-0.13)
foreach Sm_ab (-0.51)
foreach Eu_ab (-0.76)
foreach Gd_ab (-0.27)
foreach Tb_ab (-1.26)
foreach Dy_ab (-0.21)
foreach Er_ab (-0.27)
foreach Tm_ab (-1.24)
foreach Hf_ab (-0.59)
#Lu
foreach Ta_ab (-2.77)#
foreach Re_ab (-1.63)#
foreach Os_ab (-0.43)
foreach Ir_ab (0.20)
foreach Pt_ab (0.30)
foreach Au_ab (-1.00)
foreach Pb_ab (-0.2)
foreach Bi_ab (-0.2)
foreach Th_ab (-0.98)

foreach U_ab (-1.92)

#new elemets

foreach Sn_ab (1.22)
foreach Ho_ab (-0.86)
foreach Yb_ab (0.83)
foreach Lu_ab (-1.00)


foreach Fe_ab (4.60)


#
# ABUNDANCES FROM THE MODEL ARE NOT USED !!!

########################################################################

../exec-gf-v19.1/bsyn_lu <<EOF
'LAMBDA_MIN:'     '${lam_min}'
'LAMBDA_MAX:'     '${lam_max}'
'LAMBDA_STEP:'    '${deltalam}'
'INTENSITY/FLUX:' 'Flux'
'COS(THETA)    :' '1.00'
'ABFIND        :' '.false.'
'MODELOPAC:' 'contopac/${MODEL}opac'
'RESULTFILE :' 'syntspec/${result}'
'METALLICITY:'    '${METALLIC}'
'ALPHA/Fe   :'    '0.40'
'HELIUM     :'    '0.00'
'R-PROCESS  :'    '0.00'
'S-PROCESS  :'    '0.00'
'INDIVIDUAL ABUNDANCES:'   '61'
4  $Be_ab
6  $C_ab
7  $N_ab
8  $O_ab
11 $Na_ab
12 $Mg_ab
13 $Al_ab
14 $Si_ab
16 $S_ab
19 $K_ab
20 $Ca_ab
21 $Sc_ab
22 $Ti_ab
23 $V_ab
24 $Cr_ab
25 $Mn_ab
26 $Fe_ab
27 $Co_ab
28 $Ni_ab
29 $Cu_ab
30 $Zn_ab
32 $Ge_ab
33 $As_ab
34 $Se_ab
38 $Sr_ab
39 $Y_ab
40 $Zr_ab
41 $Nb_ab
42 $Mo_ab
44 $Ru_ab
45 $Rh_ab
46 $Pd_ab
47 $Ag_ab
48 $Cd_ab
50 $Sn_ab
56 $Ba_ab
57 $La_ab
58 $Ce_ab
59 $Pr_ab
60 $Nd_ab
62 $Sm_ab
63 $Eu_ab
64 $Gd_ab
65 $Tb_ab
66 $Dy_ab
67 $Ho_ab
68 $Er_ab
69 $Tm_ab
70 $Yb_ab
71 $Lu_ab
72 $Hf_ab
73 $Ta_ab
75 $Re_ab
76 $Os_ab
77 $Ir_ab
78 $Pt_ab
79 $Au_ab
82 $Pb_ab
83 $Bi_ab
90 $Th_ab
92 $U_ab


'ISOTOPES : ' '0'
'NFILES   :' '13'
DATA/Hlinedata
linelists/syn_all_3000_10000_2014HFS.list
linelists/C12H-AX.list
linelists/C12H-BX.list
linelists/C12H-CX.list
linelists/C13H-AX.list
linelists/C13H-BX.list
linelists/C13H-CX.list
linelists/C12N14Vnew_2000-4100.list
linelists/C13N14Vnew_2000-4100.list
linelists/N14H-AX-2011.bsyn.list
linelists/15NH-bsyn_2000-4100.list
linelists/16OH_A-X-bsyn_2000-4100.list
'SPHERICAL:'  'F'
  30
  300.00
  15
  1.30
EOF
########################################################################
date
end
