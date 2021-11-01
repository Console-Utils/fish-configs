# Fish configs

[![Continuous Integration](https://github.com/Console-Utils/fish-configs/actions/workflows/ci.yml/badge.svg)](https://github.com/Console-Utils/fish-configs/actions/workflows/ci.yml)

## Description

My `~/.config/fish/config.fish` config and `~/.config/fish/functions/` folder.

## Usage

Modify corresponding `~/.config/fish/config.fish` file and `~/.config/fish/functions/` directory.

There are several environment variables to control how prompt is displayed and how helper functions work:

### General environment variables

- `PROMPT_SUCCESS_SIGN` - specifies string to be displayed when some operation completed successfully
- `PROMPT_WARNING_SIGN` - specifies string to be displayed when some operation completed successfully but with warnings
- `PROMPT_ERROR_SIGN` - specifies string to be displayed when some operation failed

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
