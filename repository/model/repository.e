note
	description: "[
		The REPOSITORY ADT consists of data sets.
		Each data set maps from a key to two data items (which may be of different types).
		There should be no duplicates of keys. 
		However, multiple keys might map to equal data items.
		]"
	author: "Jackie and You"
	date: "$Date$"
	revision: "$Revision$"

-- Advice on completing the contracts:
-- It is strongly recommended (although we do not enforce this in this lab)
-- that you do NOT implement auxiliary/helper queries
-- when writing the assigned pre-/post-conditions.
-- In the final written exam, you will be required to write contracts using (nested) across expressions only.
-- You may want to practice this now!

class
	-- Here the -> means constrained genericity:
	-- client of REPOSITORY may instantiate KEY to any class,
	-- as long as it is a descendant of HASHABLE (i.e., so it can be used as a key in hash table).
	REPOSITORY[KEY -> HASHABLE, DATA1, DATA2]

create
	make

feature {ES_TEST} -- Do not modify this export status!
	-- You are required to implement all repository features using these three attributes.

	-- For any valid index i, a data set is composed of keys[i], data_items_1[i], and data_items_2[keys[i]].
	keys: LINKED_LIST[KEY]
	data_items_1: ARRAY[DATA1]
	data_items_2: HASH_TABLE[DATA2, KEY]

feature -- feature(s) required by ITERABLE
	-- TODO:
	-- See test_iterable_repository and test_iteration_cursor in EXAMPLE_REPOSITORY_TESTS.
	-- As soon as you make the current class iterable,
	-- define the necessary feature(s) here.

feature -- alternative iteration cursor
	-- TODO:
	-- See test_another_cursor in EXAMPLE_REPOSITORY_TESTS.
	-- A feature 'another_cursor' is expected to be defined here.

feature -- Constructor
	make
			-- Initialize an empty repository.
		do
			-- TODO:
			create keys.make
			create data_items_1.make_empty
			create data_items_2.make (1)
		ensure
			empty_repository: -- TODO:
				keys.count = 0 and data_items_1.count = 0 and data_items_2.count = 0

			-- Do not modify the following three postconditions.
			object_equality_for_keys:
				keys.object_comparison
			object_equality_for_data_items_1:
				data_items_1.object_comparison
			object_equality_for_data_items_2:
				data_items_2.object_comparison
		end

feature -- Commands

	check_in (d1: DATA1; d2: DATA2; k: KEY)
			-- Insert a new data set into current repository.
		require
			non_existing_key: -- TODO:
				not exists (k)
		do
			-- TODO:
		ensure
			repository_count_incremented: -- TODO:
				True

			data_set_added: -- TODO:
				-- Hint: At least a data set in the current repository
				-- has its key 'k', data item 1 'd1', and data item 2 'd2'.
				True

			others_unchanged: -- TODO:
				-- Hint: Each data set in the current repository,
				-- if not the same as (`k`, `d1`, `d2`), must also exist in the old repository.
				True
		end

	check_out (k: KEY)
			-- Delete a data set with key `k` from current repository.
		require
			existing_key: -- TODO:
				True
		do
			-- TODO:

		ensure
			repository_count_decremented: -- TODO:
				True

			key_removed: -- TODO:
				True

			others_unchanged:
				-- Hint: Each data set in the old repository,
				-- if not with key `k`, must also exist in the curent repository.
				True
		end

feature -- Queries

	count: INTEGER
			-- Number of data sets in repository.
		do
			-- TODO:
			Result := keys.count
		ensure
			correct_result: -- TODO:
				Result = keys.count and Result = data_items_1.count and Result = data_items_2.count
		end

	exists (k: KEY): BOOLEAN
			-- Does key 'k' exist in the repository?
		do
			-- TODO:
			Result := across 1 |..| keys.count is i some keys.i_th (i) ~ k end
		ensure
			correct_result: -- TODO:
				keys.valid_index (keys.index_of (k, 1))
		end

	matching_keys (d1: DATA1; d2: DATA2): ITERABLE[KEY]
			-- Keys that are associated with data items 'd1' and 'd2'.
		do
			-- TODO:
			Result := keys.new_cursor
		ensure
			result_contains_correct_keys_only: -- TODO:
				-- Hint: Each key in Result has its associated data items 'd1' and 'd2'.
				True

			correct_keys_are_in_result: -- TODO:
				-- Hint: Each data set with data items 'd1' and 'd2' has its key included in Result.
				-- Notice that Result is ITERABLE and does not support the feature 'has',
				-- Use the appropriate across expression instead.
				True
		end

invariant
	unique_keys: -- TODO:
		-- Hint: No two keys are equal to each other.
		across 1 |..| keys.count is i all
			across 1 |..| keys.count is j all (i /= j) implies (keys.i_th (i) /~ keys.i_th (j)) end 
		end

	-- Do not modify the following class invariants.
	implementation_contraint:
		data_items_1.lower = 1

	consistent_keys_data_items_counts:
		keys.count = data_items_1.count
		and
		keys.count = data_items_2.count

	consistent_keys:
		across
			keys is k
		all
			data_items_2.has (k)
		end

	consistent_imp_adt_counts:
		keys.count = count
end
