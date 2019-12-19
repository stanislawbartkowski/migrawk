. ./source.rc
. ./proc.sh

transformdb2 "$SCRIPTFILE" ddl.awk

#testtransform "$SCRIPTFILE" ddl.awk