DELIMITER $$
CREATE FUNCTION add_to_col(a INT)  /* this is a funtion name in which me give as many as input parameters within () with there datatype like 									(a int, b int, c int , ....)*/
RETURNS INT			/* it returns some value which me give after the return like returns int, returns varchar(), etc....*/
DETERMINISTIC	/* it always return same result for any kind of input parameter is giving to the function.... */
BEGIN 
	DECLARE b INT;  /* here we declare a local variable b which is works within the function not outside it*/
    SET b = a + 10;
    RETURN b;				/* these 3 lines arw the body of the function */
END $$ 

SELECT add_to_col(6);    /*here function is call the body of function is works and returns b */


SELECT MAX(balance) FROM bd;   /*here we `use` a inbuld `function`  */

SELECT age FROM bd;

SELECT age + 10 as new_age FROM bd;  /* this method is a manual method which is not good to use in a programing lang so we use a user define function called as UDA */

SELECT age, add_to_col(age) as new_age FROM bd;  /*this is done by UDF by simply calling a funtion*/

/* Q2.... Now create a function which will take 2 column input where output is given a 1 single result where it suppose to give me 1st col - 2nd col so it give me a final ouput */

DELIMITER $$
CREATE FUNCTION final_result(a INT, b INT)
RETURNS INT
DETERMINISTIC
BEGIN 
	DECLARE c INT;
    SET c = a - b;
    RETURN c;
END $$ 

SELECT age, balance, final_result(age, balance) FROM bd;
  /* Q3... now taking as 3 input col and creating a function*/
  
DELIMITER $$
CREATE FUNCTION final_result3(a decimal(20,7), b decimal(40,8), x decimal(60,8))
RETURNS INT
DETERMINISTIC
BEGIN 
	DECLARE c decimal(50,5);
    SET c = x - (b*a);
    RETURN c;
END $$   

/*now perform our real calculation using our UDF*/

SELECT age, balance, duration, final_result2(duration,balance,age) FROM bd;

/* Q4... Now i want to convert a datatype suppose convert a integer data into string i.e. varchar datatype... by not using an inbuild function */

DELIMITER $$
CREATE FUNCTION int_to_var(a INT)
RETURNS varchar(50)
DETERMINISTIC
BEGIN 
	DECLARE c varchar(50);
    SET c = a;
    RETURN c;
END $$ 

SELECT *, int_to_var(balance) FROM bd;
SELECT int_to_var(27);




/* if-else using UDF
Here a condition where we find persons ages between..
 	1-30 .. are perfect
    30-50 .. are aged
    50+ .. are over-aged
*/


SELECT * FROM bd;

DELIMITER &&
CREATE FUNCTION mark_age1(age int)
RETURNS varchar(50)
DETERMINISTIC
BEGIN 
DECLARE flag_age varchar(40);
IF age <= 30 THEN 
	SET flag_age = 'perfect';
ELSEIF age > 30 AND age < 50 THEN
	SET flag_age = 'aged';
ELSE
	SET flag_age = 'over-aged';
END IF;
RETURN flag_age;
END &&

SELECT age, mark_age1(age) AS if_else_cond FROM bd;

SELECT mark_age1(34);


/*how to update the funtions ? Ans =  just click on the funtion name and a routines panel is on and edit the things and then click to go.. */


/*Difference btw procedures and functions ,...
 ----In case of Procedures we have written ..  complete sql statments over their inside the sql.
----  Procedures returns queries .. i.e. querY OUTCOME .
---But Functions behave like an action
  	whenever i have to perform saome action on some of data in terms of 
  1. Data Manipulation
  2. Data Conversion operation
or any kind of operations related to string , integer, add, sub or any primitive operation.
--- Funtions returns a value all the time.
*/


/*Now we will know about the loops in sql..*/


CREATE TABLE loop_table(a INT);		/*this loop is going to give a data but we have to hold this data as well so we create a table... */

DELIMITER $$						/* When i want to insert our data all time which is a part of loop in a table in case try to create procedures. */
CREATE PROCEDURE insert_data() 
BEGIN
SET @i = 10;   			 			/* here we intilize the global variable */
loop_name : LOOP		 			/* here loop name is defined */
INSERT INTO loop_table VALUES(@i);	/*Table is creted, Now we have to Insert the data which we created in our loop..*/
SET @i = @i + 1;	  				/*here increment condition is giving*/
IF @i = 100 THEN  	 				/* condtion is giving in body of loop*/
	LEAVE loop_name;				/* leave loop body when if condtion is true ...*/
END IF;            					/*stop if condtion */
END LOOP loop_name; 				/*stop loop*/
END $$

CALL insert_data;  

SELECT * FROM loop_table;


