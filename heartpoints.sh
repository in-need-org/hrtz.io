#!/usr/bin/env bash
heartpoints() { local command=$1; local remainingArgs=${@:2}
    if string_is_empty "${command}"; then
        heartpoints_help
    else
        heartpoints_${command} $remainingArgs
    fi
}

heartpoints_help() {
    echo ""
    echo "Usage: heartpoints.sh [command]"
    echo ""
    echo "Commands:"
    echo ""
    echo "dev     - run dev web server locally and pop open browser (may require refresh)"
    echo "deploy  - interactive interview to deploy to production, requires heroku credentials"
    echo "model   - outputs a sequence of states describing the evolution of the heartpoints ecosystem"
    echo "yarn    - call the heartpoints-specific version of yarn to add / remove dependencies, etc"
    echo ""
}

string_is_empty() { local possiblyEmptyString=$1
    [[ -z "${possiblyEmptyString}" ]]
}

heartpoints_dev() {
    heartpoints_yarn install
    heartpoints_yarn webpack
    heartpoints_yarn start
}

heartpoints_yarn() { local args=$@
    if command_does_not_exist "yarn"; then
        nvm_load
        nvm install
        nvm use
        npm install yarn -g
    fi
    yarn ${args}
}

git_current_branch() {
    echo "$(git rev-parse --abbrev-ref HEAD)"
}

git_current_branch_is_master() {
    strings_are_equal "$(git_current_branch)" "master"
}

strings_are_equal() { local string1=$1; local string2=$2
    [ "${string1}" = "${string2}" ]
}

heartpoints_deploy() {
    if git_working_directory_is_clean && git_current_branch_is_master; then
        (brew install heroku/brew/heroku)
        heroku login
        heroku git:remote --app heartpoints-org
        git push heroku head
    else
        echo "Cannot deploy, working directory must ber clean and current branch must be master"
        exit 1
    fi
}

heartpoints_model() {
    heartpoints_yarn install
    heartpoints_yarn ts-node src/heartpoints-cli.ts
}

git_working_directory_is_clean() {
    [ -z "$(git status --porcelain)" ]
}

command_does_not_exist() { local possibleCommand=$1
    ! [ -x "$(command -v ${possibleCommand})" ]
}

nvm_script_path() {
    echo "$(nvm_script_dir)/nvm.sh"
}

nvm_script_dir() {
    echo "$HOME/.nvm"
}

nvm_load_existing_nvm() {
    export NVM_DIR="$(nvm_script_dir)"
    [ -s "$(nvm_script_path)" ] && \. "$(nvm_script_path)"
}

file_does_not_exist() { local possibleFilePath=$1
    ! [ -e "${possibleFilePath}" ]
}

nvm_download_and_install() {
    curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
}

nvm_load() {
    if command_does_not_exist "nvm"; then
        if file_does_not_exist "$(nvm_script_path)"; then
            nvm_download_and_install
        fi
        nvm_load_existing_nvm
    fi
}

heartpoints $@