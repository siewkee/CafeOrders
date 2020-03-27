
# file tested at Ubuntu 18.04 server environment

#filename and order via cmd line
filename=$1
order=$2

#convert order to uppercase
order_upper=$(echo $order | tr '[:lower:]' '[:upper:]')

#case for menu items and ingredients
#check for valid orders
valid_order=true
case $order_upper in
"APPLE PIE")
    ingredients=("APPLE" "APPLE" "APPLE")
    ;;
"PINEAPPLE PIE")
    ingredients=("PINEAPPLE" "PINEAPPLE" "PINEAPPLE")
    ;;
"FRUIT PARFAIT")
    ingredients=("APPLE" "APPLE" "PINEAPPLE" "PINEAPPLE")
    ;;
*)
    # invalid menu order
    valid_order=false
    echo "We do not have that on the menu"
esac

# if valid menu order
if [ "$valid_order" == true ]
then
  #read file to check if ingredients are sufficient 
  index=0
  while IFS=',' read -r line
  do
      #convert read in lines into upper case
      line_upper=$(echo $line | tr '[:lower:]' '[:upper:]') 
      #store all items into array
      items[index]=$line_upper
      ((index=index+1))
  done < "$filename"

  #sort items array
  IFS=$'\n' items_sorted=($(sort <<<"${items[*]}"))
  unset IFS

  #check if items are sufficient to make order
    #mark last item of ingredients array
  ((last_index_ingre=${#ingredients[@]} - 1))

    #loop to check if all ingredients are listed in items array
  index_ingre=0
  for var in ${items_sorted[@]}
  do
    if [ "${ingredients[index_ingre]}" == "$var" ] && [ "$index_ingre" -le "$last_index_ingre" ]
      then
          ((index_ingre=index_ingre+1))
    fi
  done

    #if not all ingredients are available on item list
  if [ "$index_ingre" -eq "${#ingredients[@]}" ]
  then
    echo "You shall have $order!"
  else
    echo "You shall not have $order"
  fi

fi




  








