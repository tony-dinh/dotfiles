#!/bin/bash

echo '                              :ZOZZZZZZZZZZZZZZZZ7'
echo '                          ZZZZZO               ,OZZZZZ'
echo '                       ZZZZ~   OZZZZZZZZZZZZZZZZ  ZZZZZZZ'
echo '                     ZZZ,  ZZZZZZZZZZZZZZZZZZZZZZZ  ,ZZZZZZ$'
echo '                  :OZZ  OZZZZZZZZZZZZZZZZZZZZZ ZZZZZZZZZ:ZZZZ'
echo '                IZZO  $ZZZZZZZZZZZZZZZO~   7$ZZZZZZZZZZZZZ ZZOZ'
echo '               ZZZ,OZZZZ      :ZOZZZZZZZZZ  ZZZZZZZZZZZZZZZ  ZZZ'
echo '              ZZIZZZZZZZ$ ,ZZZZZZZZZZZZZZZ, ZZZZZZZZZZZZZZZ$  ZZZ'
echo '            ?ZZ?ZZZZZZZZ OZZZZZZZZZZZZZZZZZ ZZZZZZZZZZZZZZZZZ  ZZZ'
echo '           :ZZIZZZZZZZZZZZZZZZZZZZZZZZZZZZZ ZZZZZZZZZZZZZZZZZZ  $ZO'
echo '           ZZ ZZZZZZZZZ ZZZZZZZZZZZZZZZZZZZ ZZZZZZZZZZZZZZZZZZZ  ZZ?'
echo '          ZO,ZZZZZZZZZ ZZZZZZZZZZZZZZZZZZZZ $ZZZZZZZZZZZZZZZZZZZ IZZ7'
echo '         ZZ ZZZZZZZZZ ZZZZZZZZZZZZZZZZZZZZZ  ZZZZZZZZZZZZZZZZZZZZ ZZZO'
echo '        ZZZZZZZZZZZZ  ZZZZZZZZZZZZZZZZZZZZZ   ZZZZZZZZZZZZZZZZZZZZ ZZZZ'
echo '       ZZZOZZZZZZZZO ZZZZZZZZZZZZZZZZZZZZZZ 7O$ ?ZZZZZZZZZZZZZZZZZZZZZZO'
echo '     ZZZZZZZZZZZZZ 7ZZZZZZZZZZZZZZZZZZZZZZ ZZZZI  ~ZZZO+           :ZZZZZ'
echo '    ZZZZZZZZZZZZZZZ ZZZZZZZZZZZZZZZZZZZZZZZ ZZZZZZO$                    OZZ$'
echo '   ZZZZ ZZZZZZZZZZ, ZZZZZZZZZZZZZZZZZZZZZZ OZZZZO                        =OZZ'
echo '  ZZZ   ZZZZZZZZZZ  ZZZZZZZZZZZZZZZZZZZZZIOZZZ                            :ZZZ'
echo ' OZZ,    ZZZZZZZZ ZO OZZZZZZZZZZZZZZZZZZZZ:                                ZZZ,'
echo ',ZZZ     ZZZZZZZ ZZZ  ZZZZZZZZZZZZZZZZO,                                   ?ZZZ'
echo 'ZZZ       ZZZZO ZZZZZ ZZZZZZZZZZOZI                                        ,ZZZ'
echo 'ZZZ         ZZZZZZZZZZZZZZZZZ:                                 OZZO        ZZZ'
echo 'ZZZ             :$Z$$~                                     ZZZZZ+OZO,      OZZ'
echo 'IZZ                                                    ZZZZZZZZZZ ?ZZ     ZZZ'
echo ' ZZ                                               ,OZZZZZZZZZZZZZ  ZZ    ZZZ'
echo ' ZZZ                                           OZZZ7  ZZZZZZZZZZO  :Z7 $ZZ'
echo '  ZZ$                                      ZZZ\$ZZI    ?ZZZZZZZZZ,   ZZZZ:'
echo '    ZZ=                              ,ZZZZZZZZO Z$     ZZZZZZZZZ    ZZZ'
echo '      ZZO                       OZZZZZZZZZZZZZZ ?Z      ZZZZZZZ    ZZO'
echo '         ZZZZZ7:     ,+ZZZZOZZZ\$ZZZZZZZZZZZZZZ+  ZZ       ZZ$:     ZZ?'
echo '           OZ7 ZZZZZZZZZZZZZ,     :ZZZZZZZZ\$Z:    ZO              ZZZ'
echo '           ,ZZ  ZO        ZZ         ZZZZZZ:       OZ            \$ZZ'
echo '            ,ZZ ~Z        ,ZZ            ZO         ZZO7      ,ZOZO'
echo '             +ZZ ?Z        :Z~            Z           \$ZZZZZZZZZ$'
echo '               ZZ\$\$Z        ~Z+            ZZ             ZZZZI'
echo '                ZZZZZI        ZZ            ZZZ        ZZZZZ?'
echo '                  OZZZZO       ZZ?            7ZZZZZZZZZZO'
echo '                     ZZZZZZ~     ZZZ            +ZZZZZZO'
echo '                         ZZZZZZZZZZZZZZZZZZZZZZZZOZZ'
echo '                               \$ZZZZZZZZZZZ\$O='
echo ''

cd "$(dirname "$0")/.."
DOT_ROOT=$(pwd -P)

set -e

info () {
  printf "\r [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r [ \033[0;33m??\033[0m ] $1: "
}

success () {
  printf "\r\033[2K [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

directory_exists () {
    directory=$1
    if [ -d $directory ]; then
        return 0
    else
        return 1
    fi
}

link_project () {
    local src=$1 dst=${2}/.$(basename $DOT_ROOT)

    info "🔗  Creating a symbolic link at the ROOT ..."
    if directory_exists $dst; then
        user "   ↳ '$dst' already exists! Overwrite? [y]/[n]"
        read -n 1 response
        echo ''
        if [[ $response =~ ^[^Yy]$ ]]; then
            info "👋  ↳ Resolve this issue and try again later."
            exit
        else
            rm -rf $dst
            if directory_exists $dst; then
                fail "⚠️  Uh oh, something went wrong -- Exiting ..."
                exit
            fi
        fi
    fi

    ln -s $src $dst
    if directory_exists $dst; then
        success "🍻  Successfully linked '$dst'!"
        echo ''
        install_dotfiles
    else
        fail "⚠️  Uh oh, something went wrong -- Exiting ..."
        exit
    fi
}

install_dotfiles () {
    for src in $(find -H "$DOT_ROOT" -maxdepth 2 -name '*.symlink' -not -path '*.git*')
    do
        local dst="$HOME/.$(basename "${src%.*}")"
        echo $dst
        ln -s $src $dst
    done
}


if [ "$(uname -s)" == "Darwin" ]; then
    link_project $DOT_ROOT $HOME
fi
