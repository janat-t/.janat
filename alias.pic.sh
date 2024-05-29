#!/bin/sh

export PIC=$HOME/Pictures;

alias fext='ls | cut -f 2 -d . | sort | uniq'
alias uniqf='ls | cut -f 1 -d . | sort | uniq'
alias uniqdate="picdate *"
alias cppic='mvpic -c'

picdate() {
    (for pic in $@; do
        exiftool -- $pic | grep -E "[1,2]\d{3}:\d{2}:\d{2}" | grep -E "Creat|Modif" | cut -f 2- -d : | awk '{print $1}' | sed "s/:/-/g" | sort | head -n 1
    done) | sort | uniq

}

get_exts() {
    if [ ${#@[@]} -gt 0  ]; then
        echo $@ | sed "s/,/ /g"
    else
        echo CR3 CR2 JPG
    fi
}

test_func() {
    a_flag=''
    b_flag=''
    files=''
    verbose='false'

    print_usage() {
        printf "Usage: ..."

    }

    while getopts 'abf:v' flag; do
        case "${flag}" in
            a) a_flag='true' ;;
            b) b_flag='true' ;;
            f) files="${OPTARG}" ;;
            v) verbose='true' ;;
            *) print_usage
                exit 1 ;;
        esac
    done

    echo $@
    echo $a_flag $b_flag $verbose
    echo $files
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
    if [[ -n $cfld ]]; then
        echo Creating $PIC/$cfld/{,$(uniq_pic_date $exts | sed 's/ /,/g' | tr '\n' ',')}
        sh -c "mkdir -pv $PIC/$cfld/{,$(uniq_pic_date $exts | sed 's/ /,/g' | tr '\n' ',')}"
    else
        create_fld $exts
    fi
    for pic in $(ls_ext $exts); do
        date=$(picdate $pic)
        [[ -z $date ]] && echo $pic doesn\'t have date data && continue
        [[ -z $cfld ]] && fld=${date:0:4} || fld=$cfld
        dst=${$(echo $PIC/$fld/$date*)[-1]}
        $cmd -$mode$verbose "$pic" "$dst";
    done
}

ls_ext() {
    exts=($(get_exts $@))
    ls | grep -P "\.($(IFS=\| ; echo "${exts[*]}"))"
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

tmp() {
    for pic in $(ls *.JPG); do
        date=$(stat -t %F $pic | awk '{print $10}' | sed 's/"//g')
        dst=(/Users/janat/Pictures/${date:0:4}/$date*)
        for fld in $dst; do
            if [ -d $fld  ]; then
                echo $fld
            fi
        done
    done
}


