#!/bin/bash


function run_command {
    # --------------------------------------------------------------------------
    # Run the YAML command with all files in the config directory, one at a time
    #   => Parameters: YAML_FILE, CONFIG_DIR
    # Return an error if any operation fails
    # --------------------------------------------------------------------------
    local YAML_FILE=$1;
    local CONFIG_DIR=$2;
    echo "building all from ${CONFIG_DIR} using ${YAML_FILE}";

    for filename in ${CONFIG_DIR}/*.json; do
        echo "building ${filename} using ${YAML_FILE}";
        ansible-playbook ${YAML_FILE} \
            -e "@${filename}";
        if [ $? != 0 ]; then return 1; fi
    done
    if [ $? != 0 ]; then return 1; fi

    return 0;
}

function run_command_inventory {
    # ---------------------------------------------------------------------------
    # Run the YAML command with all files in the config directory, one at a time,
    # against the inventory specified in the inventory file.
    #   => Parameters: YAML_FILE, INVENTORY, CONFIG_DIR
    # Return an error if any operation fails
    # ---------------------------------------------------------------------------
    local YAML_FILE=$1;
    local INVENTORY=$2;
    local CONFIG_DIR=$3;
    echo "building all from ${CONFIG_DIR} using ${YAML_FILE} on ${INVENTORY}";

    for filename in ${CONFIG_DIR}/*.json; do
        echo "building ${filename} using ${YAML_FILE}";
        ansible-playbook ${YAML_FILE} \
            -i "${INVENTORY}" \
            -e "@${filename}";
        if [ $? != 0 ]; then return 1; fi
    done
    if [ $? != 0 ]; then return 1; fi

    return 0;
}

function run_authorized_command {
    # ---------------------------------------------------------------------------
    # Run the YAML command with all files in the config directory, one at a time,
    # using authorization specified in the credentials file.
    #   => Parameters: AUTHORIZATION, YAML_FILE, CONFIG_DIR
    # Return an error if any operation fails
    # ---------------------------------------------------------------------------
    local AUTHORIZATION=$1;
    local YAML_FILE=$2;
    local CONFIG_DIR=$3;
    echo "building all from ${CONFIG_DIR} using ${YAML_FILE} authorized by ${AUTHORIZATION}";

    for filename in ${CONFIG_DIR}/*.json; do
        echo "building ${filename} using ${YAML_FILE}";
        ansible-playbook ${YAML_FILE} \
            -e "@${AUTHORIZATION}" \
            -e "@${filename}";
        if [ $? != 0 ]; then return 1; fi
    done
    if [ $? != 0 ]; then return 1; fi

    return 0;
}

function run_authorized_command_inventory {
    # ---------------------------------------------------------------------------
    # Run the YAML command with all files in the config directory, one at a time,
    # using authorization specified in the credentials file, against the 
    # inventory specified in the inventory file.
    #   => Parameters: AUTHORIZATION, YAML_FILE, INVENTORY, CONFIG_DIR
    # Return an error if any operation fails
    # ---------------------------------------------------------------------------
    local AUTHORIZATION=$1;
    local YAML_FILE=$2;
    local INVENTORY=$3;
    local CONFIG_DIR=$4;
    echo "building all from ${CONFIG_DIR} using ${YAML_FILE} authorized by ${AUTHORIZATION}";

    for filename in ${CONFIG_DIR}/*.json; do
        echo "building ${filename} using ${YAML_FILE}";
        ansible-playbook ${YAML_FILE} \
            -i "${INVENTORY}" \
            -e "@${AUTHORIZATION}" \
            -e "@${filename}";
        if [ $? != 0 ]; then return 1; fi
    done
    if [ $? != 0 ]; then return 1; fi

    return 0;
}

function main {
    # -----------------------------
    # No action needed, placeholder
    # This is just a library script
    # Return 0, no error will occur
    # -----------------------------
    return 0;
}


if [ "${1}" != "--no-execute" ]; then
    # --------------------------------------------------
    # Run main function, unless this script was imported 
    # into another script with the "no execute" flag
    # This script should be run with "sudo"
    # --------------------------------------------------
    main "${@}";
fi
