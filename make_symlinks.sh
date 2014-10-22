#!/bin/bash

# Install all the dotfiles in this directory (symlink them into place)
# When a file already exists, copy it to an "old_dotfiles" directory first
# When a symlink already exists, replace it

declare -a dotfile_whitelist=(
  .bash_profile\
  .bash_includes\
  .gitconfig\
  .gitignore\
  .inputrc\
  .screenrc\
  .tmux.conf\
  .vim\
  .vimrc\
)

backup_dir="${HOME}/old_dotfiles"

function create_symlink {
  echo "created symlink: $2 -> $1"
  ln -s $1 $2
}

cd `dirname $0`

for f in ${dotfile_whitelist[@]}; do
  # In the repo I don't include the leading dot so they're not all hidden
  if [[ $f =~ ^\. ]] 
  then
    repo_filename=${f:1}
  else
    repo_filename=${f}
  fi
  repo_file=$(pwd)/${repo_filename}

  # if whitelisted file isn't actually in repo, skip
  if [ ! -f ${repo_file} -a ! -d ${repo_file} ]
  then
    continue
  fi

  dotfile=${HOME}/.${repo_filename}

  # if file or dir exists, back it up then create symlink
  if [ -f ${dotfile} -o -d ${dotfile} ] && [ ! -h ${dotfile} ]
  then
    if [ ! -d ${backup_dir} ]
    then
      echo "WARN: made backup directory ${backup_dir}"
      mkdir ${backup_dir}
    fi
    echo "WARN: moving existing ${dotfile} to ${backup_dir}" 1>&2
    mv ${dotfile} ${backup_dir}
    create_symlink "${repo_file}" "${dotfile}"
    continue
  fi

  # if symlink exists and is different, warn then create new symlink
  if [ -h "${dotfile}" ]
  then
    current_target=`ls -l ${dotfile} | awk '{print $11}'`
    if [ "${current_target}" != "${repo_file}" ]
    then
      echo "WARN: removed symlink: ${dotfile} -> ${current_target}" 1>&2
      rm "${dotfile}"
      create_symlink "${repo_file}" "${dotfile}"
    else
      echo "file ${dotfile} already set correctly" 1>&2
    fi
    continue
  fi

  # doesn't exist yet, create symlink
  if [ ! -a "${dotfile}" ]
  then
    create_symlink "${repo_file}" "${dotfile}"
    continue
  fi
done
