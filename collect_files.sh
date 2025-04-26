#!/bin/bash

if [[ $1 == "--max_depth" ]]; then
  max_depth="$2"        
  input_dir="$3"        
  output_dir="$4"        
  val=( -maxdepth "$max_depth" )
else 
  input_dir="$1"         
  output_dir="$2"        
  val=() 
fi


mkdir -p "$output_dir"
declare -A arr

find "$input_dir" "${val[@]}" -type f | while IFS= read -r file; do

  base=$(basename "$file")       
  if [[ -v arr[$base] ]]; then   
    arr[$base]=$(( arr[$base] + 1 ))
    ext=${base##*.}               
    name=${base%.*}              
    base="${name}_${arr[$base]}.$ext"  
  else
    arr[$base]=0                
  fi

  cp "$file" "$output_dir/$base"
  
done

