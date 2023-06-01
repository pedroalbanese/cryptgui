#!/usr/bin/wish
package require Tk
package require aes

# Create a new window
wm title . "AES-128 Encrypton Tool written in TCL/TK"

# Create plaintext text box
text .plaintextBox -width 80 -height 10
grid .plaintextBox -row 0 -column 0 -columnspan 6 -padx 10 -pady 10

# Create ciphertext text box
text .ciphertextBox -width 80 -height 10
grid .ciphertextBox -row 1 -column 0 -columnspan 6 -padx 10 -pady 10

# Create Key label
label .keyLabel -text "Key:"
grid .keyLabel -row 2 -column 0 -sticky e -padx 10 -pady 5

# Create IV label
label .ivLabel -text "IV:"
grid .ivLabel -row 2 -column 1 -sticky e -padx 10 -pady 5

# Create key input box
entry .keyBox
grid .keyBox -row 2 -column 1 -sticky w -padx 10 -pady 5

# Create IV input box
entry .ivBox
grid .ivBox -row 2 -column 2 -sticky w -padx 10 -pady 5

# Create Encrypt button
button .encryptButton -text "Encrypt" -command {encrypt}
grid .encryptButton -row 2 -column 3 -sticky e -padx 10 -pady 5

# Create Decrypt button
button .decryptButton -text "Decrypt" -command {decrypt}
grid .decryptButton -row 2 -column 4 -sticky e -padx 10 -pady 5

# Function to perform encryption
proc encrypt {} {
    global keyBox ivBox
    set plaintext [.plaintextBox get 1.0 end]
    set key [.keyBox get]
    set iv [.ivBox get]

    # Perform encryption logic here
    set pad [expr {16 - ([string length $plaintext] % 16)}]
    append plaintext [string repeat [format %c $pad] $pad]
    set encryptedMsg [::aes::aes -dir encrypt -iv $iv -key $key $plaintext]

    # Update ciphertext box with the encrypted result
    .ciphertextBox delete 1.0 end
    .ciphertextBox insert 1.0 [binary encode base64 $encryptedMsg]
}

proc removePadding {text} {
    # Find last byte of padding
    set lastByte [expr {[scan [string range $text end-1 end] %c]}]

    # Verify if the padding is valid
    set isValidPadding 1
    for {set i [expr {[string length $text] - $lastByte}]} {$i < [string length $text]} {incr i} {
        if {[scan [string index $text $i] %c] != $lastByte} {
            set isValidPadding 0
            break
        }
    }

    if {$isValidPadding} {
        # Remove the padding
        set text [string range $text 0 [expr {[string length $text] - $lastByte - 1}]]
    }

    return $text
}


# Function to perform decryption
proc decrypt {} {
    global keyBox ivBox
    set ciphertext [.ciphertextBox get 1.0 end]
    set key [.keyBox get]
    set iv [.ivBox get]

    # Perform decryption logic here
    set decryptedMsg [::aes::aes -dir decrypt -iv $iv -key $key [binary decode base64 $ciphertext]]
    set decryptedMsg [removePadding $decryptedMsg]
    set decryptedMsg [string trim $decryptedMsg]

    # Update plaintext box with the decrypted result
    .plaintextBox delete 1.0 end
    .plaintextBox insert 1.0 $decryptedMsg
}

# Start the event loop
tkwait visibility .
