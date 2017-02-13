create database if not exists retail;
use retail;

CREATE TABLE IF NOT EXISTS salespeople (
    snum INT NOT NULL,
    sname VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    comm DECIMAL(4 , 2 ) NOT NULL,
    PRIMARY KEY (snum)
);

INSERT INTO salespeople VALUES (1001, 'Peel', 'London', 0.12);
INSERT INTO salespeople VALUES (1002, 'Serres', 'San Jose', 0.13);
INSERT INTO salespeople VALUES (1004, 'Motika', 'London', 0.11);
INSERT INTO salespeople VALUES (1007, 'Rifkin', 'Barcelona', 0.15);
INSERT INTO salespeople VALUES (1003, 'AxelRod', 'New York', 0.10);
INSERT INTO salespeople VALUES (1005, 'Fran', 'London', 0.26);

CREATE TABLE IF NOT EXISTS customer (
    cnum INT NOT NULL,
    cname VARCHAR(30) NOT NULL,
    city VARCHAR(30) NOT NULL,
    rating INT NOT NULL,
    snum INT NOT NULL,
    PRIMARY KEY (cnum),
    FOREIGN KEY (snum)
        REFERENCES salespeople (snum)
);


INSERT INTO customer VALUES (2001, 'Hoffman', 'London',100, 1001);
INSERT INTO customer VALUES (2002, 'giovanni', 'Rome',200, 1003);
INSERT INTO customer VALUES (2003, 'Liu', 'San Jose',200, 1002);
INSERT INTO customer VALUES (2004, 'Grass', 'Berlin',300, 1002);
INSERT INTO customer VALUES (2006, 'Clemens', 'London',100, 1001);
INSERT INTO customer VALUES (2008, 'Cisneros', 'San Jose',300, 1007);
INSERT INTO customer VALUES (2007, 'Pereira', 'Rome',100, 1004);

CREATE TABLE IF NOT EXISTS orders (
    onum INT NOT NULL,
    amt DECIMAL(7 , 2 ) NOT NULL,
    odate DATE NOT NULL,
    cnum INT NOT NULL,
    PRIMARY KEY (onum),
    FOREIGN KEY (cnum)
        REFERENCES customer (cnum)
);
INSERT INTO orders VALUES (3001, 18.69, '1996-03-10', 2008);
INSERT INTO orders VALUES (3003, 767.19, '1996-03-10', 2001);
INSERT INTO orders VALUES (3002, 1900.10, '1996-03-10', 2007);
INSERT INTO orders VALUES (3005, 5160.45, '1996-03-10', 2003);
INSERT INTO orders VALUES (3006, 1098.16, '1996-03-10', 2008);
INSERT INTO orders VALUES (3009, 1713.23, '1996-04-10', 2002);
INSERT INTO orders VALUES (3007, 75.75, '1996-04-10', 2002);
INSERT INTO orders VALUES (3008, 4723.00, '1996-05-10', 2006);
INSERT INTO orders VALUES (3010, 1309.95, '1996-06-10', 2004);
INSERT INTO orders VALUES (3011, 9891.88, '1996-06-10', 2006);

-- Queries from mysql project 


SELECT 
    *
FROM
    salespeople;-- 1

SELECT 
    *
FROM
    customer
WHERE
    rating > 100;-- 2

SELECT 
    *
FROM
    customer
WHERE
    city = NULL;-- 3

SELECT 
    a.onum, a.odate, MAX(a.amt), b.snum
FROM
    orders a,
    customer b
WHERE
    a.cnum = b.cnum
GROUP BY snum , odate;-- 4

SELECT 
    *
FROM
    orders
ORDER BY cnum DESC;-- 5

SELECT DISTINCT
    a.sname, b.onum, c.cname
FROM
    salespeople a,
    customer c,
    orders b
WHERE
    c.cnum = b.cnum AND c.snum = a.snum
GROUP BY a.sname;-- 6

SELECT 
    a.snum, a.sname, b.cname
FROM
    customer b,
    salespeople a
WHERE
    a.snum = b.snum
ORDER BY b.cname;-- 7

SELECT 
    s.snum, s.sname
FROM
    salespeople s
        JOIN
    customer c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.snum) > 1;-- 8

SELECT 
    salespeople.snum, sname, COUNT(onum)
FROM
    salespeople,
    orders,
    customer
WHERE
    orders.cnum = customer.cnum
        AND customer.snum = salespeople.snum
GROUP BY salespeople.snum
ORDER BY COUNT(onum) DESC;-- 9

