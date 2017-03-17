#!/usr/bin/env python2
#
# SCRIPT NOT IN USE!!! because it became too complex... it's not
# necessary to be so complicated. Going to add things straight to the
# crontab and put the exclude files in my dotfiles.
#
#
# Backup parts of navier.engin.umich.edu to a drive specified in the call
#
#
__author__ = 'marchdf'
def usage():
    print '\nUsage: {0:s} [options ...]\nOptions:\n  -d, --dry-run\tdebug and dry run\n  -t, --type\ttype of backup to do (necessary)\n  -o, --out\tbackup destination (default nas1)\n  -h, --help\tshow this message and exit\n'.format(sys.argv[0])

#================================================================================
#
# Imports
#
#================================================================================
# Ignore deprecation warnings
import warnings
warnings.filterwarnings("ignore", category=DeprecationWarning)
import sys, getopt
import os
import subprocess as sp
import urllib2
import shutil
from subprocess import call
from datetime import datetime
import copy

#================================================================================
#
# Parse arguments
#
#================================================================================
# Parse command line arguments using getopt (argparse is better but require python 1.7 at least)
# from: http://www.cyberciti.biz/faq/python-command-line-arguments-argv-example/


rsync_cmd = ['rsync','-avz']
destination = '/mnt/nas1/'
# This rsync command is not ideal. Ideally you would just use rsync
# -avz. However, Box.com is not very nice and, according to
# http://unix.stackexchange.com/questions/78933/rsync-mkstemp-failed-invalid-argument-22-with-davfs-mount-of-box-com-cloud
# and
# http://www.p14nd4.com/blog/2012/08/15/box-com-rsync-problem-solved/,
# we need to change the rsync command. We add --inplace to avoid
# temporary file creation (which really slows things down) and we add
# a size comparison (instead of the default checksum) to compare files
# (also speeds things up). We also are removing things like copying
# symlinks and preserving permissions because the give us a lot of
# errors on Box.
#
#rsync_cmd = ['rsync','-rtgoDvhP','--inplace','--size-only','--bwlimit=64']

bkp_type = []
try:
    myopts, args = getopt.getopt(sys.argv[1:],"hdt:",["help","dry-run","type="])
except getopt.GetoptError as e:
    print (str(e))
    usage()
    sys.exit(2)

for o, a in myopts:
    if o in ('-h', '--help'):
        usage()

        sys.exit()

    elif o in ('-d', '--dry-run'):
        print '\n\nTHIS IS A DRY RUN\n\n'
        rsync_cmd.append('--dry-run')

    elif o == '-t':
        if a == 'home':
            print 'Backing up home directory'
            bkp_type.append(0)

        elif a == 'data':
            print 'Backing up data directory'
            bkp_type.append(1)

        elif a == 'git':
            print 'Backing up git user home directory. Requires root permissions'
            bkp_type.append(2)

        elif a == 'system':
            print 'Backing up entire system. Requires root permissions'
            bkp_type.append(3)

        else: 
            print 'Invalid backup type specified. Choose from these types:'
            print '   - home'
            print '   - data'
            print '   - git (requires root permission)'
            print '   - system (requires root permission)'
            print 'Exiting.'
            sys.exit()

# Exit if something the type of backup was not specified
if not bkp_type:
    print 'No backup type specified. Exiting.'
    sys.exit()

#================================================================================
#
# Define some functions
#
#================================================================================
def get_general_exclude_file(HOMEDIR):
    #
    # Get an exclude file from GitHub. Idea from https://askubuntu.com/questions/545655/backup-your-home-directory-with-rsync-and-skip-useless-folders
    # 
    fname = HOMEDIR+'rsync_homedir_excludes.txt'
    try: 
        # get the file
        response = urllib2.urlopen('https://raw.githubusercontent.com/rubo77/rsync-homedir-excludes/master/rsync-homedir-excludes.txt')

        # Save it to a file
        with open(fname, 'wb') as fp:
            shutil.copyfileobj(response, fp)
    except: 
        print 'Failed to get general exclude file from git'

    return fname


#================================================================================
def make_my_exclude_file(HOMEDIR):
    #
    # My own personal exclude file
    # 
    fname = HOMEDIR+'my_rsync_homedir_excludes.txt'
    
    # list of things to be excluded
    exclude_list = ['/box/*',
                    '/cachome/*',
                    '/Downloads/*',
                    '/fluxscratch/*',
                    '/lonestar_home/*',
                    '/lonestar_scratch/*',
                    '/maverick_home/*',
                    '/maverick_scratch/*',
                    '/mnt/*',
                    '/nas1/*',
                    '/nas2/*',
                    '/backup/*',
                    '/stampede_home/*',
                    '/stampede_scratch/*']

    # write to file
    with open(fname,'w') as f:
        for exclude in exclude_list:
            f.write("%s\n" % exclude)

    return fname

