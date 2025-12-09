#!/bin/bash
pushd .

BENCH="case-anon-cow-seq"

AE=~/ae
cd $AE/benchmarks

sed -i '11s|.*|ANON="'$BENCH'"|' ./run-vm-scalability.sh

sudo ./run-vm-scalability.sh

sed -i '2s|.*|CASES="'$BENCH'"|' ./eval-vm-scalability.sh

sudo ./eval-vm-scalability.sh

popd