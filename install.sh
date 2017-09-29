#!/bin/bash


function installAnsible {
    # -----------------------------------------------------------------------
    # Ensure the latest version of Ansible is installed on the current system
    # Return an error code if installation fails
    # -----------------------------------------------------------------------
    echo "Installing Ansible"
    apt-get install ansible
    if [ $? != 0 ]; then return 1; fi

    return 0
}

function main {
    # -----------------------------------------------
    # Run through all required steps, specified above
    # Return an error if any operation fails
    # -----------------------------------------------
    installAnsible
    if [ $? != 0 ]; then return 1; fi
    
    return 0
}


if [ "${1}" != "--no-execute" ]; then
    # --------------------------------------------------
    # Run main function, unless this script was imported 
    # into another script with the "no execute" flag
    # This script should be run with "sudo"
    # --------------------------------------------------
    main "${@}"
fi


