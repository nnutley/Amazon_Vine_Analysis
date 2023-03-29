-- vine table
CREATE TABLE vine_table (
  review_id TEXT PRIMARY KEY,
  star_rating TEXT,
  helpful_votes INTEGER,
  total_votes INTEGER,
  vine TEXT,
  verified_purchase TEXT
);

SELECT * FROM vine_table;

--table to retrieve rows from where total vote count is equal to or greater than 20
SELECT vt.review_id,
		vt.star_rating,
		vt.helpful_votes,
		vt.total_votes,
		vt.vine,
		vt.verified_purchase
--INTO greater_than_20
FROM vine_table as vt
WHERE total_votes >= 20;

--table to retrieve rows where # of helpful_votes divided by total_votes is equal to or greater than 50
SELECT gt.review_id,
		gt.star_rating,
		gt.helpful_votes,
		gt.total_votes,
		gt.vine,
		gt.verified_purchase
--INTO greater_than_50
FROM greater_than_20 as gt
WHERE CAST(helpful_votes AS FLOAT)/CAST(total_votes AS FLOAT) >=0.5;

--table where review was part of the vine program
SELECT gr.review_id,
		gr.star_rating,
		gr.helpful_votes,
		gr.total_votes,
		gr.vine,
		gr.verified_purchase
--INTO vine_program
FROM greater_than_50 as gr
WHERE vine = 'Y';

--table where review was not part of the vine program
SELECT gr.review_id,
		gr.star_rating,
		gr.helpful_votes,
		gr.total_votes,
		gr.vine,
		gr.verified_purchase
--INTO no_vine_program
FROM greater_than_50 as gr
WHERE vine = 'N';

--table to determine total number of reviews
SELECT COUNT (vt.review_id) AS "Total Reviews"
--INTO total_reviews
FROM vine_table as vt;

--table to determine number of 5-star reviews
SELECT COUNT (vt.star_rating) AS "5-Star Reviews"
--INTO five_star
FROM vine_table as vt
WHERE star_rating = '5';

--table to determine 5-star reviews for vine program (paid)
SELECT vp.review_id,
		vp.star_rating,
		vp.helpful_votes,
		vp.total_votes,
		vp.vine,
		vp.verified_purchase
--INTO vine_program_5_star
FROM vine_program as vp
WHERE vp.star_rating = '5';

--table to determine % of 5-star reviews for vine program(paid)
SELECT COUNT (vp.review_id) AS "Total Paid Reviews",
		COUNT (vt.review_id) AS "Total 5-star Paid Reviews",
		100.0 * COUNT (vt.review_id)/COUNT (vp.review_id) AS "5-Star percentage"
--INTO vine_program_percent
FROM vine_program as vp
LEFT JOIN vine_program_5_star as vt
ON vp.review_id = vt.review_id;

--table to determine 5-star reviews for non-vine program(unpaid)
SELECT vp.review_id,
		vp.star_rating,
		vp.helpful_votes,
		vp.total_votes,
		vp.vine,
		vp.verified_purchase
--INTO no_vine_program_5_star
FROM no_vine_program as vp
WHERE vp.star_rating = '5';

--table to determine % of 5-star reviews for non-vine program(unpaid)
SELECT COUNT (vp.review_id) AS "Total Paid Reviews",
		COUNT (vt.review_id) AS "Total 5-star Paid Reviews",
		100.0 * COUNT (vt.review_id)/COUNT (vp.review_id) AS "5-Star percentage"
--INTO no_vine_program_percent
FROM no_vine_program as vp
LEFT JOIN no_vine_program_5_star as vt
ON vp.review_id = vt.review_id;