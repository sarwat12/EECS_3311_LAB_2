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
		end

feature -- Tests

	t1: BOOLEAN
		do
			comment ("t1: comment of t1")
			-- Add your own test on heap and scheduler.
		end

	t2: BOOLEAN
		do
			comment ("t2: comment of t2")
			-- Add your own test on heap and scheduler.
		end

	t3: BOOLEAN
		do
			comment ("t3: comment of t3")
			-- Add your own test on heap and scheduler.
		end
end
