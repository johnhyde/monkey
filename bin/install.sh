#!/bin/bash
#
# Taken from: https://github.com/timlucmiptev/btc-agents/blob/master/install.sh
# by ~timluc-miptev
#
# Modified HEAVILY
#
usage() { printf "Usage: $0 [-w] [-g] URBIT_DESK_DIRECTORY\n(-w: flag to watch and live copy code)\n(-g: install built ui to globber desk)\n" 1>&2; exit 1; }

cdir=$(dirname $0)

if [ $# -eq 0 ]; then
    usage
    exit 2
fi
DESK_DIR=${@: -1}
DESK_DIR="${DESK_DIR/#\~/$HOME}"
PIER=$(dirname $DESK_DIR)
DESK=$(basename $DESK_DIR)
EXCLUDE_FILE="${cdir}"/../config/ignore_files_on_install.txt

port=$(cat $PIER/.http.ports | grep loopback | tr -s ' ' '\n' | head -n 1)

lensd() {
    curl -s                                                              \
    --data "{\"source\":{\"dojo\":\"$1\"},\"sink\":{\"stdout\":null}}" \
    "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
}

lensa() {
    curl -s                                                              \
    --data "{\"source\":{\"dojo\":\"$2\"},\"sink\":{\"app\":\"$1\"}}"  \
    "http://localhost:$port" | xargs printf %s | sed 's/\\n/\n/g'
}

sync() {
    rsync -r --copy-links --exclude-from=$EXCLUDE_FILE "${cdir}"/../base-desk/* $DESK_DIR/
    rsync -r --copy-links --exclude-from=$EXCLUDE_FILE "${cdir}"/../docs-dev-desk/* $DESK_DIR/
    rsync -r --copy-links --exclude-from=$EXCLUDE_FILE "${cdir}"/../desk/* $DESK_DIR/
    if [ "$GLOBBER" ]; then
        rsync -r --copy-links "${cdir}"/../ui/dist/* $DESK_DIR/astrolabe
    fi
}


while getopts "wg" opt; do
    case ${opt} in
        w) WATCH_MODE="true"
           ;;
        g) GLOBBER="true"
           ;;
        *) usage
           ;;
    esac
done

if [ -z "$WATCH_MODE" ]; then
    echo "Installed %astrolabe to ${DESK_DIR}"
    rm -r $DESK_DIR/*
    sync
    lensa 'hood' "+hood/commit %$DESK"
    if [ "$GLOBBER" ]; then
        lensd '-garden!make-glob %globber /astrolabe'
        GLOBS="$PIER/.urb/put"
        GLOB=$(ls -t $GLOBS | head -1)
        TARGET_GLOBS="$cdir"/../globs/
        mkdir -p $TARGET_GLOBS
        cp "$GLOBS/$GLOB" $TARGET_GLOBS/
        echo "copied from $GLOBS to $TARGET_GLOBS"
        HASH="${GLOB//glob-/}"
        HASH="${HASH//.glob/}"
        echo $HASH
    fi
else
    echo "Watching for changes to copy to ${DESK_DIR}..."
    rm -r $DESK_DIR/*
    while [ 0 ]
    do
        sleep 0.8
        sync
    done
fi
