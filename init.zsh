# shellcheck shell=bash
######################################################################
#<
#
# Function: p6df::modules::teleport::deps()
#
#>
######################################################################
p6df::modules::teleport::deps() {
  ModuleDeps=(
    p6m7g8-dotfiles/p6common
  )
}

######################################################################
#<
#
# Function: p6df::modules::teleport::external::brews()
#
#>
######################################################################
p6df::modules::teleport::external::brews() {

  p6df::core::homebrew::cli::brew::install teleport

  p6_return_void
}

######################################################################
#<
#
# Function: str str = p6df::modules::teleport::prompt::mod()
#
#  Returns:
#	str - str
#
#>
#/ Synopsis
#/  tsh login --proxy=x:443 --auth=local --user=email
#/  tsh db connect --db-user=teleport --db-name=fooc foo
#/  tsh kube ls
#/  tsh nodes ls
#/  tsh ssh -f <id>
######################################################################
p6df::modules::teleport::prompt::mod() {

  local profile
  local user
  local valid

  valid=$(tsh status 2>&1 | grep Valid | sed -e 's,.*valid for ,,' -e 's,\]$,,')
  case $valid in
  *EXPIRED*) valid=Expired ;;
  esac

  local str=""
  user=$(tsh status 2>&1 | awk '/Logged/ {print $4}')

  if ! p6_string_blank "$valid" && ! p6_string_eq "$valid" "Expired"; then
    profile=$(tsh status 2>&1 | awk '/Profile/ {print $4}')
    str="teleport:\t  u:$user p:$profile v:$valid"
  fi

  p6_return_str "$str"
}

######################################################################
#<
#
# Function: p6df::modules::teleport::clones()
#
#  Environment:	 P6_DFZ_SRC_FOCUSED_DIR
#>
######################################################################
p6df::modules::teleport::clones() {

  p6_github_login_clone "gravitational" "$P6_DFZ_SRC_FOCUSED_DIR"

  p6_return_void
}

# https://goteleport.com/
# https://github.com/gravitational/teleport
# https://github.com/gravitational/teleport-plugins
# https://goteleport.com/docs/
