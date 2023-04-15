display: work-obj93.cf 
	ghdl -r tb --vcd=- | gtkwave -v

work-obj93.cf: tb.vhd porta.vhd
	ghdl -a porta.vhd
	ghdl -a tb.vhd

clean:
	ghdl --clean
