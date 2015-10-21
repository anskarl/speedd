#!/usr/bin/env bash

# Get the location for this script; handles symlinks
function get_script_path {
  local source="${BASH_SOURCE[0]}"
  while [ -h "$source" ] ; do
    local linked="$(readlink "$source")"
    local dir="$(cd -P $(dirname "$source") && cd -P $(dirname "$linked") && pwd)"
    source="$dir/$(basename "$linked")"
  done
  echo ${source}
}

# script details
declare -r script_path=$(get_script_path)
declare -r script_name=$(basename "$script_path")
declare -r script_dir="$(cd -P "$(dirname "$script_path")" && pwd)"

# directories
declare -r base_dir="$(cd "$script_dir/.." && pwd)"
declare -r lib_dir="$base_dir/lib"

# take the parameters
. $base_dir/bin/inc.env.sh

declare -r WLEARN_JAVA_OPTS=$VM_ARGS" -XX:+AggressiveOpts"
declare -r WLEARN_CLASSPATH=$PRJ_COMMONS_CLASSPATH

nice java $WLEARN_JAVA_OPTS -cp $WLEARN_CLASSPATH org.speedd.ml.app.WeightLearnerCLI $@
