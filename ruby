#!/usr/bin/bash
declare -A INTERPRETER_LIST
INTERPRETER_LIST=([_jruby_]=/usr/bin/jruby [_mri_]=/usr/bin/ruby-mri)
INTERPRETER=""

# explicitly list interpreters - order matters here
for i in _mri_ _jruby_; do
  if [ -e ${INTERPRETER_LIST[$i]} ]; then
    INTERPRETER=${INTERPRETER_LIST[$i]}
    break
  fi
done

# allow choosing interpreter by RUBYPICK env variable
if [ -n "$RUBYPICK" ]; then
  if [ -n "${INTERPRETER_LIST[$RUBYPICK]}" ]; then
    INTERPRETER=${INTERPRETER_LIST[$RUBYPICK]}
  else
    echo "Wrong value of RUBYPICK env variable. Ignoring." >&2
  fi
fi

FIRST_PARAM=""

if [ -n "$1" ] && [ -n "${INTERPRETER_LIST[$1]}" ]; then
  INTERPRETER=${INTERPRETER_LIST[$1]}
  shift 1
elif [ -n "$2" ] && [ -n "${INTERPRETER_LIST[$2]}" ]; then
  FIRST_PARAM=$1
  INTERPRETER=${INTERPRETER_LIST[$2]}
  shift 2
fi

if [ "$1" == "-h" -o "$1" == "--help" ]; then
  MRI_STRING="Ruby - binary ${INTERPRETER_LIST[_mri_]} -"
  if [ -e ${INTERPRETER_LIST[_mri_]} ]; then
    MRI_STRING="$MRI_STRING Installed"
  else
    MRI_STRING="$MRI_STRING Not Installed (install with 'yum install ruby')"
  fi

  JRUBY_STRING="JRuby - binary ${INTERPRETER_LIST[_jruby_]} -"
  if [ -e ${INTERPRETER_LIST[_jruby_]} ]; then
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

Or you can set environment variable RUBYPICK like this:
RUBYPICK=_mri_
RUBYPICK=_jruby_
and then MRI, resp. JRuby will be used for all ruby invocations.
This is still overriden by using the parameter as mentioned above.

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

exec $INTERPRETER $FIRST_PARAM "$@"
