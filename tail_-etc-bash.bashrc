# Notify on SSH login (only once per interactive session)
if [[ -n "$SSH_CONNECTION" ]]; then
    LOGIN_IP=$(echo $SSH_CONNECTION | awk '{print $1}')
    /home/fhfnas/scripts/discord-notify/discord_notify.sh "[EVENT] SSH login by $USER from $LOGIN_IP"
    trap '/home/fhfnas/scripts/discord-notify/discord_notify.sh "[EVENT] SSH logout by $USER from $LO>fi
