""" This contains a function to run Mathematica commands from python.
    Inspired from http://mathematica.stackexchange.com/questions/4643/how-to-use-mathematica-functions-in-python-programs
"""
__author__ = 'marchdf'

import subprocess as sp

def run_mathematica_cmd(cmd):
    print("Running Mathematica command: ", cmd)

    # Launch the process
    proc = sp.Popen('run_mathematica.sh '+cmd, shell=True, stdout=sp.PIPE,stderr=sp.PIPE)

    # Wait for it to end and get the output
    out,err = proc.communicate()
    errcode = proc.returncode

    out = check_mathematica_output(out,cmd)

    if errcode == 0:
        return out
    else:
        print('Failed to run Mathematica command. Exiting')
        exit

#================================================================================
def check_mathematica_output(out,cmd):
    # If the mathematica output contains error output (i.e. ::
    # characters), let the user know and rerun the command using the
    # Quiet mode of mathematica

    if '::' in out:
        print('The mathematica command ran but spit out some erros:')
        #print out
        print('Running the same command in Quiet mode to suppress error output.')
        out = run_mathematica_cmd('Quiet['+cmd+']')


    return out
