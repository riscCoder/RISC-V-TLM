#--------------------------
# MAKE file for SystemC
#
#   Dave Williams/DNE
#   dave.williams.github@gmail.com
#
#-------------------------

include ./makefile.config

SRC		:= ./src
INC		:= ./inc

SOURCES 	:= $(wildcard $(SRC)/*.cpp)
INCLUDES 	:= $(wildcard $(INC)/*.h)

TARGET		:= RiscV_Simulator
TEST        := EternalLoop.hex          #modify for other tests in /tests/asm/

.PHONY: run clean

$(TARGET): $(SOURCES) $(INCLUDES)
	@$(CXX) -ggdb -Wall -Wno-deprecated $(SOURCES) -I$(INC) -I$(SYSTEMC_INC_DIR) -I$(SYSTEMC_INC_DIR)/tlm_core/tlm_2 \
    -L$(SYSTEMC_LIB_DIR) -Wl,-rpath \
	-Wl,$(SYSTEMC_LIB_DIR) -lsystemc -o $@

run:	$(TARGET) 
	./$(TARGET) ./tests/asm/$(TEST)       

	
clean:
	rm -f ./$(TARGET)


