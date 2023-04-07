function is_macos() {
  if [[ "$( uname )" == "Darwin" ]]; then
    return 0
  fi

  return 1
}


function datetime_now() {
    date +"%Y-%m-%d %H:%M:%S"
}


function log_info() {
    echo -e "$( tput setaf 6 )$( datetime_now ) [INFO] ${1}$( tput sgr0 )"
}


function now() {
  log_info "$( datetime_now )"
}


# 返回公网 IP
function myip() {
  log_info "$( curl -s http://myip.ipip.net/ )"
}


# ip     返回本机第一个 IP 地址
# ip all 返回本机全部 IP 地址
function ip() {
  if is_macos; then
    # https://apple.stackexchange.com/a/147777
    privateIp=$( ifconfig | grep "inet " | grep -Fv 127.0.0.1 | awk '{print $2}' )
  else
    privateIp="$( hostname -I | awk '{print $1}' )"
  fi

  if [[ -z "$1" ]]; then
    # 使用 awk 的方法，来自 Warp AI
    # privateIp=$( echo "$privateIp" | awk 'NR==1{print $1}' )

    # 使用 head 的方法 https://stackoverflow.com/a/46022082
    privateIp="$( echo "$privateIp" | head -n 1 )"
  fi

  log_info "$privateIp"
}


function docker_rmi_none() {
  # https://projectatomic.io/blog/2015/07/what-are-docker-none-none-images/
  docker rmi $( docker images -f "dangling=true" -q )
}


alias aptupgrade="sudo apt update -y && sudo apt upgrade -y && sudo apt autoremove -y"
