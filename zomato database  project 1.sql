USE zomato_database ;
CREATE TABLE goldusers_signup(
userid integer,
gold_signup_date date
); 
INSERT INTO goldusers_signup(userid,gold_signup_date) 
VALUES (1,'2017-09-22'),(3,'2017-04-21');

CREATE TABLE users(userid integer,signup_date date); 

INSERT INTO users(userid,signup_date) 
VALUES (1,'2014-09-02'),
(2,'2015-01-15'),
(3,'2014-04-11');

CREATE TABLE sales(userid integer,created_date date,product_id integer); 

INSERT INTO sales(userid,created_date,product_id) 
VALUES (1,'2017-04-19',2),
(3,'2019-12-18',1),
(2,'2020-07-20',3),
(1,'2019-10-23',2),
(1,'2018-03-19',3),
(3,'2016-12-20',2),
(1,'2016-11-09',1),
(1,'2016-05-20',3),
(2,'2017-09-24',1),
(1,'2017-03-11',2),
(1,'2016-03-11',1),
(3,'2016-11-10',1),
(3,'2017-12-07',2),
(3,'2016-12-15',2),
(2,'2017-11-08',2),
(2,'2018-09-10',3);

CREATE TABLE product(product_id integer,product_name text,price integer); 

INSERT INTO product(product_id,product_name,price) 
 VALUES
(1,'p1',980),
(2,'p2',870),
(3,'p3',330);

select * from sales;
select * from product;
select * from goldusers_signup;
select * from users;

1. what is the total amount of each customer spent on zomato?

select a.userid,a.product_id,b.price from sales a inner join product b on a.product_id=b.product_id
  to get the sum
  select a.userid,sum(b.price) total_amt_spent from sales a inner join product b on a.product_id=b.product_id
  group by a.userid
  
2. how many days each customer has visited zomato?
select userid, count(distinct created_date) distinct_days from sales 
group by userid;

3. what was the first product purchased by each customer?
select* ,rank() over(partition by userid order by created_date) rnk from sales
select* from
(select* ,rank() over(partition by userid order by created_date) rnk from sales) a where rnk = 1 

4. what is the most purchased item on the menu and how mny items it was purchased by all customers?
select product_id, count(product_id) cnt from sales group by product_id order by count(product_id) desc
select product_id, count(product_id) cnt from sales group by product_id order by count(product_id) desc limit 1
    
    to get the product id which is purchased the most number of time

select product_id from sales group by product_id order by count(product_id) desc limit 1
     to get how many times
 
select userid,count(product_id) cnt from sales where product_id =
(select product_id from sales group by product_id order by count(product_id) desc limit 1)
group by userid;

5. which item is most popular?
select * from sales
select userid,product_id, count(product_id) from sales group by userid,product_id;

select * from
(select *, rank() over(partition by userid order by cnt desc) rnk from
(select userid,product_id, count(product_id) cnt from sales group by userid,product_id)a)b
where rnk=1


