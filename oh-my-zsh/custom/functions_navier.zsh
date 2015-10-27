#================================================================================
#
# These are my custom functions for navier.engin.umich.edu
#
#================================================================================
if [[ ${(%):-%M} = *navier* ]]; then

   # Function to copy pdf to ctools (copy file to subgroup)
   function cpsg () { cp $1 "~/mnt/ctools/cfpl/Group meeting research/Shocks, turbulence and plasmas subgroup/$2"; }

fi

