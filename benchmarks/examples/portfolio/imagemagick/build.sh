#!/usr/bin/env bash

# Make sure we exit if there is a failure
set -e

function usage() {
    echo "Usage: $0 [--disable-inlining] [--ipdse] [--ai-dce] [--use-pointer-analysis] [--inter-spec VAL] [--intra-spec VAL] [--help]"
    echo "       VAL=none|aggressive|nonrec-aggressive|onlyonce"
}

#default values
INTER_SPEC="onlyonce"
INTRA_SPEC="onlyonce"
OPT_OPTIONS=""

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"
case $key in
    -inter-spec|--inter-spec)
	INTER_SPEC="$2"
	shift # past argument
	shift # past value
	;;
    -intra-spec|--intra-spec)
	INTRA_SPEC="$2"
	shift # past argument
	shift # past value
	;;
    -disable-inlining|--disable-inlining)
	OPT_OPTIONS="${OPT_OPTIONS} --disable-inlining"
	shift # past argument
	;;
    -ipdse|--ipdse)
	OPT_OPTIONS="${OPT_OPTIONS} --ipdse"
	shift # past argument
	;;
    -ai-dce|--ai-dce)
	OPT_OPTIONS="${OPT_OPTIONS} --ai-dce"
	shift # past argument
	;;                    
    -use-pointer-analysis|--use-pointer-analysis)
	OPT_OPTIONS="${OPT_OPTIONS} --use-pointer-analysis"	
	shift # past argument
	;;        
    -help|--help)
	usage
	exit 0
	;;
    *)    # unknown option
	POSITIONAL+=("$1") # save it in an array for later
	shift # past argument
	;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters

#check that the require dependencies are built
declare -a bitcode=("libMagickCore.bc" "libMagickWand.bc" "magick.bc")

for bc in "${bitcode[@]}"
do
    if [ -a  "$bc" ]
    then
        echo "Found $bc"
    else
        echo "Error: $bc not found. Try \"make\"."
        exit 1
    fi
done

MANIFEST=imagemagick.manifest
cat > ${MANIFEST} <<EOF
{ "main" : "magick.bc"
, "binary"  : "magick"
, "modules"    : ["./libMagickCore.bc", "./libMagickWand.bc"]
, "native_libs" : ["./crt1.o", "./libc.a" ]
, "ldflags" : [ "-O2", "-static", "-nostdlib"]

, "name"    : "magick"
, "static_args" : ["convert"]
, "dynamic_args" : "4"
}
EOF


export OCCAM_LOGLEVEL=INFO
export OCCAM_LOGFILE=${PWD}/slash/occam.log

rm -rf slash

SLASH_OPTS="--inter-spec-policy=${INTER_SPEC} --intra-spec-policy=${INTRA_SPEC}  --no-strip --stats $OPT_OPTIONS"
echo "======================================================================="
echo "Running magick with libMagickCore, libMagickWand, and libc libraries   "
echo "slash options ${SLASH_OPTS}"
echo "======================================================================="
slash ${SLASH_OPTS} --work-dir=slash ${MANIFEST}
status=$?
if [ $status -eq 0 ]
then
    ## runbench needs _orig and _slashed versions
    cp ${SLASH_DIR}/magick ${WORKDIR}/magick_slashed_libc
    cp ./${PREFIX}/bin/magick ${WORKDIR}/magick_orig
else
    echo "Something failed while running slash"
fi    
