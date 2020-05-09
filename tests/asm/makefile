#-------------------------------------------------------------------------------- 					
#	makefile 					
#											
#	- assemble								
#	- link with linker script file						
#	- create output list file for inspection and debug			
#	- create Verilog memories for simualation and FPGA loading	
#									
#					
#-------------------------------------------------------------------------------


include makefile.config

.PHONY: read

# targets
all: list_file rom_file


# dependencies
list_file: $(OUT_LST)

rom_file: $(OUTPUT_PATH)/initial.rom


$(OUT_LST): a.out
	@echo "create list file"
	@$(OBJDUMP) -h -l -S -d -M numeric,no-aliases -EL $^ > $@			#create output list file .text only	
	@$(OBJDUMP) -s -j .data $^ > output/data.txt					#create output list file .data only
	@cat output/$(TARGET_NAME).lst output/data.txt > $(TARGET_NAME).lst
	@echo " " >> $(TARGET_NAME).lst
	@sed '/a.out/d' $(TARGET_NAME).lst > output/$(TARGET_NAME).lst
	@rm -f ./$(TARGET_NAME).lst								# rm file after moving
	
a.out : $(OBJS)
	@echo "link"
	@$(LINK) $(LINK_SCRIPT) $^             						#link


$(OBJS):$(ASM_SOURCES)
	@echo "assemble"
	@$(ASM) -L --fatal-warnings asm_options_file $^ -o $@					#assemble
	
$(OUTPUT_PATH)/initial.rom: $(OUT_LST)
	@echo "create Verilog 32bit memories and ROMs"
	@$(OBJCOPY) -O verilog a.out $(OUTPUT_PATH)/initial.rom				#convert to Verilog memory format
	@cat $(OUTPUT_PATH)/initial.rom ./src/sentinel > $(OUTPUT_PATH)/next.rom	#add sentinel 
	@$(SCRIPT_PROCESS) $(OUTPUT_PATH)/next.rom					#create verilog memories w/ C++ 
	@mv ./imemory.* ./output							#move to output dir
	@mv ./dmemory.* ./output
	@mv $(OUTPUT_PATH)/imemory.coe $(OUTPUT_PATH)/FPGA
	@mv $(OUTPUT_PATH)/imemory.mif $(OUTPUT_PATH)/FPGA
	#@rm -f $(OUTPUT_PATH)/initial.rom	
	#@rm -f $(OUTPUT_PATH)/next.rom
	#@rm -f $(OUTPUT_PATH)/data.txt

readELF:
	@$(READELF) -R .text ./a.out
	#@cp  ./imemory.rom ${TEST_CODE}/imemory.rom					#copy to Verilog directories
	#@cp ./dmemory.init  ${TEST_CODE}/dmemory.init                              
	#@#@cp ./dmemory.init  ${SYSC_DIR}/dmemory.init					#copy to SystemC directories
	#@#@cp ./imemory.rom   ${SYSC_DIR}/imemory.rom
	

clean:
	rm -f ./*.out
	touch $(ASM_SOURCES)
	@rm -f $(OUTPUT_PATH)/initial.rom
	@rm -f $(OUTPUT_PATH)/next.rom
	
print-%: ; @echo  $* = $($*)
