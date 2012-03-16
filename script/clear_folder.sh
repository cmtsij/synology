## use to clean BT download folder.
##
## Usage:
##      $0 [folder]
##

dir=${1:-"./"}

regstr=`cat << -REGEX_END | while read fname; do echo -n "\(^.*/$fname\)\|"; done
Thumbs.db
.*\.txt$
.*\.TXT$
.*\.url$
.*\.URL$
.*\.htm[l]$
.*\.HTM[L]$
.*\.mht$
.*\.MHT$
.*\.rtf$
.*\.chm$
.*mimip2p.jpg$
.*___padding.*
.*AVBDSHOP.*
.*[0-9\ ]\+元.*
.*發佈站.*
.*週年慶.*
.*C9~.*
.*city9x.com\.avi.*
.*SIS.*
.*MYAV.*
.*dfhy\.jpg.*
REGEX_END`"\(^REGEX_NONE$\)"


echo "==== Generate file list in ${dir} ===="
find $dir -type f -regex "$regstr" -print

echo "==== Press 'rm' to go ===="
read -n 2 select
echo ""

echo "=========================="
if [ "$select" == "rm" ];then
	find $dir -type f -regex "$regstr" -print0 | xargs -0 rm
else
	echo "skip..."
fi
