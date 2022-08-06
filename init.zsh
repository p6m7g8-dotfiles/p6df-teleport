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

  brew install telport
}

######################################################################
#<
#
# Function: p6df::modules::teleport::init()
#
#>
######################################################################
p6df::modules::teleport::init() {

  p6df::modules::teleport::prompt::init
}

######################################################################
#<
#
# Function: p6df::modules::teleport::prompt::init()
#
#>
######################################################################
p6df::modules::teleport::prompt::init() {

  p6df::core::prompt::line::add "p6df::modules::teleport::prompt::line"
}

#  tsh login --proxy=x:443 --auth=local --user=email
#  tsh db connect --db-user=teleport --db-name=fooc foo
#  tsh kube ls
#  tsh nodes ls
#  tsh ssh -f <id>

######################################################################
#<
#
# Function: p6df::modules::teleport::prompt::line()
#
#>
######################################################################
p6df::modules::teleport::prompt::line() {
  p6_teleport_prompt_info
}

######################################################################
#<
#
# Function: str str = p6_teleport_prompt_info()
#
#  Returns:
#	str - str
#
#  Environment:	 EXPIRED
#>
######################################################################
p6_teleport_prompt_info() {

  local profile
  local user
  local valid

  valid=$(tsh status 2>&1 | grep Valid | sed -e 's,.*valid for ,,' -e 's,\]$,,')
  case $valid in
  *EXPIRED*) valid=Expired ;;
  esac

  local str
  user=$(tsh status 2>&1 | awk '/Logged/ {print $4}')
  if ! p6_string_eq "$valid" "Expired"; then
    profile=$(tsh status 2>&1 | awk '/Profile/ {print $4}')
    str="teleport:\t  u:$user p:$profile v:$valid"
  else
    str="teleport:\t  u:$user EXPIRED"
  fi

  p6_return_str "$str"
}
