#================================================================================
#
# These are my custom aliases for navier.engin.umich.edu
#
#================================================================================
if [[ ${(%):-%M} = *navier* ]]; then
   alias nyx='ssh marchdf@nyx-login-intel.engin.umich.edu'
   alias flux='ssh -X marchdf@flux-login1.engin.umich.edu'
   alias alcf='ssh -X marchdf@intrepid.alcf.anl.gov'
   alias lonestar='ssh -X marchdf@lonestar.tacc.utexas.edu'
   alias stampede='ssh -X marchdf@login1.stampede.tacc.utexas.edu'
   alias maverick='ssh -X marchdf@login1.maverick.tacc.utexas.edu'
   alias c21='vlc http://www.static.rtbf.be/radio/classic21/m3u/classic21_128k.m3u'
   alias matlab='matlab -nosplash -nodesktop'
   alias mnt_nyx_bkp='sshfs marchdf@nyx-login.engin.umich.edu:/nobackup/marchdf nyxnobackup'
   alias mnt_nyx='sshfs marchdf@nyx-login.engin.umich.edu:/home/marchdf nyxhome'
   alias mnt_flux_bkp='sshfs marchdf@flux-login.engin.umich.edu:/scratch/ejohnsen_flux/marchdf fluxscratch'
   alias mnt_flux='sshfs marchdf@flux-login.engin.umich.edu:/home/marchdf cachome'
   alias mnt_lonestar_scratch='sshfs marchdf@lonestar.tacc.utexas.edu:/work/02366/marchdf lonestar_scratch'
   alias mnt_lonestar='sshfs marchdf@lonestar.tacc.utexas.edu:/home1/02366/marchdf lonestar_home'
   alias mnt_stampede_scratch='sshfs marchdf@stampede.tacc.utexas.edu:/work/02366/marchdf stampede_scratch'
   alias mnt_stampede='sshfs marchdf@stampede.tacc.utexas.edu:/home1/02366/marchdf stampede_home'
   alias mnt_maverick_scratch='sshfs marchdf@maverick.tacc.utexas.edu:/work/02366/marchdf maverick_scratch'
   alias mnt_maverick='sshfs marchdf@maverick.tacc.utexas.edu:/home1/02366/marchdf maverick_home'
   alias hpc='cd /mnt/datadrive/marchdf/hpcdata'
   alias rdp_umich='rdesktop -g 90% -a 32 -r clipboard:CLIPBOARD -u UMROOT\\marchdf -r disk:doc=/home/marchdf/Dropbox'
   alias rdp_bern='rdesktop -g 90% -a 32 -r clipboard:CLIPBOARD -u UMROOT\\marchdf -r disk:doc=/home/marchdf/Dropbox me-bernoulli.adsroot.itcs.umich.edu'
   alias empty_space='printf ''\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n\\n'''
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

   # corporate BS generator
   #alias cbsg='curl -s http://cbsg.sourceforge.net/cgi-bin/live | grep -Eo "^<li>.*</li>" | sed s,\</\\?li\>,,g | shuf -n 1 '
fi
