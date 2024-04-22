#!/usr/bin/env bash

# Ewan Green 4.21.24
# Tool for cloning portions of a git repository 

argv=($@)
show_help() {
	[ ! -z "$1" ] && echo error: $1
	echo "usage: $(basename $BASH_SOURCE) [-h | --help] <repository> [<remote paths...>] [-o | --output <output path>]"
	echo ""
	echo "You can use the environment variable \$GIT to specify an alternative Git location."
	exit
}

declare -a git_arguments

parse_args() {
	local arg
	[ $# -lt 2 ] && show_help
	while :; do
		[ "$#" -gt 0 ] || break

		arg="$1"
		

		if [[ "$arg" == +('--help'|'-h') ]]; then
			show_help
		elif [[ "$arg" =~ '--output'|'-o' ]]; then
			if [[ "$arg" == *'='* ]]; then
				output_directory="${1#*=}"
			elif [ ! -z $2 ]; then
				output_directory="$2"
				shift
			else
				show_help "--output requires a parameter"
			fi
			shift
		else
			git_arguments+=("$1")
			shift
		fi
	done
}

parse_args ${argv[*]}

if [ -z "$output_directory" ]; then
	output_directory="$PWD/$(basename ${git_arguments[0]})"
fi

if [ -z "$GIT" ]; then
	if command -v git &> /dev/null; then
		git="$(command -v git)"
	else
		echo "git was not found"
		exit
	fi
fi

expected_git_version="2.27.0"

if [ "$(printf "$(git -v | awk 'NF>1{print $NF}' -)\n${expected_git_version}" | sort -V | head -1)" != "${expected_git_version}" ]; then
	echo "Git version doesn't support sparse-checkout"
	exit
fi

repository="${git_arguments[0]}"
paths=(${git_arguments[@]:1})

if [ -e $output_directory ]; then
	echo "Output directory already exists"
	exit
fi

git clone -n --depth=1 --filter=tree:0 $repository $output_directory
cd $output_directory
git sparse-checkout set --no-cone ${paths[@]} > /dev/null
git checkout