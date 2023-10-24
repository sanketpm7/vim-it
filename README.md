## Vim Keys

#### md Template
| key   | What it does          |
|-------|-----------------------|
|       |                       |

### Scrolling
| key    | What it does                         |
|--------|--------------------------------------|
| zz     | make line scroll to middle of screen |
| zt     | make line scroll to top of screen    |
| zb     | make line scroll to bottom of screen |
| ctrl-e | scroll one line down                 |
| ctrl-y | scroll one line up                   |
| H      | Scroll to Top                        |
| M      | Scroll to middle                     |
| L      | Scroll to Bottom                     |

### Modes

| key            | What it does                     |
|----------------|----------------------------------|
| esc            | normal mode (shortcut mode)      |
| i              | Insert Mode (Typing mod)         |
| esc-v, ctrl +V | visual mode (copy-paste modes)   |
| esc:           | command mode (terminal mode)     |


### Save & Exit

| key   | What it does                                   |
|-------|------------------------------------------------|
| :w    | Write file & don't quit                        |
| :wq   | Write & quit                                   |
| :q    | Quit                                           |
| :q!   | Force quit (quit dicarding all changes made)   |


### Delete

| key   | What it does                                   |
|-------|------------------------------------------------|
| x     | Delete the character cursor is on              |
| dw    | Delete word (cursor on first char of word)     |
| db    | Delete previous word                           |
| daw   | delete around word.                            |
| diw   | delete internal                                |
| `di(` | Delete within brackets                         |
| `da(` | Delete with brackts                            |
| dd    | Delete line                                    |
| d$    | Delete till the end of the line                |
| `d} ` | Delete till the next para                      |
| `d{ ` | Delete till the previous para                  |
|  D    | Delete to the end of the line                  |

> I use: `c` instead of `d` most of the time, since c -> deletes the word & puts the cursor in spot.