#########################################################################
# File Name: fruit.sh
# Author: way
# mail: ww875749864@outlook.com
# Created Time: 2019年07月16日 星期二 09时09分04秒
# Description:  
#########################################################################
#!/bin/bash
RED_COLOR='\E[5;31m'
GREEN_COLOR='\E[5;32m'
YELLOW_COLOR='\E[5;33m'
BULE_COLOR='\E[5;34m'
RES='\E[0m'

function usage(){
        echo "USAGE: $0 {1|2|3|4}"
        exit 1
}
function menu(){
cat <<END
        1.apple
        2.pear
        3.banana
END
}
function choose(){
read -p "please select your favorite fruit" fruit
case "$fruit" in
        1)
                 echo -e "${RED_COLOR}apple${RES}"
                 ;;
         2)  
                 echo -e "${GREEN_COLOR}pear${RES}"
                 ;;
         3)
                 echo -e "${YELLOW_COLOR}banana${RES}"
                 ;;
        *)
                 echo you dont like all fruit above
esac
}
function main(){
        menu
        choose
}
main