#================================================================================
def make_system_exclude_file(HOMEDIR):
    #
    # My exclude file for entire system bkp
    # 
    fname = HOMEDIR+'my_rsync_system_excludes.txt'
    
    # list of things to be excluded
    exclude_list = ['/boot/*',
                    '/dev/*',
                    '/home/*',
                    '/lost+found*',
                    '/media/*',
                    '/mnt/*',
                    '/proc/*',
                    '/run/*',
                    '/sys/*',
                    '/tmp/*']

    # write to file
    with open(fname,'w') as f:
        for exclude in exclude_list:
            f.write("%s\n" % exclude)

    return fname


#================================================================================
def check_status(err,msg):
    if err is not None:
        send_failure_email(msg+err)
        sys.exit()


#================================================================================
def send_succes_email():
    # Send an email with message msg
    subject = 'Successful backup run'
    cmd_email = 'echo \"'+subject+'\" | mutt -s \"[BACKUP] '+subject+'\" -a '+LOGTAR+' -- '+email
    call(cmd_email, shell=True)

#================================================================================
def send_failure_email(msg):
    # Send an email indicating failure
    subject = 'Failed backup run'
    cmd_email = 'echo \"'+msg+'\" | mutt -s \"[BACKUP] '+subject+'\" -- '+email
    call(cmd_email, shell=True)


#================================================================================
def make_bkp(dir2bkp,bkpdir,msg,rsync_cmd,excludes=None):
    # Backup a directory 

    # Make the rsync command
    # take into account excludes
    local_rsync_cmd = copy.deepcopy(rsync_cmd)
    if excludes is not None: 
        for f in excludes: 
            local_rsync_cmd.append('--exclude-from='+f)

    # finish the rsync cmd
    local_rsync_cmd.append(dir2bkp)
    local_rsync_cmd.append(bkpdir)

    # Do the backup
    p = sp.Popen(local_rsync_cmd, stdout=sp.PIPE)
    out, err = p.communicate()
    check_status(err,'Failure on '+msg+'.\n\n')

    # output the log
    with open(LOGFILE, "a") as f:
        f.write('\n#================================================================================\n')
        f.write('#\n')
        f.write('# '+msg+'\n')
        f.write('#\n')
        f.write('#================================================================================\n')
        f.write("%s" % out)

#================================================================================
#
# Basic information/setup
#
#================================================================================
email = 'marchdf@gmail.com'
HOMEDIR = '/home/marchdf/'
LOGFILE = HOMEDIR+'backup_log.txt'
LOGTAR  = HOMEDIR+'backup_log.tar.gz'
today = datetime.today()
with open(LOGFILE, "w") as f:
    f.write('\nBackup on '+today.strftime('%Y/%m/%d')+'\n\n')

# Get a generic exclude file
generic_exclude = get_general_exclude_file(HOMEDIR)

# Make my own exclude file
home_exclude = make_my_exclude_file(HOMEDIR)

# Make my own exclude file
system_exclude = make_system_exclude_file(HOMEDIR)


#================================================================================
#
# Backup the home directory
#
#================================================================================
if 0 in bkp_type:
    dir2bkp = HOMEDIR
    bkpdir  = '/home/marchdf/box/backup_navier/backup_home/'
    msg     = 'HOME DIRECTORY BACKUP'
    make_bkp(dir2bkp,bkpdir,msg,rsync_cmd,[generic_exclude,home_exclude])

#================================================================================
#
# Backup the data directory
#
#================================================================================
if 1 in bkp_type:
    dir2bkp = '/mnt/tmp1/marchdf/'
    bkpdir  = '/home/marchdf/box/backup_navier/backup_data/'
    msg     = 'DATA DIRECTORY BACKUP'
    make_bkp(dir2bkp,bkpdir,msg,rsync_cmd,[generic_exclude,home_exclude])

#================================================================================
#
# Backup the git user home directory (must be root to do this)
#
#================================================================================
if 2 in bkp_type:
    dir2bkp = '/home/git/'
    bkpdir  = '/home/marchdf/box/backup_navier/backup_gitolite/'
    msg     = 'GIT HOME DIRECTORY BACKUP'
    make_bkp(dir2bkp,bkpdir,msg,rsync_cmd)

#================================================================================
#
# Backup the whole system except the home directories (must be root to do this)
#
#================================================================================
if 3 in bkp_type:
    dir2bkp = '/'
    bkpdir  = '/home/marchdf/box/backup_navier/backup_system/'
    msg     = 'ENTIRE SYSTEM BACKUP'
    make_bkp(dir2bkp,bkpdir,msg,rsync_cmd,[system_exclude])

#================================================================================
#
# Compress the rsync log for emailing purposes
#
#================================================================================
p = sp.Popen(['tar','-cz',LOGTAR,LOGFILE], stdout=sp.PIPE)
out, err = p.communicate()
check_status(err,'Failure on compressing backup logs.\n\n')

#================================================================================
#
# If you reached here, you've been successful
#
#================================================================================
send_succes_email()
