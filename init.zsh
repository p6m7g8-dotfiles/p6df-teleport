######################################################################
#<
#
# Function: p6df::modules::teleport::deps()
#
#>
######################################################################
p6df::modules::teleport::deps() {
  ModuleDeps=(
    p6m7g8/p6common
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
  true
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
#>
######################################################################
p6_teleport_prompt_info() {

  local profile
  local user
  local valid

  profile=$(tsh status | awk '/Profile/ {print $4}')
  user=$(tsh status | awk '/Logged/ {print $4}')
  valid=$(tsh status | grep Valid | sed -e 's,.*valid for ,,' -e 's,\]$,,')

  local str
  str="teleport: u:$user p:$profile v:$valid"

  p6_return_str "$str"
}
