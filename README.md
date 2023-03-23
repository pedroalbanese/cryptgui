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

set key "1234567890abcdef";  # Must be 16 bytes long
set iv "0000000000000000";   # Must be 16 bytes long
set msg "This is an implementation in Tcl of the Advanced Encryption Standard (AES)"

##### ENCRYPTION
set encryptedMsg [::aes::aes -dir encrypt -iv $iv -key $key $msg]
puts "$encryptedMsg"

##### DECRYPTION
set decryptedMsg [::aes::aes -dir decrypt -iv $iv -key $key $encryptedMsg]
puts "'$decryptedMsg'"
```

## License

This project is licensed under the ISC License.

#### Copyright (c) 2020-2023 Pedro F. Albanese - ALBANESE Research Lab.
