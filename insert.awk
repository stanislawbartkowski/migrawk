@include "fun.awk"

function changeline(l) {
    return gensub(/INSERT/,"INSERT INTO","g",l);
}

/INSERT/ {
    line = changeline(clearline($0));
    outline(line " ;");
}
