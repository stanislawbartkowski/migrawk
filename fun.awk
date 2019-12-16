function P(l) { print(l) }

function PC() { print($0) }

function outline(l) {
    print(l);
}

function outputline() { 
    if (printline) print(line);
    printline = 0;
}

function clearline(l) {
    line = gensub(/\[dbo\]\./,"","g",l);
    line = gensub(/\[|\]/,"","g",line);  
    return line; 
}
