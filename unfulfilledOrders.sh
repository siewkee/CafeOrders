
# file tested at Ubuntu 18.04 server environment

#filename and order via cmd line
#filename=$1
filename="orderList.txt"
order="MILLE CREPE"
date="2019-01-18"

#read file
#store info in array
while IFS= read -r line
do
    #store all items into array
    order_list=("${order_list[@]}" "$line")
done < "$filename"

#iterate array
for ((i=0; i<${#order_list[@]}; i++))
do
    var="${order_list[$i]}"
    #identify orders that matches request
    if [[ "$var" == *$order* ]] && [[ "$var" == *"FALSE"* ]] && [[ "$var" == *$date* ]]
    then
        #extract timestamp and store in time array
        set -- $var
        time_list=("$2" "${time_list[@]}")
    fi
done

#sort time array
IFS=$'\n' time_list_sorted=($(sort <<<"${time_list[*]}"))
unset IFS

#if more than 3 timestamp, pick most recent 3
if [ "${#time_list_sorted[@]}" -gt '3' ]
then
    ((start_index=${#time_list_sorted[@]}-3))
    for i in {0..2}
    do
        ((index=$start_index+$i))
        print="$date ${time_list_sorted[$index]} order=\"$order\" fufilled=FALSE"
        echo $print
    done
else
    for var in "${time_list_sorted[@]}"
    do
        print="$date $var order=\"$order\" fufilled=FALSE"
        echo $print
    done
fi


