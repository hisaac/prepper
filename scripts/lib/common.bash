#!/usr/bin/env bash

set -o errexit
set -o nounset
set -o pipefail

if [[ "${TRACE:-}" == true || "${DEBUG:-}" == true ]]; then
	set -o xtrace # Trace the execution of the script (debug)
fi

function init() {
	if [[ -n "${__COMMON_BASH_LOADED:-}" ]]; then
		return 0
	fi
	__COMMON_BASH_LOADED=1

	local -r project_root="$(dirname -- "$(dirname -- "$(dirname -- "$(realpath -- "${BASH_SOURCE[0]}")")")")"
	export PROJECT_ROOT="${PROJECT_ROOT:-$project_root}"
}

# Logging

# Resolves to the calling script's name
declare -r script_name="${0##*/}"

function log_info() {
	local -r message="${1:-}"
	echo -e "[${script_name}] ${message}"
}

function log_warning() {
	local -r message="${1:-}"
	echo -e "[${script_name}] WARNING: ${message}"
}

function log_error() {
	local -r message="${1:-}"
	echo -e "[${script_name}] ERROR: ${message}" >&2
}

function handle_error() {
	local -ri exit_code=$?
	local -r line_number="$1"

	# Disable errexit so we don't fail inside the handler
	set +o errexit

	log_error "Command failed (exit $exit_code) at line $line_number: $BASH_COMMAND"
	exit "${exit_code}"
}
trap 'handle_error ${LINENO}' ERR

init "$@"
