. ./source.rc
. ./proc.sh

IFS=","
for file in $LIST ; do
  echo $file
  iconvtransformdb2 "$DIRFILE$file" insert.awk
done   
