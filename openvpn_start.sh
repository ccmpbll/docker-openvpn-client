#!/bin/bash

#Check Env for config file name
if [[ "${OPENVPN_CONF}" == "NONE" ]]; then
  echo "OpenVPN config not provided. Exiting."
  exit 1
fi  

#Check if config file exists
if [[ -f "${CONFIG_PATH}/${OPENVPN_CONF}" ]]; then
  echo "Using supplied OpenVPN config: ${CONFIG_PATH}/${OPENVPN_CONF}"
else
  echo "Supplied OpenVPN config ${CONFIG_PATH}/${OPENVPN_CONF} could not be found."
  exit 1
fi

#Check Env for auth file name
if [[ "${OPENVPN_AUTH}" == "NONE" ]]; then
  echo "OpenVPN auth not provided. Exiting."
  exit 1
fi  

#Check if config file exists
if [[ -f "${CONFIG_PATH}/${OPENVPN_AUTH}" ]]; then
  echo "Using supplied OpenVPN auth file: ${CONFIG_PATH}/${OPENVPN_AUTH}"
else
  echo "Supplied OpenVPN auth file ${CONFIG_PATH}/${OPENVPN_AUTH} could not be found."
  exit 1
fi

mkdir -p /dev/net
[[ -c /dev/net/tun ]] || mknod -m 0666 /dev/net/tun c 10 200

exec openvpn --config "${CONFIG_PATH}/${OPENVPN_CONF}" --auth-user-pass "${CONFIG_PATH}/${OPENVPN_AUTH}" --auth-nocache ${OPENVPN_OPTS}
