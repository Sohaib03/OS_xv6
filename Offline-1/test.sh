hello() {
    echo "Hello World, $1"
}

a=0
b=1

if [[ "$a" == "$b" ]]; then
    echo "A and B are equal"
elif [[ "$a" > "$b" ]]; then
    echo "A is greater than B"
else 
    echo "A is smaller than B"
fi

echo "Func says : $(hello rakin)"
hello sohaib