#!/bin/sh

if [ -d "/Volumes/media/Pictures" ]
then
    export PIC="/Volumes/media/Pictures"
fi

if [ -d "/mnt/truenas/media/Pictures" ]
then
    export PIC="/mnt/truenas/media/Pictures"
fi

alias fext='ls | cut -f 2 -d . | sort | uniq'
alias uniqf='ls | cut -f 1 -d . | sort | uniq'
alias uniqdate="picdate *"
alias cppic='mvpic -c'

picdate() {
    if (( ${+pic_dates} )); then
        for pic in $@; do
            local d=${pic_dates[$pic]}
            [[ -n $d ]] && echo $d
        done | sort | uniq
    else
        (for pic in $@; do
            exiftool -- $pic | grep -E "[12][0-9]{3}:[0-9]{2}:[0-9]{2}" | grep -E "Creat|Modif" | cut -f 2- -d : | awk '{print $1}' | sed "s/:/-/g" | sort | head -n 1
        done) | sort | uniq
    fi
}

_build_pic_dates() {
    typeset -gA pic_dates
    pic_dates=()
    [[ $# -eq 0 ]] && return
    while IFS=$'\t' read -r fname orig create modify; do
        for d in $orig $create $modify; do
            [[ $d =~ '^[12][0-9]{3}:[0-9]{2}:[0-9]{2}' ]] || continue
            pic_dates[$fname]=${${d:0:10}//:/-}
            break
        done
    done < <(exiftool -T -filename -DateTimeOriginal -CreateDate -ModifyDate -- $@)
}

get_exts() {
    if [ ${#@[@]} -gt 0  ]; then
        echo $@ | sed "s/,/ /g"
    else
        echo CR3 CR2 JPG jpg DNG dng
    fi
}


mvpic() {
    mode='i'
    cmd='mv'
    verbose=''
    exts=''
    cfld=''

    while getopts 'cinfvy:e:' flag; do
        case "${flag}" in
            c) cmd='cp';;
            i) mode='i';;
            n) mode='n';;
            f) mode='f';;
            v) verbose='v';;
            y) cfld="${OPTARG}";;
            e) exts="${OPTARG}";;
        esac
    done

    exts=($(get_exts $exts))
    local pics=($(ls_ext $exts))
    _build_pic_dates $pics
    if [[ $cmd == 'cp' && $mode == 'n' && $(uname -s) == 'Linux' ]]; then
        flags=(--update=none)
        [[ -n $verbose ]] && flags+=(-v)
    else
        flags=(-$mode$verbose)
    fi
    if [[ -n $cfld ]]; then
        echo Creating $PIC/$cfld/{,$(uniq_pic_date $exts | sed 's/ /,/g' | tr '\n' ',')}
        sh -c "mkdir -pv $PIC/$cfld/{,$(uniq_pic_date $exts | sed 's/ /,/g' | tr '\n' ',')}"
    else
        create_fld $exts
    fi
    for pic in $pics; do
        date=$(picdate $pic)
        [[ -z $date ]] && echo $pic doesn\'t have date data && continue
        [[ -z $cfld ]] && fld=${date:0:4} || fld=$cfld
        dst=${$(echo $PIC/$fld/$date*)[-1]}
        $cmd "${flags[@]}" "$pic" "$dst";
    done
    unset pic_dates
}

ls_ext() {
    exts=($(get_exts $@))
    ls | grep -E "\.($(IFS=\| ; echo "${exts[*]}"))"
}

uniq_pic_date() {
    exts=($(get_exts $@))
    picdate $(ls_ext $exts)
}

create_fld() {
    for date in $(uniq_pic_date $@); do
        year=${date:0:4}
        mkdir -p $PIC/$year
        [[ ${$(echo $PIC/$year/*)##*/} =~ $date ]] &&
            echo Found folder $(ls -d $PIC/$year/* | grep $date) ||
            (echo -n Creating folder && mkdir -pv $PIC/$year/$date)
    done
}

all_fld() {
    for fld in */**/; do
        (echo ++++++++ $fld +++++++;cd "$fld"; $@)
    done
}

