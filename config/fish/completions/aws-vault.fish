function __fish_awsvault_needs_command
  set -l opts h-help v-version N-no-color
  set cmd (commandline -opc)
  set -e cmd[1]
  argparse -s $opts -- $cmd 2>/dev/null
  or return 0
  if set -q argv[1]
    echo $argv[1]
    return 1
  end
  return 0
end

function __fish_awsvault_using_command
  set -l cmd (__fish_awsvault_needs_command)
  test -z "$cmd"
  and return 1
  contains -- $cmd $argv
  and return 0
  return 1
end

function __fish_awsvault_has_profile
  set -l cmd (commandline -opc)
  set -e cmd[1..2]
  set -q cmd[1]
end

function __fish_awsvault_profiles
  aws-vault list --profiles
end

function __fish_awsvault_complete_exec_command
  set -l cmd (commandline -op)
  set -e cmd[1..3]
  complete -C"$cmd"
end

# exec [<flags>] <profile> [<cmd>] [<args>...]
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a exec -d 'Executes a command with AWS credentials in the environment'
complete -k -f -c aws-vault -n '__fish_awsvault_using_command exec; and not __fish_awsvault_has_profile' -a '(__fish_awsvault_profiles)'
complete -c aws-vault -f -n '__fish_awsvault_using_command exec; and __fish_awsvault_has_profile' -a '(__fish_awsvault_complete_exec_command)'

# help [<command>...]
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a help -d 'Show help'

# add [<flags>] <profile>
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a add -d 'Adds credentials, prompts if none provided'

# list [<flags>]
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a list -d 'List profiles, along with their credentials and sessions'

# rotate [<flags>] <profile>
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a rotate -d 'Rotates credentials'

# remove [<flags>] <profile>
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a remove -d 'Removes credentials, including sessions'

# login [<flags>] <profile>
complete -f -c aws-vault -n '__fish_awsvault_needs_command' -a login -d 'Generate a login link for the AWS Console'
