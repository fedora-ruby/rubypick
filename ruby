#!/usr/bin/bash
MRI=/usr/bin/ruby-mri
JRUBY=/usr/bin/jruby
INTERPRETER=""

if [ -e $MRI ]; then
  INTERPRETER=$MRI
elif [ -e $JRUBY ]; then
  INTERPRETER=$JRUBY
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

if [ "$1" == "-h" -o "$1" == "--help" ]; then
  MRI_STRING="Ruby - binary $MRI -"
  if [ -e $MRI ]; then
    MRI_STRING="$MRI_STRING Installed"
  else
    MRI_STRING="$MRI_STRING Not Installed (install with 'yum install ruby')"
  fi

  JRUBY_STRING="JRuby - binary $JRUBY - "
  if [ -e $JRUBY ]; then
    JRUBY_STRING="$JRUBY_STRING Installed"
  else
    JRUBY_STRING="$JRUBY_STRING Not Installed (install with 'yum install jruby')"
  fi
  echo "This is Fedora's rubypick - a Ruby runtime chooser. You can use it
to execute Ruby programmes with any Fedora Ruby runtime.
These currently include:

$MRI_STRING
$JRUBY_STRING

To run a specific runtime, use:
ruby _mri_ [params]
ruby _jruby_ [params]
The default is _mri_.

To run Ruby executables with shebang, such as 'gem', you can also use these:
gem _mri_ install foo
gem _jruby_ install foo

If you don't want to use rubypick, you can always fall back to
using the above binaries.

Printing help for $INTERPRETER:
"
fi

if [ -z "$INTERPRETER" ]; then
  echo "No Ruby interpreter is installed, use 'yum install jruby' or 'yum install ruby'." >&2
  exit 123
elif [ ! -e "$INTERPRETER" ]; then
  echo "Couldn't find $INTERPRETER, use 'yum install $INTERPRETER' to install it." >&2
  exit 124
fi

$INTERPRETER $FIRST_PARAM "$@"