SELECT 
    *
FROM
    customer
WHERE
    (SELECT 
            COUNT(city)
        FROM
            customer
        WHERE
            city = 'san jose') > 1;-- 10
 
SELECT 
    *
FROM
    customer
WHERE
    (SELECT 
            COUNT(city)
        FROM
            customer
        WHERE
            city = 'san jose') > 1;-- 11

SELECT 
    s.sname, o.onum, MAX(o.amt)
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    s.snum = c.snum AND o.cnum = c.cnum
GROUP BY s.sname
ORDER BY MAX(amt) DESC;-- 12

SELECT 
    cnum, cname
FROM
    customer
WHERE
    city = 'san jose ' AND rating > 200;-- 13

SELECT 
    c.cnum, c.cname
FROM
    customer c
WHERE
    city = 'san jose ' AND rating > 200;-- 14
 
SELECT 
    o.onum, o.amt, o.odate
FROM
    orders o,
    customer c,
    salespeople s
WHERE
    o.cnum = c.cnum AND c.snum = s.snum
        AND sname = 'motika';-- 15

SELECT 
    c.cnum, c.cname
FROM
    orders o,
    customer c
WHERE
    c.cnum = o.cnum
        AND o.odate = '1996-03-10';-- 16

SELECT 
    SUM(amt), odate
FROM
    orders
GROUP BY odate
HAVING SUM(amt) > (SELECT 
        MAX(amt) + 2000
    FROM
        orders);-- 17

SELECT 
    onum, amt
FROM
    orders
WHERE
    amt > (SELECT 
            MIN(amt)
        FROM
            orders
        WHERE
            odate = '1996-06-10');-- 18

SELECT 
    s.snum, s.sname
FROM
    customer c,
    salespeople s
WHERE
    EXISTS( SELECT 
            *
        FROM
            customer)
        AND rating = 300
        AND c.snum = s.snum;-- 19

SELECT 
    *
FROM
    customer
ORDER BY rating DESC;-- 20

SELECT 
    c.cnum, c.cname
FROM
    salespeople s,
    customer c
WHERE
    c.cnum > (SELECT 
            snum + 1000
        FROM
            salespeople
        WHERE
            sname = 'serres')
        AND c.snum = s.snum;-- 21

SELECT 
    comm * 100 AS percent_comm
FROM
    salespeople;-- 22

SELECT 
    s.sname, MAX(amt), o.odate
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    c.cnum = o.cnum AND s.snum = c.snum
GROUP BY o.odate
HAVING MAX(amt) > 3000;-- 23

SELECT 
    s.sname, o.onum, o.odate, MAX(o.amt)
FROM
    customer c,
    orders o,
    salespeople s
WHERE
    o.odate = '1996-03-10'
        AND o.cnum = c.cnum
        AND c.snum = s.snum
GROUP BY o.onum;-- 24

SELECT 
    city, cname
FROM
    customer
WHERE
    city = ANY (SELECT 
            city
        FROM
            customer
        WHERE
            snum = 1002);-- 25

SELECT 
    cnum, cname
FROM
    customer
WHERE
    rating > 200;-- 26

SELECT 
    COUNT(DISTINCT s.snum)
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    c.cnum = o.cnum AND c.snum = s.snum;-- 27

SELECT 
    c.cname, s.comm
FROM
    salespeople s,
    customer c
WHERE
    c.snum = s.snum AND s.comm > 0.12;-- 28

SELECT 
    s.snum, s.sname
FROM
    salespeople s
        JOIN
    customer c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.snum) > 1;-- 29

SELECT 
    c.cname, s.comm
FROM
    salespeople s,
    customer c
WHERE
    c.snum = s.snum AND s.comm > 0.12;-- 30

SELECT 
    *
FROM
    salespeople
WHERE
    sname LIKE 'P%%l';-- 31
    
SELECT 
    o.onum, o.odate
FROM
    customer c,
    orders o
WHERE
    c.cnum = (SELECT 
            cnum
        FROM
            customer
        WHERE
            cname = 'cisneros')
        AND c.cnum = o.cnum;-- 32

SELECT 
    o.onum, MAX(o.amt), s.sname
FROM
    orders o,
    customer c,
    salespeople s
WHERE
    o.cnum = c.cnum AND s.snum = c.snum
        AND s.sname = 'serres'
        OR s.sname = 'rifkin'
GROUP BY s.sname;-- 33

SELECT 
    snum, sname, comm, city
FROM
    salespeople;-- 34

SELECT 
    *
FROM
    customer
