function tmux-opendir() {
 name=${2-$1}
 tmux neww      -t $SESSION -a -n $name         "cd $1; bash"
 tmux splitw    -h          -p 60               "cd $1; bash"
 tmux select-pane -L
 tmux splitw    -t $SESSION -p 50               "cd $1; bash"
 tmux select-pane -R
}
function tmux-git() {
 name=${2-git}
 tmux neww      -t $SESSION -a -n $name         "cd $1; ~/Code/sh/actualiseGitStatus.sh"
 tmux splitw    -h          -p 60               "cd $1; bash"
 tmux select-pane -L
 tmux splitw    -t $SESSION -p 50               "cd $1; ~/Code/sh/actualiseGitWhatchanged.sh"
 tmux select-pane -R
}
function tmux-ssh() {
  tmux neww     -t $SESSION -a -n $2            "while true; do echo 'Press enter for connecting to $2'; read null; ssh $1; done"
}
tmux-mainwindow() {
  tmux neww -t $SESSION -a -n main              "while true; do 
      cat mainwindow-message
      inotifywait mainwindow-message
      done"
  tmux splitw    -t $SESSION -a -n main         "bash --rc-file mainwindow.bashrc"
}

