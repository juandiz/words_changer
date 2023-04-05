# !/bin/bash

TEMP_PATH="./temp"
CHANGES_FILE="./changes.csv"

if [ -d $1 ]
then
    echo "Checking all files in $1"
else
    echo "The dir $1 does not exist. EXIT"
    exit
fi

if [ -f $CHANGES_FILE ]
then 
    echo "The changes file will be used $CHANGES_FILE"
else
    echo "The changes file does not exist. It must be loaded"
    echo 'This file;To this;' > $CHANGES_FILE
    exit
fi

if [ -d $TEMP_PATH ]
then 
    echo "Temp file exists"
    rm -r $TEMP_PATH
    mkdir $TEMP_PATH
else
    mkdir $TEMP_PATH
fi

#analyse the change file
OIFS=$IFS
IFS=$'\n@'    #fix separator

declare -a linesInCHange  # array for dir names
declare -a lineArray  # array for dir names

linesInCHange=( $( cat "$CHANGES_FILE" ) )  # load into array 
arr=()
i=0

for M in ${linesInCHange[@]} ; do
    echo "$M"
    arr[$i]=$M
    i=$((i+1))
done

IFS=$OIFS

echo "Lines found in change.csv i = $i"

#construct AWK command
awk_command='{'
for (( c=0; c<i/2; c++ )); do
    # echo ${arr[$c]}
    init_word_pos=$((c*2))
    new_word_pos=$((c*2+1))
    awk_command=$awk_command'gsub('${arr[$init_word_pos]}','${arr[$new_word_pos]}');'
done
awk_command=$awk_command'print $0}'
echo $awk_command

# copy all in temp folder, change c with * for all extensions
cp $1/*.c $TEMP_PATH

# check all files in path
for f in $TEMP_PATH/*; do
    # echo $f
    name="$(basename -- $f)"
    echo $name
    awk "$awk_command" $f > $1/$name # first argument is input and second argument is the output file
done

# finish and remove temp folder
echo "File are updated in $1"
rm -r $TEMP_PATH