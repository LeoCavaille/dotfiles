alias c="clear"

# typo-fun
alias v="vim"
alias bim="vim"
alias vmi="vim"
alias vib="vim"
alias vi="vim"
alias shs="ssh"
alias hss="ssh"
alias sl="ls"
alias cul="curl"
# typo gco
alias gro="git checkout"
alias er11="git checkout"

alias vimrc="vim ~/.vimrc"
alias gite="git"
alias resource="source ~/.zshrc"

function editconflicts() {
    vim +/"<<<<<<<" $( git diff --name-only --diff-filter=U | xargs )
}

function sharefile() {
    NAME=`echo $1 | md5 | cut -c1-10`
    EXTENSION="${1##*.}"
    scp -4 $1 chiron@zwoop.gb2n.org:public_html/share/$NAME.$EXTENSION
    LINK="http://chiron.gb2n.org/share/$NAME.$EXTENSION"
    echo -n $LINK | pbcopy
    echo "$LINK copied to clipboard"
    open $LINK
}

function sharelastsnapshot() {
    LAST_SNAP=`ls -1 -t ~/Desktop/Screen\ Shot* | head -n1`
    sharefile "$LAST_SNAP"
}

function agfile() {
    ag -l -G $1 .
}

function agopenall() {
    ag -l !* | xargs vim -p
}
