# Created       : 2013 Nov 04 (Mon) 08:16:13 by carr.
# Last Modified : 2014 Jan 02 (Thu) 13:34:32 by Harold Carr.

configure : FORCE
	runghc Setup configure

build : FORCE
	runghc Setup build

install : FORCE
	runghc Setup install

FORCE :

# End of file.
