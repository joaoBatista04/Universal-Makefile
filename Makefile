#DEFINE VARIABLES - TRY TO CHANGE THE NAME OF THE EXECUTABLE!
EXECUTABLE       = main
SRC              = ./src
INCLUDE          = ./include
OBJ              = ./obj
FLAGS            = -lm -pedantic -Wall -g
ADD_FLAGS        = -Wextra -O2
TERMINAL_TIME    = 1

#PATH AND EXTENSIONS
C_FILES        = $(wildcard $(SRC)/**/*$(EXTENSION) | $(SRC)/*$(EXTENSION))
C_PATHS		   = $(wildcard $(SRC)/ | $(SRC)/**/)
OBJ_PATH_FILES = $(patsubst $(SRC)%,$(OBJ)%,$(C_FILES))
OBJ_FILES      = $(patsubst %$(EXTENSION),%.o,$(OBJ_PATH_FILES))
OBJ_FOLDERS    = $(patsubst $(SRC)%, $(OBJ)%, $(C_PATHS))

#COLORS
YELLOW = "\033[1;33m"
RED = "\033[1;31m" 
CYAN = "\033[1;36m"
PURPLE = "\033[1;35m"
RESET_COLOR = "\033[0m"

#===========================================================#

#TEST THE FORMAT OF THE MAIN FILE AND DECIDE WHICH COMPILER WILL BE USED
FILE_FORMAT=$(suffix $(shell file [m-n]*))
C_OPTION=.c:
CPP_OPTION=.cpp:

ifeq ($(FILE_FORMAT), $(C_OPTION))
COMPILER=gcc
MAIN=main.c
EXTENSION=.c
else ifeq ($(FILE_FORMAT), $(CPP_OPTION))
COMPILER=g++
MAIN=main.cpp
EXTENSION=.cpp
else
COMPILER=gcc
endif

#============================================================================

#MAIN TARGET
all: clean file_testing obj_create copy_main $(OBJ_FILES) $(EXECUTABLE)

#KILL THE MAKE PROCESS IF THE MAIN DOESN'T CONTAIN .C OR .CPP EXTENSION
file_testing:
ifeq ($(COMPILER), none)
	@echo $(RED)Not found a main file with .c or .cpp extension!
	@echo $(RESET_COLOR)
	@-pkill make
endif

#REMOVE OBJ FOLDER IF IT EXISTS AND CREATE A NEW ONE
obj_create:
	@echo $(CYAN)CREATING A OBJ FOLDER
	@rm -rf obj
	@mkdir $(OBJ_FOLDERS)
	@echo $(CYAN)FOLDER CREATION COMPLETE!
	@sleep $(TERMINAL_TIME)
	@echo

#MOVING THE MAIN FILE FROM MAIN FOLDER TO SRC FOLDER
copy_main: $(OBJ_FILES)
	@cp -f $(MAIN) $(SRC)
	@sleep $(TERMINAL_TIME)
	
#COMPILING FILES TO .O EXTENSION
$(OBJ)/%.o: $(SRC)/%$(EXTENSION)
	@echo $(RED)GENERATING OBJECT FILES...
	@$(COMPILER) -c $< -o $@ $(FLAGS)
	@echo $(RED)OBJECT FILES GENERATION DONE!
	@echo $(RESET_COLOR)
	@sleep $(TERMINAL_TIME)

#GENERATING OBJECT FILE TO MAIN
main.o: $(OBJ_FILES)
	@echo $(PURPLE)GENERATING MAIN.O...
	@$(COMPILER) -c -o ./obj/main.o $(SRC)/$(MAIN) $(FLAGS)
	@echo $(PURPLE)MAIN OBJECT GENERATING DONE!


#CREATING THE EXECUTABLE
$(EXECUTABLE): main.o
	@echo $(YELLOW)
	@echo "CREATING THE EXECUTABLE..."
	@$(COMPILER)  $(OBJ_FILES) -o $@ $(FLAGS)
	@echo $(RESET_COLOR)

#CLEANING WORKSPACE
clean:
	@sleep $(TERMINAL_TIME)
	@echo $(RED)
	@echo "CLEANING WORKSPACE..."
	@rm -rf $(OBJ) $(EXECUTABLE)
	@echo $(RESET_COLOR)
	@sleep $(TERMINAL_TIME)