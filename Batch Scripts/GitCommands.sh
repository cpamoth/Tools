#!/bin/bash
#  Written by Jimmy George on March-17- 2014. This script resides in your GIT's home directory and enables you to run GIT commands from a menu.
#  put the .bashrc in your Git Home folder so that you can call this script from any path location.

show_menu(){
    NORMAL=`echo "\033[m"`
    MENU=`echo "\033[36m"` #Blue
    NUMBER=`echo "\033[33m"` #yellow
    FGRED=`echo "\033[41m"`
    RED_TEXT=`echo "\033[31m"`
    ENTER_LINE=`echo "\033[33m"`
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${MENU}**${NUMBER} 1)${MENU} Git show Status ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 2)${MENU} Git show Log  ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 3)${MENU} Git show Branches ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 4)${MENU} Git Merge and Commit local branch changes to Remote/Origin branch ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 5)${MENU} Git Revert local Merge commit ${NORMAL}"
    echo -e "${MENU}**${NUMBER} 6)${MENU} Git Revert all local file changes and update to latest head remote head revision ${NORMAL}"
    echo -e "${MENU}*********************************************${NORMAL}"
    echo -e "${ENTER_LINE}Please enter a menu option and enter or ${RED_TEXT}enter to exit. ${NORMAL}"
    echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo
    read opt
}
function option_picked() {
    COLOR='\033[01;31m' # bold red
    RESET='\033[00;00m' # normal white
    MESSAGE=${@:-"${RESET}Error: No message passed"}
    echo -e "${COLOR}${MESSAGE}${RESET}"
}

clear
show_menu
while [ opt != '' ]
    do
    if [[ $opt = "" ]]; then 
            exit;
    else
        case $opt in
        1) clear;
        option_picked "Option 1 Picked : Showing current status in this branch";    
        echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo    
        git diff --shortstat; git status -sb; # Show Git Status for the current branch
        echo;echo "------------------------------------------------------------------------"; echo
        echo "Showing all staged files : ";echo; git diff --cached ;echo;echo 
        echo "******************** End Git Status  ***********************************"; echo
        show_menu;
        ;;

        2) clear;
            option_picked "Option 2 Picked : Showing Log for this branch "
            echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo
            echo "Showing detailed graph log [Press space to move to next page or q to quit log view] : "
            git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --all; # showing detailed graph log
            echo;echo; echo "Showing summary log for last 10 commits : "
            git log --pretty=format:"%C(yellow)%h%x09%Creset%an%x09%x09%s %C(green) %ad" --decorate -10
            echo;echo echo "Showing commits to each branchs : "
            git branch -v
            echo "******************** End Git Log  ***********************************"; echo
            show_menu;
            ;;

        3) clear;
            option_picked "Option 3 Picked : Show Branches "
            echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo
            echo;echo "Showing all local branches";echo; git branch -lvv; echo;echo
            echo;echo "Showing all remote branches";echo; git branch -rvv; echo;echo            
            show_menu;
            ;;

        4) clear;
             option_picked "Option 4 Picked : Going to merge current branch to remote branch.."    
             echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo  
             echo;echo "Showing all local branches";echo; git branch -lvv; echo;echo
             echo;echo "Showing all remote branches";echo; git branch -rvv; echo;echo         
             read -p "Please Enter your enter your local branch name from the above listing (Is case sensitive) : " localbranch;
             read -p "Please Enter the remote branch name from the above listing (Is case sensitive. Do NOT enter the \"origin path\") : " remotebranch;
             if git branch -lvv|grep $localbranch -q && git branch -rvv|grep $remotebranch -q
             	then
                     echo;echo -e "${NUMBER}Going to Merge updates from your local branch \"$localbranch\" to the remote branch \"$remotebranch\" branch.. ${NORMAL}"                     
                     git checkout $localbranch; 
                     echo;echo "Your current local branch details : ";
                     echo "Your current local path `pwd` and Your current local branch `git rev-parse --abbrev-ref HEAD`"
                     git status;git branch -avv;echo
                     git add . 
                     echo "Showing all staged files : ";echo; git diff --cached ;echo;echo ;git diff --shortstat; git status -sb;echo
                     read -p "Done \"git add .\" on your local branch \"$localbranch\". Please Enter a Commit message for commit : " commitmsg; 
                     echo
                     git commit -m "$commitmsg"
                     echo "Pulling the lastest changes to the remote branch \"$remotebranch\".."
                     git checkout $remotebranch; git pull; 
                     echo "Going to merge remote branch \"$remotebranch\" to local branch \"$localbranch\"".
                     git checkout $localbranch; git merge $remotebranch
                     echo "Going to merge local branch  \"$localbranch\" to remote branch \"$remotebranch\"".
                     git checkout $remotebranch; 
                     echo;echo -e "${FGRED}Your current remote branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}"
                     git merge $localbranch
                     git diff --shortstat; git status -sb
                     read -p "Does the Merge look good ?. Are you sure you want to push the merge to remote branch ? <y/N> " prompt
                     if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
                     then
                          echo;echo
	                      git push
	                      echo "Push completed to remote.";echo
                    else
                 	       echo;echo -e "${RED_TEXT}Cancelling Merge process..${NORMAL}";echo
                     fi    
                     git checkout $localbranch; ## return to local branch
             else              	
             	echo;echo -e "${RED_TEXT}Invalid branch entered. Cancelling the merge. ${NORMAL}";echo
             fi
            show_menu;
            ;;

         5) clear;
            option_picked "Option 5 Picked : Going to revert your current merge.."
            echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo  
            echo;echo
            git log --pretty=format:"%C(yellow)%h%x09%Creset%an%x09%x09%s %C(green) %ad" --decorate -10
             echo;echo
             read -p "Please Enter the merge commit hash to revert your current merge to : " revhash;
             if git rev-list --all | grep $revhash -q
             	then
                    echo "Going to execute \"git revert -m 1 $revhash\"" 
                     read -p "Are you sure you want to continue? <y/N> " prompt
                     if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
                     then
	                      git revert -m 1 $revhash
	                      echo "Done."
                    else
                 	  echo "Cancelling Merge Revert process.."
             fi            
           else           
               echo "Sorry Invalid commit number entered. Cancelling merge revert. "
           fi
            echo;echo
            show_menu;
            ;;

        6) clear;
             option_picked "Option 6 Picked : Going to Revert local changes..";
             echo;echo -e "${FGRED}Your current path `pwd` and Your current branch `git rev-parse --abbrev-ref HEAD` ${NORMAL}";echo  
             echo "Going to execute run \"git clean -f -d; git checkout -- *;git reset --hard\" to unstage every file you have just added locally in the current branch..";
             read -p "Are you sure you want to continue? <y/N> " prompt
             if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]
             then                                     
                      echo "Running git clean -f -d"; git clean -f -d
                      echo "Running git checkout -- *"; git checkout -- * 
                      echo "Running git reset --hard"; git reset --hard
                      echo "Done. Reverted all local file changes."
           else
               echo "Cancelling local revert commands.."
           fi
            echo;echo
            show_menu;
            ;;

        x)exit;
        ;;

        \n)exit;
        ;;

        *)clear;
        option_picked "Pick an option from the menu";
        show_menu;
        ;;
    esac
fi
done
