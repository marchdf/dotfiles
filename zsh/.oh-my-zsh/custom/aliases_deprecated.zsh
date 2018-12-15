# Deprecated aliases and functions

USE_DEPRECATED=FALSE

if [ "$USE_DEPRECATED" = TRUE ]; then
    echo 'Be careful not to fall off!!!'

    #================================================================================
    # General ones
    alias sx='source ~/.xinitrc'
    # Classic 21 radio, if not working check something like https://fluxradios.blogspot.com/2014/07/flux-url-classic-21.html
    alias c21="vlc https://www.static.rtbf.be/radio/classic21/m3u/classic21-mp3.m3u"

    #================================================================================
    # First laptop
    if [[ ${(%):-%M} = *laptop* ]]; then
        alias wakenavier='wakeonlan 2C:41:38:4F:E8:47'
    fi

    #================================================================================
    # NREL laptop
    if [[ ${(%):-%M} = *31595s* ]]; then

        # custom make command for BoxLib to set the compilers from homebrew
        alias makeBL='make CC=gcc-6 CXX=g++-6 F90=gfortran-6 FC=gfortran-6'

        alias hpc='cd /Volumes/backup/backups/navier_datadrive/marchdf/hpcdata/'

        # Make our custom vagrant ssh. This is so the color-ssh in
        # iterm2_ssh_switch_tab_color.zsh gets called and we can easily
        # detect that we are on the Vagrant VM.
        # adapted from : http://stackoverflow.com/questions/10864372/how-to-ssh-to-vagrant-without-actually-running-vagrant-ssh
        function ssh-vagrant () { color-ssh $(vagrant ssh-config | awk 'NR>1 {print " -o "$1"="$2}') localhost}
        alias sv=ssh-vagrant

        alias visit="/Applications/VisIt.app/Contents/Resources/bin/visit"

    fi

    #================================================================================
    # These are my custom aliases for navier.engin.umich.edu
    if [[ ${(%):-%M} = *navier* ]]; then
        alias nyx='ssh marchdf@nyx-login-intel.engin.umich.edu'
        alias flux='ssh -X marchdf@flux-login1.engin.umich.edu'
        alias alcf='ssh -X marchdf@intrepid.alcf.anl.gov'
        alias lonestar='ssh -X marchdf@lonestar.tacc.utexas.edu'
        alias stampede='ssh -X marchdf@login1.stampede.tacc.utexas.edu'
        alias maverick='ssh -X marchdf@login1.maverick.tacc.utexas.edu'
        alias matlab='matlab -nosplash -nodesktop'
        alias mnt_nyx_bkp='sshfs marchdf@nyx-login.engin.umich.edu:/nobackup/marchdf /mnt/nyxnobackup'
        alias mnt_nyx='sshfs marchdf@nyx-login.engin.umich.edu:/home/marchdf /mnt/nyxhome'
        alias mnt_flux_bkp='sshfs marchdf@flux-login.engin.umich.edu:/scratch/ejohnsen_flux/marchdf /mnt/fluxscratch'
        alias mnt_flux='sshfs marchdf@flux-login.engin.umich.edu:/home/marchdf /mnt/cachome'
        alias mnt_lonestar_scratch='sshfs marchdf@lonestar.tacc.utexas.edu:/work/02366/marchdf /mnt/lonestar_scratch'
        alias mnt_lonestar='sshfs marchdf@lonestar.tacc.utexas.edu:/home1/02366/marchdf /mnt/lonestar_home'
        alias mnt_stampede_scratch='sshfs marchdf@stampede.tacc.utexas.edu:/work/02366/marchdf /mnt/stampede_scratch'
        alias mnt_stampede='sshfs marchdf@stampede.tacc.utexas.edu:/home1/02366/marchdf /mnt/stampede_home'
        alias mnt_maverick_scratch='sshfs marchdf@maverick.tacc.utexas.edu:/work/02366/marchdf /mnt/maverick_scratch'
        alias mnt_maverick='sshfs marchdf@maverick.tacc.utexas.edu:/home1/02366/marchdf /mnt/maverick_home'
        alias hpc='cd /mnt/datadrive/marchdf/hpcdata'
        alias rdp_umich='rdesktop -g 90% -a 32 -r clipboard:CLIPBOARD -u UMROOT\\marchdf -r disk:doc=/home/marchdf/Dropbox'
        alias rdp_bern='rdesktop -g 90% -a 32 -r clipboard:CLIPBOARD -u UMROOT\\marchdf -r disk:doc=/home/marchdf/Dropbox me-bernoulli.adsroot.itcs.umich.edu'
        alias mcfpl='sudo mount -t davfs https://ctools.umich.edu/dav/b4112ada-8342-4478-9bfc-d73ebd116e99 ~/mnt/ctools/cfpl/ '
        alias list-repos='sudo yum repolist all'
        alias enable-epel='sudo yum-config-manager --enable epel'
        alias disable-epel='sudo yum-config-manager --disable epel'
        alias enable-centos='sudo yum-config-manager --enable centos'
        alias disable-centos='sudo yum-config-manager --disable centos'
        alias enable-naulinux-school='sudo yum-config-manager --enable naulinux-school'
        alias disable-naulinux-school='sudo yum-config-manager --disable naulinux-school'
        alias enable-elrepo='sudo yum-config-manager --enable elrepo'
        alias disable-elrepo='sudo yum-config-manager --disable elrepo'
        alias update-only-security='sudo yum update-minimal --security -y ' # according to https://access.redhat.com/solutions/10021
        alias mesr="cd /home/marchdf/.gvfs/software\ on\ me-dist.engin.umich.edu/"
        alias count_lines_of_code="find . -name '*.h' -o -name '*.cc' -o -name '*.cu' | xargs wc -l"

        # Function to copy pdf to ctools (copy file to subgroup)
        function cpsg () { cp $1 "~/mnt/ctools/cfpl/Group meeting research/Shocks, turbulence and plasmas subgroup/$2"; }
     fi
fi
