#!/bin/bash
# RafzHost SSH welcome banner
# Telegram: t.me/Rafzbotz | t.me/RafzHost

[ -t 1 ] || return 0 2>/dev/null || exit 0

C_RESET=$'\e[0m'
C_BOLD=$'\e[1m'
C_CYAN=$'\e[38;5;51m'
C_BLUE=$'\e[38;5;33m'
C_GREEN=$'\e[38;5;46m'
C_YELLOW=$'\e[38;5;220m'
C_GREY=$'\e[38;5;245m'
C_WHITE=$'\e[38;5;231m'

_os="$(. /etc/os-release 2>/dev/null; echo "${PRETTY_NAME:-Linux}")"
_host="$(hostname 2>/dev/null)"
_user="$(whoami 2>/dev/null)"
_uptime="$(uptime -p 2>/dev/null | sed 's/^up //')"
_mem="$(free -h 2>/dev/null | awk '/^Mem:/ {print $3 " / " $2}')"
_ip="$(hostname -I 2>/dev/null | awk '{print $1}')"
_node="$(node -v 2>/dev/null || echo 'n/a')"
_pm2="$(pm2 -v 2>/dev/null || echo 'n/a')"

printf '\n'
printf '%s\n' "${C_CYAN}${C_BOLD}  ██████╗  █████╗ ███████╗███████╗██╗  ██╗ ██████╗ ███████╗████████╗${C_RESET}"
printf '%s\n' "${C_BLUE}${C_BOLD}  ██╔══██╗██╔══██╗██╔════╝╚══███╔╝██║  ██║██╔═══██╗██╔════╝╚══██╔══╝${C_RESET}"
printf '%s\n' "${C_BLUE}${C_BOLD}  ██████╔╝███████║█████╗    ███╔╝ ███████║██║   ██║███████╗   ██║   ${C_RESET}"
printf '%s\n' "${C_CYAN}${C_BOLD}  ██╔══██╗██╔══██║██╔══╝   ███╔╝  ██╔══██║██║   ██║╚════██║   ██║   ${C_RESET}"
printf '%s\n' "${C_CYAN}${C_BOLD}  ██║  ██║██║  ██║██║     ███████╗██║  ██║╚██████╔╝███████║   ██║   ${C_RESET}"
printf '%s\n' "${C_CYAN}${C_BOLD}  ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝   ${C_RESET}"
printf '\n'
printf '%s\n' "${C_WHITE}${C_BOLD}          Lightweight Ubuntu SSH · Railway VPS${C_RESET}"
printf '%s\n' "${C_YELLOW}          t.me/Rafzbotz  ·  t.me/RafzHost${C_RESET}"
printf '\n'
printf '%s\n' "${C_GREY}  ────────────────────────────────────────────${C_RESET}"
printf "  ${C_CYAN}User${C_RESET}     │ ${C_WHITE}%s${C_RESET} @ ${C_WHITE}%s${C_RESET}\n" "$_user" "$_host"
printf "  ${C_CYAN}OS${C_RESET}       │ ${C_WHITE}%s${C_RESET}\n" "$_os"
printf "  ${C_CYAN}Uptime${C_RESET}   │ ${C_WHITE}%s${C_RESET}\n" "${_uptime:-just now}"
printf "  ${C_CYAN}Memory${C_RESET}   │ ${C_WHITE}%s${C_RESET}\n" "${_mem:-n/a}"
printf "  ${C_CYAN}IP${C_RESET}       │ ${C_WHITE}%s${C_RESET}\n" "${_ip:-n/a}"
printf "  ${C_CYAN}Node${C_RESET}     │ ${C_WHITE}%s${C_RESET}\n" "$_node"
printf "  ${C_CYAN}PM2${C_RESET}      │ ${C_WHITE}%s${C_RESET}\n" "$_pm2"
printf '%s\n' "${C_GREY}  ────────────────────────────────────────────${C_RESET}"
printf "  ${C_GREEN}➜${C_RESET} Connect: ${C_YELLOW}ssh root@<domain> -p <port>${C_RESET}\n"
printf "  ${C_GREEN}➜${C_RESET} Channel : ${C_YELLOW}t.me/RafzHost${C_RESET}\n"
printf "  ${C_GREEN}➜${C_RESET} Tips    : ${C_YELLOW}neofetch${C_RESET} | ${C_YELLOW}pm2 list${C_RESET}\n"
printf '\n'
