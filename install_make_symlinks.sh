#!/bin/bash

# Install all the dotfiles in this directory (symlink them into place)
# When a file already exists, copy it to an "old_dotfiles" directory first
# When a symlink already exists, replace it

declare -a dotfile_whitelist=(
  .bash_profile\
  .bash_includes\
  .zshrc\
  .gitconfig-shared\
  .gitignore\
  .inputrc\
  .vim\
  .vimrc\
)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
backup_dir="${DIR}/old_dotfiles"

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

# nvim: symlink init.lua and lua/dcosson individually so lazy.nvim's
# generated lazy-lock.json can live alongside without ending up in the repo.
mkdir -p "${HOME}/.config/nvim/lua"

nvim_links=(
  "${DIR}/nvim/init.lua:${HOME}/.config/nvim/init.lua"
  "${DIR}/nvim/dcosson:${HOME}/.config/nvim/lua/dcosson"
)

for pair in "${nvim_links[@]}"; do
  src="${pair%%:*}"
  dst="${pair##*:}"

  if [ -h "${dst}" ]; then
    current_target=$(readlink "${dst}")
    if [ "${current_target}" != "${src}" ]; then
      echo "WARN: removed symlink: ${dst} -> ${current_target}" 1>&2
      rm "${dst}"
      create_symlink "${src}" "${dst}"
    else
      echo "file ${dst} already set correctly" 1>&2
    fi
    continue
  fi

  if [ -e "${dst}" ]; then
    if [ ! -d "${backup_dir}" ]; then
      echo "WARN: made backup directory ${backup_dir}"
      mkdir "${backup_dir}"
    fi
    echo "WARN: moving existing ${dst} to ${backup_dir}" 1>&2
    mv "${dst}" "${backup_dir}/$(basename ${dst})-$(date +%s)"
  fi

  create_symlink "${src}" "${dst}"
done

touch "${HOME}/.dotfiles-installed"
