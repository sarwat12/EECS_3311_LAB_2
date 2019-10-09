note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR[KEY, DATA1, DATA2]

inherit
	ITERATION_CURSOR[TUPLE[DATA1, DATA2, KEY]]

create
	make

feature
	make
	do

	end

feature
	item: TUPLE[DATA1, DATA2, KEY]
	do
		
	end

	after: BOOLEAN
	do

	end

	forth
	do

	end
end
