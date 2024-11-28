#!/bin/bash

x="foo"
printf "%-12s *" $x

echo " "

y=$(printf "%-12s" $x)
echo "$y" "*"

main() {
z=$(printf "[%-12s] * %s" "$x" "$x")
echo "$z"
}
main
