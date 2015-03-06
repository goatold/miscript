#!/bin/awk

BEGIN {
    cnt = 0;
    ld["timestamp"] = "";
    ld["idle"] = "";
    plst["VDTC"] = "vdtc";
    plst["VOSIAL"] = "ocpr";
    plst["M3UA"] = "m3ua";
    for (preg in plst) {
        ld[plst[preg]] = "";
    }
}

/^top/ {
    if (cnt > 0) {
        printf "timestamp: %s\t", ld["timestamp"];
        for (preg in plst) { printf "%s: %s%\t", plst[preg], ld[plst[preg]]; }
        printf "idle: %s\n", ld["idle"];
    }
    cnt ++;
    ld["timestamp"] = $3;
    ld["idle"] = "";
    for (preg in plst) {
        ld[plst[preg]] = "";
    }
    next;
}
/^Cpu/ {ld["idle"] = $8;next;} 
/.+/ {
    for (preg in plst) {
        if($0 ~ preg) {ld[plst[preg]] = $9;next;}
    }
}

END {
    if (cnt > 0) {
        printf "timestamp: %s\t", ld["timestamp"];
        for (preg in plst) { printf "%s: %s%\t", plst[preg], ld[plst[preg]]; }
        printf "idle: %s\n", ld["idle"];
    }
    printf "total %d records\n", cnt;
}

