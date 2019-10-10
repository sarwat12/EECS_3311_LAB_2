note
	description: "Tests created by student"
	author: "You"
	date: "$Date$"
	revision: "$Revision$"

class
	STUDENT_TESTS

inherit
	ES_TEST

create
	make

feature -- Add tests

	make
		do
			add_boolean_case (agent t1)
			add_boolean_case (agent t2)
			add_boolean_case (agent t3)
			add_boolean_case (agent t4)
			add_boolean_case (agent t5)
			add_boolean_case (agent t6)
			add_boolean_case (agent t7)
			add_boolean_case (agent t8)
			add_boolean_case (agent t9)
			add_boolean_case (agent t10)
		end

feature -- Tests

	t1: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t1: Testing REPOSITORY constructor.")
			-- Add your own test on heap and scheduler.
			create r.make
			Result := r.count = 0
		end

	t2: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t2: Testing REPOSITORY check in feature")
			-- Add your own test on heap and scheduler.
			create r.make
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			Result := r.count = 1
		end

	t3: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t3: Testing REPOSITORY exists feature")
			-- Add your own test on heap and scheduler.
			create r.make
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			Result := r.exists (3311)
		end

	t4: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t4: Testing REPOSITORY check out feature")
			-- Add your own test on heap and scheduler.
			create r.make
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			r.check_out (3311)
			Result := r.count = 0 and not r.keys.has (3311)
		end

	t5: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t5: Testing REPOSITORY additions")
			-- Add your own test on heap and scheduler.
			create r.make
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			r.check_in ("DATA", "STRUCTURES", 2011)
			r.check_in ("SOFTWARE", "TOOLS", 2031)
			Result := r.count = 3
		end

	t6: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
		do
			comment ("t6: Testing REPOSITORY deletions")
			-- Add your own test on heap and scheduler.
			create r.make
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			r.check_in ("DATA", "STRUCTURES", 2011)
			r.check_in ("SOFTWARE", "TOOLS", 2031)
			r.check_out (2031)
			Result := r.count = 2
		end

	t7: BOOLEAN
		local
			r: REPOSITORY[INTEGER, STRING, STRING]
			d: DATA_SET[STRING, STRING, INTEGER]
		do
			comment ("t7: Testing REPOSITORY and DATA_SET")
			-- Add your own test on heap and scheduler.
			create r.make
			create d.make ("SOFTWARE", "DESIGN", 3311)
			r.check_in ("SOFTWARE", "DESIGN", 3311)
			r.check_in ("DATA", "STRUCTURES", 2011)
			r.check_in ("SOFTWARE", "TOOLS", 2031)
			Result := r.count = 3 and d.key ~ 3311
		end

	t8: BOOLEAN
		local
			r: DATA_SET[STRING, STRING, INTEGER]
		do
			comment ("t8: Testing DATA_SET constructor assignments.")
			-- Add your own test on heap and scheduler.
			create r.make ("SOFTWARE", "DESIGN", 3311)
			Result := r.data_item_1 ~ "SOFTWARE" and r.data_item_2 ~ "DESIGN" and r.key ~ 3311
		end

	t9: BOOLEAN
		local
			s, d: DATA_SET[STRING, STRING, INTEGER]
		do
			comment ("t9: Testing DATA_SET not equality feature.")
			-- Add your own test on heap and scheduler.
			create s.make ("DATA", "STRUCTURES", 2011)
			create d.make ("SOFTWARE", "DESIGN", 3311)
			Result := not d.is_equal (s)
		end

	t10: BOOLEAN
		local
			s, d: DATA_SET[STRING, STRING, INTEGER]
		do
			comment ("t10: Testing DATA_SET equality feature.")
			-- Add your own test on heap and scheduler.
			create s.make ("SOFTWARE", "DESIGN", 3311)
			create d.make ("SOFTWARE", "DESIGN", 3311)
			Result := d.is_equal (s)
		end
end
