lobster_editor="${EDITOR:-nvim}"
player=mpv
download_dir="$HOME/Videos/lobster"
provider="UpCloud"
history=true
subs_language="english"
histfile="$XDG_DATA_HOME/lobster/history.txt"
use_external_menu=true
image_preview=false
image_config_path="$HOME/.config/rofi/styles/lobster-selector.rasi"
debug=false
quiet_output=false
preview_window_size=50%

# use_ueberzugpp=true
# ueberzug_x=$(($(tput cols) - 70))
# ueberzug_y=$(($(tput lines) / 10))
# ueberzug_max_width=100
# ueberzug_max_height=100

try() {
  local response res

  until [[ "$response" == 'true' ]]; do
    res=`eval $*`
    [[ -n "$res" ]] && response='true'
  done

  echo "$res"
}

download_video() {
  ffmpeg -loglevel error -stats -i "$1" -c copy "$3/$2".mp4
}
