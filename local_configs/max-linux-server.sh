raid_prompt() { 
	awk '/^md/ {printf "%s", $1}; /blocks/ {printf "%s: ", $NF}'  /proc/mdstat | awk '/\[U+\]/ {print "\033[32m" $0 "healthy\033[0m"}; /\[.*_.*\]/ {print "\033[31m" $0 "degraded\033[0m"}'; 
}
raid_prompt
