#!/bin/bash

get_nested_value() {
    local obj="$1"
    local key="$2"
    IFS='/'
    local keys=($key)
    local value="$obj"
    
    for k in "${keys[@]}"; do
        if [[ -n "$value" && "$value" =~ \{.*\} ]]; then
            value="$(echo "$value" | jq -r ".$k")"
        else
            value=""
            break
        fi
    done
    
    echo "$value"
}

# Example usage
object1='{"a":{"b":{"c":"d"}}}'
key1="a/b/c"
value1=$(get_nested_value "$object1" "$key1")
echo "$value1"  # Output: d

object2='{"x":{"y":{"z":"a"}}}'
key2="x/y/z"
value2=$(get_nested_value "$object2" "$key2")
echo "$value2"  # Output: a

object1='{"a":{"b":{"c":"d"}}}'
key1="a/b/d"
value1=$(get_nested_value "$object1" "$key1")
echo "$value1" # Output: null
