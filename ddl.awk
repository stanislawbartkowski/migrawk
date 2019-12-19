@include "fun.awk"

BEGIN {
    insidecreate = 0;
    printline = 0;
    MAX = 8148;
    CREATECLAUSE = " ORGANIZE BY COLUMN ";
}

function closeonly(l) {
  if ((l ~ /\)/) && !(l ~ /\(/)) return 1;
  return 0;
}

function gettablename(l) {
  taname = clearline(l);
  return gensub(/\(/,"","g",taname);
}

function includetable(t) {
   if (length(INCLUDEONLY) == 0) return 1;
   return (INCLUDEONLY ~ toupper(t)"\~");
}

function createdrop(taname) {
#    return gensub(/\(/," IF EXISTS;","g","DROP TABLE " clearline(l));
   return "DROP TABLE "taname" IF EXISTS;";
}

function replacemax(l) {
    return gensub(/\(max\)/,"("MAX")","g",l);
}

/[Cc][Rr][Ee][Aa][Tt][Ee]\ +[Tt][Aa][Bb][Ll][Ee]/ {
    tablename = gettablename($3);
    if (includetable(tablename)) {
      outline(createdrop(tablename));
      insidecreate = 1;
    }
}    

{
  if (insidecreate) {
    line = clearline($0);
    line = replacemax(line);
    printline = 1;
    if (closeonly(line)) {
        insidecreate = 0;
        outline(")"CREATECLAUSE";");
        line = "";
    }
  }
  outputline();
}
