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

inherit
	ITERABLE[TUPLE[DATA1, DATA2, KEY]]

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
	new_cursor: ITERATION_CURSOR[TUPLE[DATA1, DATA2, KEY]]
	local
		cursor: TUPLE_ITERATION_CURSOR[KEY, DATA1, DATA2]
	do
		create cursor.make(data_items_1, data_items_2, keys)
		Result := cursor
	end

feature -- alternative iteration cursor
	-- TODO:
	-- See test_another_cursor in EXAMPLE_REPOSITORY_TESTS.
	-- A feature 'another_cursor' is expected to be defined here.
	another_cursor: ITERATION_CURSOR[DATA_SET[DATA1, DATA2, KEY]]
	local
		cursor: DATA_SET_ITERATION_CURSOR[DATA1, DATA2, KEY]
	do
		create cursor.make(data_items_1, data_items_2, keys)
		Result := cursor
	end

feature -- Constructor
	make
			-- Initialize an empty repository.
		do
			-- TODO:
			create keys.make
			create data_items_1.make_empty
			create data_items_2.make (10)
			data_items_1.compare_objects
			data_items_2.compare_objects
			keys.compare_objects
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
			data_items_1.force (d1, keys.count + 1)
			keys.extend (k)
			data_items_2.put (d2, k)
		ensure
			repository_count_incremented: -- TODO:
				keys.count = old keys.count + 1
				and data_items_1.count = old data_items_1.count + 1
				and data_items_2.count = old data_items_2.count + 1

			data_set_added: -- TODO:
				-- Hint: At least a data set in the current repository
				-- has its key 'k', data item 1 'd1', and data item 2 'd2'.
				exists (k) and data_items_1[keys.index_of (k, 1)] ~ d1 and data_items_2.at (k) ~ d2

			others_unchanged: -- TODO:
				-- Hint: Each data set in the current repository,
				-- if not the same as (`k`, `d1`, `d2`), must also exist in the old repository.
				across 1 |..| keys.count is i all (keys.i_th (i) /~ k) implies
					(keys.i_th (i) ~ (old keys.deep_twin).i_th (i) and
					data_items_1[i] ~ (old data_items_1.deep_twin)[i] and
					data_items_2.at (keys.i_th (i)) ~ (old data_items_2.deep_twin).at (keys.i_th (i)))
				end
		end

	check_out (k: KEY)
			-- Delete a data set with key `k` from current repository.
		require
			existing_key: -- TODO:
				exists (k)
		local
			i: INTEGER
		do
			-- TODO:
			from
				i := keys.index_of (k, 1) + 1
			until
				i > data_items_1.count
			loop
				data_items_1.force (data_items_1.at (i), i - 1)
				i := i + 1
			end
			data_items_1.remove_tail (1)
			keys.prune (k)
			data_items_2.remove (k)
		ensure
			repository_count_decremented: -- TODO:
				keys.count = old keys.count - 1
				and data_items_1.count = old data_items_1.count - 1
				and data_items_2.count = old data_items_2.count - 1

			key_removed: -- TODO:
				not exists (k) and
				not data_items_1.valid_index (keys.index_of (k, 1)) and
				not data_items_2.has (k)

			others_unchanged:
				-- Hint: Each data set in the old repository,
				-- if not with key `k`, must also exist in the curent repository.
				across keys as j all
				(old keys.deep_twin).has(j.item) and
				(old data_items_1.deep_twin).has (data_items_1.at (keys.index_of (j.item, 1))) and
				(old data_items_2.deep_twin).item (j.item) ~ data_items_2.item (j.item)
				end
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
				keys.has (k)
		end

	matching_keys (d1: DATA1; d2: DATA2): ITERABLE[KEY]
			-- Keys that are associated with data items 'd1' and 'd2'.
		local
			temp: ARRAY[KEY]
		do
			-- TODO:
			create temp.make_empty
			across 1 |..| data_items_1.count is i loop
				if data_items_1[i] ~ d1 then
					temp.force (keys.i_th (i), temp.count + 1)
				end
			end
			Result := temp
		ensure
			result_contains_correct_keys_only: -- TODO:
				-- Hint: Each key in Result has its associated data items 'd1' and 'd2'.
				across Result as i all
					data_items_1.at (keys.index_of (i.item, 1)) ~ d1 and
					data_items_2.at (i.item) ~ d2
				end

			correct_keys_are_in_result: -- TODO:
				-- Hint: Each data set with data items 'd1' and 'd2' has its key included in Result.
				-- Notice that Result is ITERABLE and does not support the feature 'has',
				-- Use the appropriate across expression instead.
				across 1 |..| data_items_1.count is i some
				across Result as j all
				(data_items_1.at (i) ~ d1) implies (keys.i_th (i) ~ j.item) and
				(data_items_2.at (keys.i_th (i)) ~ d2)
				end
				end
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
