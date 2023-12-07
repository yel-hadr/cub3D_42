NAME= cub3D
NAMEMAC = cub3D_mac
CC = cc
CFLAGS = -Wextra -Wall -Werror -Wunreachable-code -O3

CFILES = ./src/main.c ./src/parsing/parser.c ./src/parsing/parser_utils.c ./src/rendering/renderer.c \
				./src/rendering/renderer_utils.c ./src/rendering/ft_textures.c ./src/rendering/projection.c ./src/rendering/h_v_check.c \
				./src/parsing/path_checking_utils.c ./src/parsing/string_manip.c ./src/parsing/util_functions.c \
				./src/parsing/file_manip.c ./src/parsing/map_manip.c ./src/rendering/mouvement_hook.c \
				./src/rendering/animation.c ./src/rendering/minimap.c ./src/rendering/raycaster.c \
				./src/rendering/h_v_check_sequel.c

LIBMLX	:= ./MLX42
HEADERS	:= -I ./inc -I $(LIBMLX)/include
CFLAGSLINUX	:= -Iinclude -ldl -lglfw -pthread -lm
CFLAGSMAC := -Iinclude -lglfw -L"/Users/$(USER)/.brew/opt/glfw/lib/" -framework Cocoa -framework OpenGL -framework IOKit -lm
LIBS	:= $(LIBMLX)/build/libmlx42.a

DEPS = ./inc/common.h ./inc/parser.h ./inc/renderer.h

SOURCES = $(CFILES:.c=.o)

LIBFT_DIR = ./libft
LIBFT = ./libft/libft.a

all: $(LIBFT) $(DEPS) $(NAME)

mac: $(LIBFT) $(DEPS) $(NAMEMAC)

libmlx:
	@git submodule update --init --recursive
	@cmake $(LIBMLX) -B $(LIBMLX)/build && make -C $(LIBMLX)/build -j4
	@printf "\033[32m[ ✔ ] libmlx42.a\033[0m\n"


$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR)
	@printf "\033[32m[ ✔ ] libft.a\033[0m\n"

$(NAMEMAC): $(SOURCES) $(DEPS)
	@$(CC) $(CFLAGS) $(SOURCES) $(LIBFT) $(LIBS) $(CFLAGSMAC) $(HEADERS) -o $@
	@printf "\033[32m[ ✔ ] cub3D_mac\033[0m\n"


$(NAME): $(SOURCES) $(DEPS)
	@$(CC) $(CFLAGS) $(SOURCES) $(LIBFT) $(LIBS) $(CFLAGSLINUX) $(HEADERS) -o $@
	@printf "\033[32m[ ✔ ] cub3D\033[0m\n"

src/%.o: src/%.c $(DEPS)
	@$(CC) $(CFLAGS) $< -c -o $@ $(HEADERS)
	@printf "\033[32m[ ✔ ] $@\033[0m\n"

src/parsing/%.o: src/parsing/%.c $(DEPS)
	$(CC) $(CFLAGS) $< -c -o $@
	@printf "\033[32m[ ✔ ] $@\033[0m\n"

src/rendering/%.o: src/rendering/%.c $(DEPS)
	@$(CC) $(CFLAGS) $< -c -o $@
	@printf "\033[32m[ ✔ ] $@\033[0m\n"

clean :
	@$(MAKE) clean -C $(LIBFT_DIR)
	@rm -rf	$(SOURCES)
	@printf "\033[31m[ ✔ ] clean\033[0m\n"

fclean: clean
	@$(MAKE) fclean -C $(LIBFT_DIR)
	@rm -rf $(NAME) $(NAMEMAC)
	@printf "\033[31m[ ✔ ] fclean\033[0m\n"

re : fclean all

.PHONY: all clean fclean re