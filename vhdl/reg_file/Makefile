main: tb_toplevel

tb_reg:
	ghdl -a reg_file.vhdl tb_reg_file.vhdl && ghdl -r tb_reg_file --vcd=- | gtkwave -v

tb_toplevel:
	ghdl -a reg_file.vhdl ula.vhdl toplevel.vhdl tb_toplevel.vhdl && ghdl -r tb_toplevel --vcd=- | grep -v warning | gtkwave -v
