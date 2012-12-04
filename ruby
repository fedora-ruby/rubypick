#!/usr/bin/bash
MRI=/usr/bin/ruby-mri
JRUBY=/usr/bin/jruby

if [ -e $MRI ]; then
  INTERPRETER=$MRI
elif [ -e $JRUBY ]; then
  INTERPRETER=$JRUBY
else
  echo "No Ruby interpreter is installed, use 'yum install jruby' or 'yum install ruby'." >&2
  exit 123
fi

FIRST_PARAM=""

if [ "$1" == "_mri_" ]; then
  INTERPRETER=$MRI
  shift 1
elif [ "$2" == "_mri_" ]; then
  FIRST_PARAM=$1
  INTERPRETER=$MRI
  shift 2
elif [ "$1" == "_jruby_" ]; then
  INTERPRETER=$JRUBY
  shift 1
elif [ "$2" == "_jruby_" ]; then
  FIRST_PARAM=$1
  INTERPRETER=$JRUBY
  shift 2
fi

if [ ! -e $INTERPRETER ]; then
  echo "Couldn't find $INTERPRETER, use 'yum install $INTERPRETER' to install it." >&2
  exit 124
fi

$INTERPRETER $FIRST_PARAM "$@"
