FNF!=1 {
  for(i=1; i<NF; i++) {
    wc[$i]+=1;
  }
}

END {
  print "value,count"
  for(field in wc) {
    print field "," wc[field]
  }
}
