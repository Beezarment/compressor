##
## EPITECH PROJECT, 2025
## Image_compressor
## File description:
## Makefile
##

NAME	=	imageCompressor

BUILD_DIR = $(shell stack path --local-install-root)/bin

OUTPUT_DIR = .

all: $(NAME)

$(NAME):
		stack build
		cp $(BUILD_DIR)/$(NAME) $(OUTPUT_DIR)/$(NAME)

clean:
	stack clean

fclean: clean
	rm -f $(OUTPUT_DIR)/$(NAME)

re: fclean all

.PHONY: all clean fclean re