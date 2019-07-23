FNR==1 {
  sum += NF
  file_count+=1;
}

END {
  print sum/file_count
}
