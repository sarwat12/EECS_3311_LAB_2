note
	description: "Summary description for {TUPLE_ITERATION_CURSOR}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_ITERATION_CURSOR[KEY -> HASHABLE, DATA1, DATA2]

inherit
	ITERATION_CURSOR[TUPLE[DATA1, DATA2, KEY]]

create --Constructor
	make

feature  --Constructor Implementation
	make(item1: ARRAY[DATA1]; item2: HASH_TABLE[DATA2, KEY]; k: LINKED_LIST[KEY])
	do
		d1:= item1
		d2 := item2
		key := k
		cursor_position := d1.lower
	end

feature {NONE} --Private Features
	cursor_position: INTEGER
	d1: ARRAY[DATA1]
	d2: HASH_TABLE[DATA2, KEY]
	key: LINKED_LIST[KEY]

feature --Implementing deffered features
	item: TUPLE[DATA1, DATA2, KEY]
	local
		dat1: DATA1
		dat2: DATA2
		k: KEY
	do
		k := key.i_th (cursor_position)
		dat1 := d1.item (cursor_position)
		dat2 := d2.at (k)
		check
			attached dat2 as s
			then
			create Result
			Result := [dat1, s, k]
		end
	end

	after: BOOLEAN
	do
		Result := cursor_position > d1.upper
	end

	forth
	do
		cursor_position := cursor_position + 1
	end
end
