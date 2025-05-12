This script exists because I very much love Spectacle, but it cannot copy+save in a single hotkey. I used to use ShareX on Windows and this script exists to mimic the functionality I am used to from there. General flow as follows:

1. Checks for Dependencies
2. Clipboard is copied to allow for Clipboard Verification before saving
3. Spectacle launches in Region mode. You save an image either by clicking "Copy" or hitting Enter. Hitting ESC at this step historically would export a 0-byte png, but with the added Clipboard Verification, the fake-file-export will be blocked.
4. kdotool detects the window under your mouse cursor
5. Converts PID of window under cursor to process name for naming
6. Checks Screenshots directory structure for sorting, creates necessary folders if missing
7. Saves photo (if not-null), to the /Year/Month directory, including the process name and date of capture.

