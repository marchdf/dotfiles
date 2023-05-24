#!/bin/bash
#
# Key remappings
#

# inspired from https://apple.stackexchange.com/questions/441179/how-to-remap-keys-when-using-universal-control-between-two-macs
# refer to the table for key codes: https://developer.apple.com/library/archive/technotes/tn2450/_index.html
function usage() {
    echo "Usage: keyremap.sh <enable|disable>"
}

if [[ $# != 1 ]]; then
    usage
    exit 1
fi

action=$1

# Set productid variable, as per example below, to remap only specific
# keyboard, or leave empty to remap all connected keyboards
productid_external='{"ProductID":0x23a}'
productid_builtin='{"ProductID":0x340}'
# productid="-m \'${productid_builtin}\'"
productid=""

if [[ ${action} =~ ^(e|en|ena|ena.*)$ ]]; then
    # 1. map right command (aka Right GUI) to Application (aka menu key)
    # 2. map caps lock to left control
    hidutil property ${productid} --set '{"UserKeyMapping":[
        {
            "HIDKeyboardModifierMappingSrc": 0x7000000E7,
            "HIDKeyboardModifierMappingDst": 0x700000065
        },
        {
            "HIDKeyboardModifierMappingSrc": 0x700000039,
            "HIDKeyboardModifierMappingDst": 0x7000000e0
        }
    ]}'
elif [[ ${action} =~ ^(d|di|dis|disa.*)$ ]]; then
    hidutil property --set '{"UserKeyMapping":[]}'
else
    usage
    exit 1
fi
