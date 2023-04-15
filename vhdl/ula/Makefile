display: work-obj93.cf
	ghdl -r ula_tb --vcd=- | gtkwave -v

work-obj93.cf: ula.vhd ula_tb.vhd
	ghdl -a ula.vhd
	ghdl -a ula_tb.vhd

clean:
	ghdl --clean
