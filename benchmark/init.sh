#! /usr/bin/env bash

ACTION="${1}"
shift

BIN_MBW="/bench/mbw/mbw"
BIN_SYSBENCH="/bench/sysbench/src/sysbench"

NUMPROC="$(/usr/bin/nproc)"

function die_usage() {
	echo "usage: ${0} <action> [additional parameters]" >&2
	echo ""
	echo "Actions: "
	echo " mbw                 - Run MBW Memory Bandwidth Benchmark"
	echo " sysbench            - Run Sysbench Benchmarking"
	echo " mbw-complete        - Run mem-test script (handles params and cpu core for you)"
	echo " mbw-loop <count>    - Run mem-test script in a loop <count> times"
	exit 99
}

export PATH="/bench/mbw:/bench/sysbench/src:${PATH}"

case "${ACTION}" in
	mbw)
		echo "Run MBW Benchmark"
		${BIN_MBW} "${@}"
		;;
	sysbench)
		echo "Run Sysbench"
		${BIN_SYSBENCH} "${@}"
		;;
	mbw-complete)
		/bench/bin/mem-test.sh "${@}"
		;;
	mbw-loop
		COUNT="${1}"
		shift
		for I in {1..${COUNT}}; do
			/bench/bin/mem-test.sh
		done
	*)
		die_usage
		;;
esac
