#!/bin/sh

# Colores
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

# Contadores
tests_passed=0
total_tests=0

run_test() {
    input="$1"
    expected="$2"
    description="$3"

    total_tests=`expr $total_tests + 1`
    result=`sh myawesomescript.sh "$input"`

    if [ "$result" = "$expected" ]; then
        echo "${GREEN}✓ Test $total_tests passed:${NC} $description"
        tests_passed=`expr $tests_passed + 1`
    else
        echo "${RED}✗ Test $total_tests failed:${NC} $description"
        echo "Expected: $expected"
        echo "Got: $result"
    fi
}

# Casos de prueba
run_test "bit.ly/1O72s3U" "http://42.fr/" "Basic test in the PDF"
run_test "bit.ly/4hCUTBq" "https://www.google.com/" "Google redirect test"
run_test "bit.ly/42WSWLB" "https://www.youtube.com/" "YouTube redirect test"
run_test "bit.ly/3CLKft8" "https://www.wikipedia.org/" "www.wikipedia redirect test"
run_test "invalidurl" "" "Invalid URL test"

echo "------------------------"
echo "Tests completed: $tests_passed/$total_tests passed"

if [ "$tests_passed" -eq "$total_tests" ]; then
    exit 0
else
    exit 1
fi