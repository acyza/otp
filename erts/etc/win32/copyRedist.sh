DIR=''
IFS=:
for p in $PATH; do
if [ -f $p/cl.exe ]; then
     DIR="$p/"
    break;
fi
done
TEMP="/Tools/MSVC/*/bin/Hostx../x../"

for (( j=${#TEMP}-1,i=${#DIR}-1;i>=0 && j>=0;i--)) do
if [ "${TEMP:j:1}" = "*" ]; then
    if [ "${DIR:i:1}" = "/" ]; then
        ((j = j - 2));
    fi
    continue;
elif [ "${TEMP:j+1:1}" = "/" ] && [ "${DIR:i:1}" = "/" ]; then
    continue;
fi
if [ "${TEMP:j:1}" = "." ] || [ "${TEMP:j:1}" = "${DIR:i:1}" ]; then
    ((j = j - 1));
    continue;
else
 echo "path error${i},${j}"
 exit 2
fi
done
DIR="${DIR:0:i+1}/Redist/MSVC/"
VERSIONDIRS=$(ls $DIR | grep "\.")
VERSIONDIR=''
IFS='
'
for ITEM in $VERSIONDIRS; do
VERSIONDIR=$ITEM
done
DIR="$DIR$VERSIONDIR/x64/"
IFS=:
VERSIONDIRS=$(ls $DIR | grep "CRT")
IFS='
'
for ITEM in $VERSIONDIRS; do
VERSIONDIR=$ITEM
done
DIR="$DIR$VERSIONDIR"
echo $DIR

cp -r $DIR/* release
cp -r $DIR release/win32/bin