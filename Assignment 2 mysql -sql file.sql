SELECT first_name,last_name,job_id FROM employees where first_name like 's%';
SELECT * FROM employees where salary=(select max(salary) from employees);
SELECT first_name, salary FROM employees WHERE salary < (SELECT MAX(salary) FROM employees) ORDER BY salary DESC LIMIT 1;
Select first_name,last_name,salary,manager_id from employees order by manager_id;
select first_name,last_name from employees where first_name like '%AN%';
SELECT department_id, COUNT(*) FROM employees GROUP BY department_id; 
select year(hire_date),count(employee_id) 
from employees
group by year(hire_date);
SELECT * FROM employees WHERE hire_date between '1994-08-01 ' and '1994-08-31 ';

delimiter $$
 
CREATE PROCEDURE pr_empcount(IN yr VARCHAR(255), OUT cnt INT)
BEGIN
    SELECT COUNT(*) INTO cnt FROM employees
    WHERE year(hire_date)  = yr;
END $$
delimiter ;
call pr_empcount('1994',@cnt);
select @cnt;


 SELECT first_name,hire_date FROM employees WHERE day(hire_date)>15 ;
 
 
 
    
    
select concat(m.first_name,' ',m.last_name) as 'manager' ,concat(e.first_name,' ',e.last_name) as 'reporting', 
e.salary from employees e inner join employees m on m.manager_id=e.Employee_id;
    
    
    
    
create view mngr1 as
select m.manager_id as m_id,concat(m.first_name,' ',m.last_name) as 'Manager' ,e.Employee_id as e_id,concat(e.first_name,' ',e.last_name) as 'reporting', 
e.salary from employees e inner join employees m on m.manager_id=e.Employee_id;
    
select * from mngr1;
SELECT m_id,COUNT(m_id) as cnt FROM mngr1 GROUP BY m_id ORDER BY count(m_id) DESC; 



SELECT department_id, MAX(SALARY) FROM employees GROUP BY department_id;

SELECT * FROM employees e WHERE 5 >(SELECT COUNT(*) FROM employees WHERE e.salary > salary) ;

select first_name,concat('(',substring(phone_number,1,3),')-(',substring(phone_number,5,3),')-(',substring(phone_number,9,3),')') as Contact_Number from employees order by first_name asc;