WHERE
    cname BETWEEN ('a%') AND ('g%');-- 35

SELECT 
    sname, cname
FROM
    customer,
    salespeople;-- 36

SELECT 
    onum, amt, odate
FROM
    orders
WHERE
    amt > (SELECT 
            AVG(amt)
        FROM
            orders
        WHERE
            odate = '1996-04-10');-- 37

SELECT 
    c.cnum, c.cname
FROM
    customer c
WHERE
    c.rating = ANY (SELECT 
            MAX(c.rating)
        FROM
            customer c
        GROUP BY c.city)
ORDER BY city;-- 38 // may not give correct result try group by ----- having

SELECT 
    SUM(amt), odate
FROM
    orders
GROUP BY odate
ORDER BY SUM(amt) DESC;-- 39

SELECT 
    rating, cname
FROM
    customer
WHERE
    city = 'san jose';-- 40
    
SELECT 
    *
FROM
    orders
WHERE
    amt < (SELECT 
            MIN(amt)
        FROM
            orders,
            customer
        WHERE
            customer.cnum = orders.cnum
                AND city = 'san jose');-- 41 
 
SELECT 
    *
FROM
    orders
WHERE
    amt > ANY (SELECT 
            AVG(amt)
        FROM
            orders
        GROUP BY cnum)
GROUP BY cnum;-- 42 //?? same as 38
 
SELECT 
    MAX(rating), city
FROM
    customer
GROUP BY city;-- 43
 
SELECT 
    o.onum, o.amt * s.comm AS totalcomm, o.odate
FROM
    customer c,
    orders o,
    salespeople s
WHERE
    o.cnum = c.cnum AND s.snum = c.snum
        AND c.rating > 100
ORDER BY totalcomm DESC;-- 44
 
SELECT DISTINCT
    COUNT(cnum)
FROM
    customer
HAVING rating > (SELECT 
        AVG(rating)
    FROM
        customer
    WHERE
        city = 'sanjose');-- 45
 
SELECT 
    *
FROM
    salespeople
WHERE
    city = 'barcelona' OR city = 'london';-- 47
 
SELECT 
    s.snum, s.sname
FROM
    salespeople s
        JOIN
    customer c ON s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(c.snum) = 1;-- 48

SELECT DISTINCT
    *
FROM
    customer a,
    customer b
WHERE
    a.cnum != b.cnum AND a.snum = b.snum
GROUP BY a.cnum;-- 49

SELECT 
    *
FROM
    orders
WHERE
    amt > 1000;-- 50

SELECT 
    o.onum, c.cname, c.cnum
FROM
    orders o,
    customer c
WHERE
    o.cnum = c.cnum;-- 51

SELECT 
    *
FROM
    customer
WHERE
    rating > ANY (SELECT 
            c.rating
        FROM
            customer c,
            salespeople s
        WHERE
            s.snum = c.snum AND s.sname = 'serres');-- 53

SELECT 
    *
FROM
    orders
WHERE
    odate = '1996-03-10'
        OR odate = '1996-04-10';-- 54

SELECT 
    c.cnum, c.cname, o.onum, o.amt
FROM
    orders o,
    customer c
WHERE
    c.cnum = o.cnum
GROUP BY c.cname;-- 55

SELECT 
    *
FROM
    customer
WHERE
    rating > ALL (SELECT 
            rating
        FROM
            customer
        WHERE
            city = 'rome');-- 56

SELECT 
    *
FROM
    customer
WHERE
    rating > 100 OR city = 'rome';-- 57

SELECT 
    *
FROM
    customer
WHERE
    snum = 1001;-- 58

SELECT 
    SUM(o.amt), s.sname, s.snum
FROM
    orders o,
    customer c,
    salespeople s
WHERE
    o.cnum = c.cnum AND s.snum = c.snum
GROUP BY s.sname
HAVING SUM(o.amt) > (SELECT 
        MAX(amt)
    FROM
        orders);-- 59

SELECT 
    *
FROM
    orders
WHERE
    amt = 0 OR amt = NULL;-- 60
    
SELECT 
    cname, sname, rating
FROM
    customer c,
    salespeople s
WHERE
    s.snum = c.snum AND sname < cname
        AND rating < 200;-- 61

SELECT 
    s.sname, SUM(amt) * s.comm AS total_earninggs
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    s.snum = c.snum AND o.cnum = c.cnum
GROUP BY s.snum;-- 62

SELECT 
    cnum, cname, city, rating
FROM
    customer
