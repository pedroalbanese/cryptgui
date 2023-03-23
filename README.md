# AHK Encryption Tool
[![ISC License](http://img.shields.io/badge/license-ISC-blue.svg)](https://github.com/pedroalbanese/cryptgui/blob/master/LICENSE.md) 
[![GitHub downloads](https://img.shields.io/github/downloads/pedroalbanese/cryptgui/total.svg?logo=github&logoColor=white)](https://github.com/pedroalbanese/cryptgui/releases)
[![GitHub release (latest by date)](https://img.shields.io/github/v/release/pedroalbanese/cryptgui)](https://github.com/pedroalbanese/cryptgui/releases)

#### AES-CBC String Encryption Tool written in Pure AutoHotKey

The Advanced Encryption Standard (AES), also known by its original name Rijndael, is a specification for the encryption of electronic data established by the U.S. National Institute of Standards and Technology (NIST) in 2001.

![CryptGUI](CryptGUI.png "Click to enlarge")


### PHP Equivalent
```php
Result Decrypted:
<?php
	$iv = "0000000000000000";
	$pass = "1234567890abcdef";
	$method = 'aes-128-cbc';

	print (openssl_decrypt("rNRDKOTTEKj2GPrH7rv4IQ==", $method, $pass, false, $iv));
?>

Result Encrypted:
<?php
	$iv = "0000000000000000";
	$pass = "1234567890abcdef";
	$method = 'aes-128-cbc';

	print (openssl_encrypt("SECRET MESSAGE", $method, $pass, false, $iv));
?>
```

### TCL Equivalent
```tcl
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
```

## License

This project is licensed under the ISC License.

#### Copyright (c) 2020-2023 Pedro F. Albanese - ALBANESE Research Lab.
