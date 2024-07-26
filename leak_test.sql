/* DATA LEAK CHECKER for TESTING REFACTORED SQL

   this only works with one working dataset and an experimental refactor
   it will flag missing or leaking values in the new refactor
   if it returns no rows, it means the refator does not leak or miss data

   CAVEATS
   it does not benchmark performance. that will need to be measured another way.
   it probably doesn't work on ISERT UPDATE or DELETE statements
  (and it probably wouldn't work idempotently without something to restore the changes)
   it probably doesn't work on CREATE statements either

   Have a lot of fun!
 */

WITH known_good AS
         (), --old statement goes here
     refactor AS
         (), --trial statement goes here
     diff_left AS
         (SELECT * FROM known_good
          EXCEPT
          SELECT * FROM refactor),
     diff_right AS
         (SELECT * FROM refactor
          EXCEPT
          SELECT * FROM known_good)
SELECT 'missing', * FROM diff_left
UNION ALL
SELECT 'leaking', * FROM diff_right
-- ORDER BY -- any column you think will help