GROUP BY cname
HAVING rating = (SELECT 
        rating
    FROM
        customer
    WHERE
        cname = 'hoffman');-- 63

SELECT 
    *
FROM
    customer c,
    salespeople s
WHERE
    c.snum = s.snum AND sname > cname;-- 64

SELECT 
    c.cnum, c.cname, c.rating, o.amt
FROM
    customer c
        JOIN
    orders o ON c.cnum = o.cnum
GROUP BY o.amt
HAVING o.amt > (SELECT 
        AVG(amt)
    FROM
        orders);-- 65

SELECT 
    SUM(amt)
FROM
    orders;-- 66

SELECT 
    onum, odate, amt
FROM
    orders;-- 67

SELECT 
    COUNT(rating)
FROM
    customer
WHERE
    rating IS NOT NULL;-- 68

SELECT 
    o.onum, c.cname, s.sname
FROM
    customer c,
    orders o,
    salespeople s
WHERE
    c.cnum = o.cnum AND s.snum = c.snum;-- 69

SELECT 
    s.snum, s.sname, s.comm
FROM
    salespeople s,
    customer c
WHERE
    c.snum = s.snum AND c.city = 'london';-- 70

SELECT 
    s.snum, s.sname, s.city
FROM
    customer c,
    salespeople s
WHERE
    c.snum = s.snum
        AND s.city != ALL (SELECT 
            city
        FROM
            customer);-- 71

SELECT 
    *
FROM
    customer c,
    salespeople s
WHERE
    EXISTS( SELECT 
            *
        FROM
            customer d
        WHERE
            d.snum = s.snum)
        AND c.snum != s.snum
        AND c.city = s.city; -- 72

select c.cnum,c.cname,s.sname from customer c,salespeople s where c.snum=s.snum order by s.sname having c.cname = "peel" or s.sname = "motika";-- 73

SELECT 
    s.sname, COUNT(s.snum)
FROM
    salespeople s,
    customer c,
    orders o
WHERE
    s.snum = c.snum AND o.cnum = c.cnum
GROUP BY s.snum;-- 74

SELECT 
    *
FROM
    orders o,
    salespeople s,
    customer c
WHERE
    c.cnum = o.cnum AND c.snum = s.snum
GROUP BY s.sname
HAVING s.city = 'london';-- 75

SELECT 
    *
FROM
    salespeople s,
    customer c
WHERE
    c.snum = s.snum AND c.city != s.city;-- 76

SELECT 
    s.sname, c.cname
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    c.cnum = o.cnum AND s.snum = c.snum
GROUP BY c.cname
HAVING COUNT(c.cname) > 1;-- 77

SELECT 
    s.sname, c.cname, o.onum
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    c.cnum = o.cnum AND s.snum = c.snum
GROUP BY s.sname
HAVING COUNT(DISTINCT c.cname) > 1;-- 78

SELECT 
    *
FROM
    customer
WHERE
    SUBSTRING(cname, 1, 1) = 'c';-- 79

SELECT 
    city, MAX(rating)
FROM
    customer
GROUP BY city;-- 80

SELECT 
    s.snum
FROM
    salespeople s,
    customer c,
    orders o
WHERE
    s.snum = c.snum AND c.cnum = o.cnum
GROUP BY s.snum;-- 81

SELECT 
    rating, cname, cnum
FROM
    customer
ORDER BY rating DESC;-- 82

SELECT 
    AVG(comm)
FROM
    salespeople
WHERE
    city = 'london';-- 83

SELECT 
    o.onum, o.odate, o.amt
FROM
    customer c,
    orders o,
    salespeople s
WHERE
    o.cnum = c.cnum AND c.snum = s.snum
        AND s.snum = (SELECT 
            snum
        FROM
            customer
        WHERE
            cnum = 2001);-- 84

SELECT 
    *
FROM
    salespeople
WHERE
    comm BETWEEN 0.10 AND 0.12;-- 85

SELECT 
    *
FROM
    salespeople
WHERE
    city = 'london' AND comm > 0.10;-- 86

SELECT 
    *
FROM
    ORDERS
WHERE
    (amt < 1000
        OR NOT (odate = 10 / 03 / 1996 AND cnum > 2003));-- 87

SELECT 
    c.cnum, c.cname, MIN(o.amt)
FROM
    customer c,
    orders o
WHERE
    c.cnum = o.cnum
GROUP BY c.cname;-- 88

SELECT 
    *
FROM
    customer
WHERE
    SUBSTRING(cname, 1, 1) = 'g'
ORDER BY cname ASC
LIMIT 1;-- 89

