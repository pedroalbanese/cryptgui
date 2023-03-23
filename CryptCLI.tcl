package require aes

set msg [gets stdin]

if { $argc != 3 } {
	puts "Insert the dir, key and iv:"
	puts "    aes.tcl -e|d 128bitkey 128bitIV"
	puts "\nPlease try again."
	exit 1
} else {
	set key [lindex $argv 1]
	set iv [lindex $argv 2]
}

set mode [lindex $argv 0]
if { $mode eq "-d" } {
	##### DECRYPTION
	set decryptedMsg [string trimright [string trimright  \
	[string trimright [::aes::aes -dir decrypt -iv $iv    \
	-key $key [binary decode base64 $msg]] \01] \02] \03]
	puts "$decryptedMsg"
} elseif { $mode eq "-e" } {
	##### ENCRYPTION
	set pad [expr {16 - ([string length $msg] % 16)}]
	append msg [string repeat [format %c $pad] $pad]
	set encryptedMsg [::aes::aes -dir encrypt -iv $iv -key $key $msg]
	puts "[binary encode base64 $encryptedMsg]"
}
