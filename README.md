# Fish configs

[![Continuous Integration](https://github.com/Console-Utils/fish-configs/actions/workflows/ci.yml/badge.svg)](https://github.com/Console-Utils/fish-configs/actions/workflows/ci.yml) [![Reddit](https://img.shields.io/badge/Fish%20configs%20suggestions-r%2Ffishshell-brightgreen)](https://www.reddit.com/r/fishshell/comments/qke3i2/fish_configs_suggestions/)

## Description

My `~/.config/fish/config.fish` config and `~/.config/fish/functions/` folder.

## Usage

Modify corresponding `~/.config/fish/config.fish` file and `~/.config/fish/functions/` directory.

There are several environment variables to control how prompt is displayed and how helper functions work:

### General environment variables

- `PROMPT_SUCCESS_SIGN` - specifies string to be displayed when some operation completed successfully
- `PROMPT_WARNING_SIGN` - specifies string to be displayed when some operation completed successfully but with warnings
- `PROMPT_ERROR_SIGN` - specifies string to be displayed when some operation failed

### Abbreviation-specific environment variables

- `PROMPT_ABBR_COMMAND_COLOR` - specifies command color to be diplayed in messages from helper functions
- `PROMPT_ABBR_IDENTIFIER_COLOR` - specifies abbreviation identifier color to be diplayed in messages from helper functions

### Git-specific environment variables

- `PROMPT_GIT_PATH_COLOR` - specifies path color to be diplayed in messages from helper functions
- `PROMPT_GIT_IDENTIFIER_COLOR` - specifies identifier color (branch name for example) to be diplayed in messages from helper functions

### Path-specific environment variables

- `PROMPT_PATH_PATH_COLOR` - specifies everything but `/` color to be displayed in fish prompt
- `PROMPT_PATH_DELIMITER_COLOR` - specifies `/` color to be displayed in fish prompt

### Pipeline-specific environment variables

- `PROMPT_PIPESTATUS_BRACKET_COLOR` - specifies `[` and `]` color to be displayed in fish prompt
- `PROMPT_PIPESTATUS_STATUS_COLOR` - specifies status color to be displayed in fish prompt
- `PROMPT_PIPESTATUS_DELIMITER_COLOR` - specifies `|` color to be displayed in fish prompt

## Screenshots

![image](https://user-images.githubusercontent.com/42812113/139679164-390f9192-3c29-4760-88ed-cebe9af8be06.png)