SELECT 
    COUNT(DISTINCT city)
FROM
    customer
WHERE
    city IS NOT NULL;-- 90

SELECT 
    AVG(amt)
FROM
    orders;-- 91

SELECT 
    *
FROM
    customer
WHERE
    city != 'san jose' AND rating > 200;-- 93

SELECT 
    snum, sname, city
FROM
    salespeople
WHERE
    comm BETWEEN 0.12 AND 0.14;-- 94

SELECT 
    *
FROM
    salespeople s,
    customer c
WHERE
    s.snum = c.snum AND s.city != c.city;-- 96

SELECT 
    *
FROM
    customer c,
    salespeople s
WHERE
    s.snum = c.snum AND rating < 250
        AND comm > 0.11;-- 97

SELECT 
    a.sname, a.comm, b.sname, b.comm
FROM
    salespeople a,
    salespeople b
WHERE
    a.sname != b.sname AND a.city = b.city
        AND a.comm != b.comm;-- 98

SELECT 
    s.sname, SUM(o.amt * s.comm) AS total
FROM
    orders o,
    customer c,
    salespeople s
WHERE
    c.cnum = o.cnum AND s.snum = c.snum
GROUP BY s.snum
ORDER BY total DESC;-- 99

SELECT 
    c.cnum,
    COUNT(*) AS total_count,
    rating,
    (SELECT 
            MAX(rating)
        FROM
            customer)
FROM
    orders o,
    customer c
WHERE
    o.cnum = c.cnum
GROUP BY c.cnum
ORDER BY total_count DESC
LIMIT 1;-- 100

SELECT 
    MAX(c.rating), c.rating, c.cnum, o.amt
FROM
    customer c,
    orders o
WHERE
    o.cnum = c.cnum
        AND o.amt = (SELECT 
            MAX(amt)
        FROM
            orders);-- 101

SELECT 
    *
FROM
    customer
ORDER BY rating DESC;-- 102

SELECT 
    o.odate, c.cname
FROM
    customer c,
    orders o
WHERE
    o.cnum = c.cnum AND c.cname = 'hoffman';-- 103

SELECT 
    comm, sname
FROM
    salespeople;-- 104

SELECT 
    s.sname, o.odate
FROM
    customer c,
    salespeople s,
    orders o
WHERE
    s.snum = c.snum AND c.cnum = o.cnum
        AND o.odate NOT BETWEEN '1996/03/10' AND '1996/05/10';-- 105

SELECT 
    (SELECT 
            COUNT(snum)
        FROM
            salespeople) - COUNT(DISTINCT s.snum)
FROM
    salespeople s,
    customer c,
    orders o
WHERE
    o.cnum = c.cnum AND c.snum = s.snum;-- 106

SELECT 
    COUNT(DISTINCT cnum)
FROM
    orders;-- 107

SELECT 
    odate
FROM
    orders
WHERE
    amt = (SELECT 
            MAX(amt)
        FROM
            orders);-- 108

SELECT 
    s.sname, SUM(s.comm * amt) AS total_comm, MAX(amt)
FROM
    customer c,
    orders o,
    salespeople s
WHERE
    s.snum = c.snum AND c.cnum = o.cnum
GROUP BY s.sname;-- 109 so peel is the most successful salesperson

SELECT DISTINCT
    a.cname, b.cname, a.rating
FROM
    customer a,
    customer b
WHERE
    a.rating = b.rating;-- 112

SELECT 
    *
FROM
    orders
WHERE
    amt > (SELECT 
            AVG(amt)
        FROM
            orders
        WHERE
            odate = '1996-04-10');-- 113

SELECT 
    *
FROM
    customer c,
    orders o
WHERE
    c.cnum = o.cnum
        AND amt > (SELECT 
            AVG(amt)
        FROM
            orders);-- 114

SELECT 
    *
FROM
    customer
WHERE
    rating > (SELECT 
            AVG(rating)
        FROM
            customer
        WHERE
            city = 'san jose');-- 115

SELECT 
    o.onum, o.odate, MAX(o.amt), c.city, s.snum, s.sname
FROM
    orders o,
    salespeople s,
    customer c
WHERE
    c.cnum = o.cnum AND s.snum = c.snum
GROUP BY s.sname;-- 124

SELECT 
    SUM(amt) - (SELECT 
            SUM(s.comm * o.amt) AS profit
        FROM
            customer c,
            orders o,
            salespeople s
        WHERE
            c.cnum = o.cnum AND s.snum = c.snum)
FROM
    orders; -- 125