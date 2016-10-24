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

warn () {
  printf "\r [ \033[00;34m!!\033[0m ] $1\n"
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
    local overwrite= skip= backup=
    local response="x"

    info "🔗  Creating a symbolic link in the HOME directory ..."
    if directory_exists $dst; then
        warn "   ↳ '$dst' already exists!"
        while [[ $response =~ ^[^sob]$ ]]; do
            user "   ↳ What do you want to do? [s]kip, [o]verwrite, [b]ackup"
            read -n 1 response
            echo ''
        done

        case "$response" in
            s )
                skip=true;;
            o )
                overwrite=true;;
            b )
                backup=true;;
            * )
                ;;
        esac
    fi

    if [ "$overwrite" == "true" ]; then
        info "   ↳ Overwriting '$dst' ..."
        rm -rf "$dst"
    elif [ "$backup" == "true" ]; then
        info "   ↳ Backing up '$dst' ..."
        mv "$dst" "${dst}.backup"
    elif [ "$skip" == "true" ]; then
        success "   ↳ Skipped!"
    fi

    if [ "skip" != "true" ]; then
        ln -s "$src" "$dst"
        success "🍻  Successfully linked '$dst'!"
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
    install_dotfiles
fi
