#!/bin/bash
#  Written by Jimmy George on March-27- 2014.  
#  Use this script to Check files on a Source folder like a file share or folder and copy all files in this folder to an existing GIT folder locally and check in all files into GIT 
#  Accepts a parameter like Source folder , Destination folder and RepoBranch
# To Run from Windos CMD  : "C:\Program Files (x86)\Git\bin\sh.exe" --login -i -c "C:/GIT/BuildTeamTools/Tools/JimmyScripts/GetFiles_Into_GITRepo.sh //geninfo.com/files/BuildTeam/TEST/Implementations /c/GIT/Implementations develop C:/Logs"

#Variable declarationsss :
SourceFolder=$1  ## Name of the Source folder when people put the files into
DestFolder=$2  ## Name of the local Destination folder that GitHub is cloned to
Branch=$3  ## Your GIT repo url for the corresponding Destination folder.
LogFolderName=$4  ## Folder Where to log

#SourceFolder="//geninfo.com/files/BuildTeam/TEST/Implementations"
#SourceFolder=/c/Temp/Implementations
#DestFolder=/c/GIT/Implementations
#Branch=develop
#LogFolderName=c:/Logs

LOG_FILE=${LogFolderName}/${Branch}.log
Tempfolder=${LogFolderName}/TEMP
currdatetime=`date`

redcolor='\e[1;31m'
cyancolor='\e[0;36m'
yellowcolor='\e[1;33m'
purplecolor='\e[0;35m'
greencolor='\e[0;32m'
nocolor='\e[0m'

### Functions Section ###############
function doexit_statusfail()
{
    currdatetime=`date`;echo -e "\n############### End Execution of GetFiles_Into_GITRepo.sh script at ${currdatetime} ###########################\n"; 
    echo -e "${redcolor} Execution FAILED. ${nocolor}"
    exit 1 ## Exit code 1 = failed and 0 = no errprs
}

function doexit_statusgood()
{
    currdatetime=`date`;echo -e "\n############### End Execution of GetFiles_Into_GITRepo.sh script at ${currdatetime} ###########################\n"
    echo -e "${greencolor} Execution Completed Successfully. ${nocolor}"
    exit 0 ## Exit code 1 = failed and 0 = no errprs
}

function usage()
{
   echo -e "${redcolor}Expected parameter for SourceFolder , Destination folder, Branch name and LogFolderName is missing.. Please rerun with a paramenter"
   echo -e "FORMAT : GetFiles_Into_GITRepo.sh SourceFolder DestFolder Branch LogFolderName"
   echo -e "Example : GetFiles_Into_GITRepo.sh //geninfo.com/files/BuildTeam/TEST/Implementations /c/GIT/Implementations develop C:/Logs"   
   echo -e "This script will setup a new Jeniks job for a Release branch. ${nocolor}"
   doexit_statusfail
}
## END Functions  ###########################

clear

########################### START script Logic  ##############################

echo -e "\n ############### Starting Execution of GetFiles_Into_GITRepo.sh script at ${currdatetime} ${nocolor} ###########################\n"

if [ "${SourceFolder}" == "" ] || [ "${DestFolder}" == "" ] || [ "${Branch}" == "" ] || [ "${LogFolderName}" == "" ]
then
     usage
fi

if [ ! -d ${Tempfolder} ]; then
        mkdir ${Tempfolder}
fi

echo -e "Goint to update with these details : \n SourceFolder=${SourceFolder} \n DestinationFolder = ${DestFolder} \n Branch = ${Branch} \n LogFolderName = ${LogFolderName}\n"

if [ ! -e ${SourceFolder} ] ; then
        echo -e "${redcolor}**** ERROR : FAILED to find SourceFolder at \"${SourceFolder}\" ${nocolor}" 
        doexit
fi

if [ ! -d ${DestFolder} ]
then
        echo -e "${redcolor}ERROR : FAILED to find DestFolder at \"${DestFolder}\" ${nocolor}" 
        doexit_statusfail
fi

if [ ! -d ${DestFolder} ]
then
        echo -e "${redcolor}ERROR : FAILED to find DestFolder at \"${DestFolder}\" ${nocolor}" 
        doexit_statusfail
fi

if [ ! -f ${DestFolder}/.git/config ]
then
        echo -e "${redcolor}ERROR : FAILED Destination Folder at \"${DestFolder}\" is not a valid GIT project Repo. ${nocolor}" 
        doexit_statusfail
fi

if [ ! -d ${LogFolderName} ]
then
        echo -e "${redcolor}ERROR : FAILED to find LogFolderName at \"${LogFolderName}\" ${nocolor}" 
        doexit_statusfail
fi

echo -e "\n---------------- START Showing the current GIT Repo info for this project destination repo ----------------------- ${cyancolor}"
cat ${DestFolder}/.git/config
echo -e "${nocolor}\n---------------- END of current GIT Repo info for this project destination repo ----------------------- \n\n"
if ! grep refs/heads/${Branch}$ ${DestFolder}/.git/config -q
then
     echo -e "${redcolor}ERROR : FAILED Destination Git Branch \"${Branch}\" is not a valid GIT branch for this project Repo. ${nocolor}" 
     doexit_statusfail 
fi

echo -e "${yellowcolor} Doing a GIT Pull before update on local repo \"${DestFolder}\" on \"${Branch}\" branch ${nocolor}"
cd ${DestFolder}; git checkout ${Branch};git pull
echo -e "Completed local updates from Remote GIT Repo"

echo -e "\n\n ------ Copying SourceFolder \"${SourceFolder}\" to a Destination Folder folder at \"${DestFolder}\" ------ ${cyancolor} \n"
cp -avr ${SourceFolder}/* ${DestFolder}
echo -e "\n\n ${nocolor}------Completed file copy of all files from \"${SourceFolder}\" to \"${DestFolder}\" ------\n" 
git status


if git status | grep -q "^nothing to commit, working directory clean$"; then
     echo -e "${purplecolor} No updates found on Source folder \"${SourceFolder}\" or DestinationFolder folder \"${DestFolder}\"  . Exiting ${nocolor}" 
     doexit_statusgood
fi

echo "Doing a Git Add ."
git add .
echo -e "--------Showing file status before commit (git status): ---------------------\n ${greencolor}"
git status
echo -e "\n------------------------------------------------------------------\n\n ${nocolor}"
echo -e "Commiting all files and pushing to Git Origin/Remote Repo.."
git commit -m "Commitiong all files after updating local repo folder \"${DestFolder}\" from \"${SourceFolder}\" to branch \"${Branch}\"."
git push
echo -e "\nCompleted commiting pushing all changes to Git Repo \n"
echo -e "\n ------------Showing local and Remote status (git remote show origin) ------------- \n"
git remote show origin
echo -e "\n\n ------------Showing last commit log (git --no-pager log -1) ------------- \n\n"
git --no-pager log -1
echo -e "\n\n Showig status after push (git status) : "
git status
echo -e "Exiting.. \n\n"
doexit_statusgood

