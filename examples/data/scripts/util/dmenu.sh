#!/bin/sh
# dmenu setup

case "$DMENU_SCHEME" in
    # wmii
    "wmii" )
        NB="#303030"
        NF="khaki"
        SB="#ccffaa"
        SF="#303030"
        ;;
    # Formfiller
    "formfiller" )
        NB="#0f0f0f"
        NF="4e7093"
        SB="#003d7c"
        SF="#3a9bff"
        ;;
    # Bookmarks
    "bookmarks" )
        NB="#303030"
        NF="khaki"
        SB="#ccffaa"
        SF="#303030"
        ;;
    # History
    "history" )
        NB="#303030"
        NF="khaki"
        SB="#ccffaa"
        SF="#303030"
        ;;
    # Default
    * )
        NB="#303030"
        NF="khaki"
        SB="#ccffaa"
        SF="#303030"
        ;;
esac

DMENU_COLORS="-nb $NB -nf $NF -sb $SB -sf $SF"

# Default arguments
if [ -z "$DMENU_ARGS" ]; then
    DMENU_ARGS="-i"
fi

# Set the font if wanted
if [ -n "$DMENU_FONT" ]; then
    DMENU_ARGS="$DMENU_ARGS -fn $DMENU_FONT"
fi

# Set the prompt if wanted
if [ -n "$DMENU_PROMPT" ]; then
    DMENU_ARGS="$DMENU_ARGS -p $DMENU_PROMPT"
fi

# Detect the xmms patch
if dmenu --help 2>&1 | grep -q '\[-xs\]'; then
    DMENU_XMMS_ARGS="-xs"
    DMENU_HAS_XMMS=1

    if echo $DMENU_OPTIONS | grep -q -w 'xmms'; then
        DMENU_ARGS="$DMENU_ARGS $DMENU_XMMS_ARGS"
    fi
fi

# Detect the vertical patch
if dmenu --help 2>&1 | grep -q '\[-l <lines>\]'; then
    # Default to 10 lines
    if [ -z "$DMENU_LINES" ]; then
        DMENU_LINES=10
    fi

    DMENU_ARGS="$DMENU_ARGS -l $DMENU_LINES"
    DMENU_HAS_VERTICAL=1

    # Detect the resize patch
    if dmenu --help 2>&1 | grep -q '\[-rs\]'; then
        DMENU_ARGS="$DMENU_ARGS -rs"
    fi
fi

DMENU="dmenu $DMENU_ARGS $DMENU_COLORS"
