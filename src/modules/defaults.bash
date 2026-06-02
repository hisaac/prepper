#!/usr/bin/env bash
# defaults.bash

declare defaults_bin
defaults_bin="$(which defaults)"

function defaults.read {
	local -r _domain="${1:-}"
	local -r _key="${2:-}"
	"$defaults_bin" read "$_domain" "$_key"
}

function defaults.read_type {
	local -r _domain="${1}"
	local -r _key="${2}"
	"$defaults_bin" read-type "$_domain" "$_key"
}

function defaults.write {
	local -r _domain="${1}"
	local -r _key="${2}"
	local -r _value="${3}"
	"$defaults_bin" write "$_domain" "$_key" "$_value"
}

function defaults.delete {
	local -r _domain="${1}"
	local -r _key="${2}"
	"$defaults_bin" delete "$_domain" "$_key"
}

function defaults.domains {
	"$defaults_bin" domains
}
