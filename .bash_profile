if [ -f ~/.bashrc ]; then . ~/.bashrc; fi 

# Load ~/.extra, ~/.bash_prompt, ~/.exports, ~/.aliases and ~/.functions
# ~/.extra can be used for settings you don’t want to commit
for file in ~/.{extra,bash_prompt,exports,aliases,functions}; do
	[ -r "$file" ] && source "$file"
done
unset file
alias phpm="/Applications/MAMP/bin/php/php5.4.10/bin/php"
export PATH=${PATH}:/Users/brent/Documents/android-sdk/platform-tools:/Users/brent/Documents/android-sdk/tools

##
# Your previous /Users/brent/.bash_profile file was backed up as /Users/brent/.bash_profile.macports-saved_2014-02-12_at_17:45:01
##

# MacPorts Installer addition on 2014-02-12_at_17:45:01: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:~/bin:~/.composer/vendor/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

# init z   https://github.com/rupa/z
. ~/code/z/z.sh

# cd into whatever is the forefront Finder window.
cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# Start an HTTP server from a directory, optionally specifying the port
#function server() {
#	#local port="${1:-8000}"
#        python -m SimpleHTTPServer 4104
#	open "http://0.0.0.0:4104"
#	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
#	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
#	# python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
#}


# Start an HTTP server from a directory, optionally specifying the port
function server() {
	
	php -S localhost:8888
	open "http://localhost:8888/"
	#open "http://0.0.0.0:$port/"
	# Set the default Content-Type to `text/plain` instead of `application/octet-stream`
	# And serve everything as UTF-8 (although not technically correct, this doesn’t break anything for binary files)
	#python -c $'import SimpleHTTPServer;\nmap = SimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map;\nmap[""] = "text/plain";\nfor key, value in map.items():\n\tmap[key] = value + ";charset=UTF-8";\nSimpleHTTPServer.test();' "$port"
}


# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}

# Extract archives - use: extract <file>
# Based on http://dotfiles.org/~pseup/.bashrc
function extract() {
	if [ -f "$1" ] ; then
		local filename=$(basename "$1")
		local foldername="${filename%%.*}"
		local fullpath=`perl -e 'use Cwd "abs_path";print abs_path(shift)' "$1"`
		local didfolderexist=false
		if [ -d "$foldername" ]; then
			didfolderexist=true
			read -p "$foldername already exists, do you want to overwrite it? (y/n) " -n 1
			echo
			if [[ $REPLY =~ ^[Nn]$ ]]; then
				return
			fi
		fi
		mkdir -p "$foldername" && cd "$foldername"
		case $1 in
			*.tar.bz2) tar xjf "$fullpath" ;;
			*.tar.gz) tar xzf "$fullpath" ;;
			*.tar.xz) tar Jxvf "$fullpath" ;;
			*.tar.Z) tar xzf "$fullpath" ;;
			*.tar) tar xf "$fullpath" ;;
			*.taz) tar xzf "$fullpath" ;;
			*.tb2) tar xjf "$fullpath" ;;
			*.tbz) tar xjf "$fullpath" ;;
			*.tbz2) tar xjf "$fullpath" ;;
			*.tgz) tar xzf "$fullpath" ;;
			*.txz) tar Jxvf "$fullpath" ;;
			*.zip) unzip "$fullpath" ;;
			*) echo "'$1' cannot be extracted via extract()" && cd .. && ! $didfolderexist && rm -r "$foldername" ;;
		esac
	else
		echo "'$1' is not a valid file"
	fi
}

# animated gifs from any video
# from alex sexton   gist.github.com/SlexAxton/4989674
gifify() {
  if [[ -n "$1" ]]; then
    if [[ $2 == '--good' ]]; then
      ffmpeg -i $1 -r 10 -vcodec png out-static-%05d.png
      time convert -verbose +dither -layers Optimize -resize 600x600\> out-static*.png  GIF:- | gifsicle --colors 128 --delay=5 --loop --optimize=3 --multifile - > $1.gif
      rm out-static*.png
    else
      ffmpeg -i $1 -s 600x400 -pix_fmt rgb24 -r 10 -f gif - | gifsicle --optimize=3 --delay=3 > $1.gif
    fi
  else
    echo "proper usage: gifify <input_movie.mov>. You DO need to include extension."
  fi
}

alias sb='ssh serveradmin@siteburst.net@siteburst.net -i ~/.ssh/mykey'
#alias web9='ssh bgarner@calweb9ap01.fglsports.dmz -i ~/.ssh/mykey'
#alias web8='ssh bgarner@calweb8ap01.fglsports.com -i ~/.ssh/mykey'
#alias mysql1='ssh bgarner@calmys1db01.fglsports.dmz -i ~/.ssh/mykey'
alias web9='ssh bgarner@calweb9ap01.fglsports.dmz'
alias web8='ssh bgarner@calweb8ap01.fglsports.com'
alias mysql1='ssh bgarner@calmys1db01.fglsports.dmz'
alias codecept='vendor/bin/codecept'
alias gs='git status'
alias pa='php artisan'
alias git-remove='git rm $(git ls-files --deleted)'
export PATH="/usr/local/sbin:$PATH"
