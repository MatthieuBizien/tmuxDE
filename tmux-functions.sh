#
# The functions available in the main window of tmux DE
#

DIRNAME=$(dirname "$0")

function tmux-monitor() {
 name=${2-monitor}
 tmux neww      -a -n "$name"         'htop'
 tmux splitw -v	  -p 70	 	'sudo iftop -i wlan0'
 tmux splitw -v	  -p 50		'(echo "--nd."; cat -)|nmon'
}
function tmux-opendir() {
 name=${2-$1}
 tmux neww        -a -n "$name"         "cd \"$1\"; bash"
 tmux splitw    -h          -p 60               "cd \"$1\"; bash"
 tmux select-pane -L
 tmux splitw      -p 50               "cd \"$1\"; bash"
 tmux select-pane -R
}
function tmux-git() {
 name=${2-git}
 tmux neww        -a -n "$name"         "cd \"$1\"; $DIRNAME/actualiseGitStatus.sh"
 tmux splitw    -h          -p 60               "cd \"$1\"; bash"
 tmux select-pane -L
 tmux splitw      -p 50               "cd \"$1\"; $DIRNAME/actualiseGitWhatchanged.sh"
 tmux select-pane -R
}
function tmux-bash() {
 name=${2-bash}
 tmux neww -a -n "$name" "bash"
 tmux splitw -h "bash"
}
function tmux-sudo() {
 name=${2-sudo}
 tmux neww -a -n "$name" "sudo -s"
 tmux splitw -h "sudo -s"
}
function tmux-ssh() {
 name=${2-ssh}
 tmux neww       -a -n "$name"         "read null; ssh $1"
}
function tmux-mainwindow() {
 tmux neww -a -n main              "while true; do
     clear
     cat $(dirname $0)/mainwindow-message
     inotifywait -q $(dirname $0)/mainwindow-message
     done"
 tmux splitw   -p 70                           "cd $(dirname $0); bash --rcfile mainwindow.bashrc"
}

