# This is where TJ keeps all of his bash functions written.

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~ From myself ~~~~~


# ~~~~~ From Others ~~~~~

# Define a word - USAGE: define dog
#   This one is current broken, but I'd like to fix it.
define ()
{
lynx -dump "http://www.google.com/search?hl=en&q=define%3A+${1}&btnG=Google+Search" | grep -m 3 -w "*"  | sed 's/;/ -/g' | cut -d- -f1 > /tmp/templookup.txt
			if [[ -s  /tmp/templookup.txt ]] ;then	
				until ! read response
					do
					echo "${response}"
					done < /tmp/templookup.txt
				else
					echo "Sorry $USER, I can't find the term \"${1} \""				
			fi	

}


# clock - A bash clock that can run in your terminal window. 
# Very pretty, should look at this more
clock () 
{ 
while true;do clear;echo "===========";date +"%r";echo "===========";sleep 1;done 
}


# netinfo - shows network information for your system
netinfo ()
{
    echo "--------------- Network Information ---------------"
    /sbin/ifconfig | awk /'inet addr/ {print $2}'
    /sbin/ifconfig | awk /'Bcast/ {print $3}'
    /sbin/ifconfig | awk /'inet addr/ {print $4}'
    /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    myip=`lynx -dump -hiddenlinks=ignore -nolist http://checkip.dyndns.org:8245/ | sed '/^$/d; s/^[ ]*//g; s/[ ]*$//g' `
    echo "${myip}"
    echo "---------------------------------------------------"
}

function wrap_make() 
{
    clear;
    /usr/bin/make "$@"
    if [[ $? -eq 0 ]] ; then
        echo -e $green"make: Success!"$NC
        return 0
    else
        echo -e $red"make: Something isn't very happy"$NC
        return 1
    fi
}

function wrap_dts()
{
    file=${1%.dtb}

    if [[ -e ${file}.dtb ]] ; then
        if [[ -e ${file}.dtb.old ]] ; then
            read -p "Replace backup "${file}".dtb.old? [Y/n] "
            if [[ $REPLY =~ ^Y$|^y$|^$ ]] ; then #string starts with a Y, or doesn't have anything
                rm ${file}.dtb.old
                cp ${file}.dtb ${file}.dtb.old
            fi
        else
            cp ${file}.dtb ${file}.dtb.old
        fi

        dtc -I dtb -O dts -o ${file}.dts ${file}.dtb && \
        rm ${file}.dtb && \
        echo -e ${green}Converted Device Tree Binary to Source || \
        echo -e ${red}Conversion Failed
    else 
        echo -e ${red}Error Converting: ${file}.dtb does not exist!
    fi
}

function wrap_dtb()
{
    file=${1%.dts}

    if [[ -e ${file}.dts ]] ; then
        if [[ -e ${file}.dts.old ]] ; then
            read -p "Replace backup "${file}".dts.old? [Y/n] "
            if [[ $REPLY =~ ^Y$|^y$|^$ ]] ; then #string starts with a Y, or doesn't have anything
                rm ${file}.dts.old
                cp ${file}.dts ${file}.dts.old
            fi
        else
            cp ${file}.dts ${file}.dts.old
        fi

        dtc -I dts -O dtb -o ${file}.dtb ${file}.dts && \
        rm ${file}.dts && \
        echo -e ${green}Converted Device Tree Binary to Source || \
        echo -e ${red}Conversion Failed
    else 
        echo -e ${red}Error Converting: ${file}.dts does not exist!
    fi
}

function wrap_copy()
{
    if [[ ! -e $1 ]] ; then
        echo -e ${red}"file '"$1"' does not exist."${nc}
        return 1
    fi
    cat $1 | xclip -i -selection clipboard
}

# Usage: br N
# Output: the combined diff of the last N commits
function wrap_bt()
{
    git diff HEAD`for ((i=0; i<$1; ++i)); do echo -n ^; done;` HEAD
}

# Usage: df N
# Output: the diff from N commits ago
function wrap_df()
{
    git diff HEAD`for ((i=0; i<$1; ++i)); do echo -n ^; done;` HEAD`for ((i=0; i<$(($1-1)); ++i)); do echo -n ^; done;`
}

# Extract stuff
extract () {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}
