# Created       : 2013 Nov 04 (Mon) 08:16:13 by carr.
# Last Modified : 2013 Nov 04 (Mon) 19:44:52 by carr.

configure : FORCE
	runghc Setup configure

build : FORCE
	runghc Setup build

install : FORCE
	sudo runghc Setup install

FORCE :

# End of file.
