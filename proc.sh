
transformdb2() {
    db2 connect to $DATABASE user $USER using $PASSWORD
    local fname="$1"
    local awkscript="$2"    
    if [ -z "$ICONV" ]; then 
       dos2unix <"$fname" | awk -f $awkscript  -v INCLUDEONLY="$INCLUDEONLY" | db2 -tv; 
    else 
       iconv -f $ICONV "$fname" | dos2unix | awk -f $awkscript -v INCLUDEONLY="$INCLUDEONLY" | db2 -tv;
    fi
    db2 terminate
}

testtransform() {
    local fname="$1"
    local awkscript="$2"    
    if [ -z "$ICONV" ]; then 
       dos2unix <"$fname" | awk -f $awkscript  -v INCLUDEONLY="$INCLUDEONLY"; 
    else 
       iconv -f $ICONV "$fname" | dos2unix | awk -f $awkscript  -v INCLUDEONLY="$INCLUDEONLY";
    fi
}
