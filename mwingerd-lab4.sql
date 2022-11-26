-- Lab 4
-- mwingerd
-- Oct 24, 2022

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
SELECT FirstName, LastName FROM list WHERE classroom = '111' ORDER BY LastName;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
SELECT DISTINCT Classroom, Grade From list ORDER BY Classroom DESC;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
SELECT 
    DISTINCT First, Last, teachers.Classroom 
FROM 
    teachers 
CROSS JOIN 
    list 
WHERE 
    teachers.Classroom = list.Classroom AND Grade = 5
ORDER BY
    teachers.Classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
SELECT DISTINCT 
    FirstName, LastName 
FROM 
    list 
CROSS JOIN 
    teachers 
WHERE 
    First = 'OTHA' AND Last = 'MOYER' AND list.Classroom = teachers.Classroom
ORDER BY
    LastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Output teacher last name, first name, and grade. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
SELECT DISTINCT
    Last, First, Grade
FROM
    list
CROSS JOIN
    teachers
WHERE
    Grade >= 0 AND Grade <= 3 AND list.Classroom = teachers.Classroom
ORDER BY
    Grade, Last;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
SELECT
    Flavor, Food, Price
FROM
    goods
WHERE
    Price < 5 AND Flavor = 'Chocolate'
ORDER BY
    Price DESC;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
SELECT 
    Flavor, Food, Price
FROM
    goods
WHERE
    (Food = 'Cookie' AND Price >= 1.1) 
    OR 
    (Flavor = 'Lemon')
    OR
    (Flavor = 'Apple' AND Food != 'Pie')
ORDER BY
    Flavor, Food;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
SELECT DISTINCT
    LastName, FirstName
FROM
    customers
CROSS JOIN
    receipts
WHERE
    CId = Customer AND SaleDate = '2007-10-3'
ORDER BY
    LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
SELECT DISTINCT
    Flavor, Food
FROM
    goods
CROSS JOIN
    receipts
CROSS JOIN
    items
WHERE
        SaleDate = '2007-10-4' 
    AND 
        Food = 'Cake' 
    AND 
        Item = GId
    AND 
        RNumber = Receipt
ORDER BY
    Flavor;


USE `BAKERY`;
-- BAKERY-5
-- List all pastries purchased by ARIANE CRUZEN on October 25, 2007. For each pastry, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each pastry needs to appear the number of times it was purchased).
SELECT
    Flavor, Food, Price
FROM
    customers
CROSS JOIN
    receipts
CROSS JOIN
    goods
CROSS JOIN
    items
WHERE
        FirstName = 'ARIANE' 
    AND 
        LASTNAME = 'CRUZEN' 
    AND 
        SaleDate = '2007-10-25'
    AND
        CId = Customer
    AND
        Receipt = RNumber
    AND Item = GId;


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

SELECT DISTINCT
    Flavor, Food
FROM
    customers
CROSS JOIN
    goods
CROSS JOIN
    receipts
CROSS JOIN
    items
WHERE
        LastName = 'ARNN'
    AND
        FirstName = 'KIP'
    AND 
        CId = Customer
    AND
        SaleDate >= '2007-10-1' AND SaleDate <= '2007-10-31'
    AND
        RNumber = Receipt
    AND 
        GId = Item
    AND 
        Food = 'Cookie'
ORDER BY
    Flavor;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
SELECT
    Campus
FROM
    campuses
WHERE
    County = 'Los Angeles'
ORDER By
    Campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
SELECT 
    degrees.Year, degrees
FROM 
    campuses, degrees
WHERE
        Id = CampusId
    AND
        Campus = 'California Maritime Academy'
    AND
        degrees.Year >= 1994 AND degrees.Year <= 2000
ORDER BY
    degrees.year;


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
SELECT 
    Campus, Name, Gr, Ug 
FROM 
    disciplines, discEnr, campuses
WHERE
        Discipline = disciplines.Id
    AND
        (Name = 'Mathematics'
    OR  
        Name = 'Engineering'
    OR
        Name = 'Computer and Info. Sciences')
    AND
        campuses.Id = CampusId
    AND
        (Campus = 'California Polytechnic State University-San Luis Obispo'
    OR
        Campus = 'California State Polytechnic University-Pomona')
    AND
        discEnr.Year = 2004
ORDER BY
    Campus, name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
SELECT DISTINCT
    campus, Agriculture, Biology
FROM
    disciplines,
    (SELECT CampusId, Discipline, Year, Gr as Agriculture From discEnr)discEnr,
    (SELECT
        campus AS campus1, Biology
    FROM
        disciplines, (SELECT CampusId, Discipline, Year, Gr as Biology From discEnr)discEnr, campuses
    WHERE
        disciplines.Id = Discipline
    AND
        Name = 'Biological Sciences'
    AND 
        campuses.Id = CampusId
    AND
        discEnr.Year = 2004
    AND
        Biology > 0) biology,
    campuses
WHERE
        disciplines.Id = Discipline
    AND
        Name = 'Agriculture'
    AND 
        campuses.Id = CampusId
    AND
        discEnr.Year = 2004
    AND
        Agriculture > 0
    AND 
        campus1 = campus
ORDER BY
    Agriculture DESC;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
SELECT
    Campus, Name, Ug, Gr
FROM
    campuses, discEnr, disciplines
WHERE
        disciplines.Id = Discipline
    AND
        CampusId = campuses.Id
    AND
        discEnr.Year = 2004
    AND
        Gr >= (Ug * 3)
ORDER BY
    Campus, Name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
SELECT 
    fees.year, enrollments.FTE * fee AS COLLECTED, ROUND((enrollments.FTE * fee) / faculty.FTE, 2) AS 'PER FACULTY'
FROM
    fees
JOIN
    campuses ON fees.CampusId = Id
JOIN
    faculty ON faculty.CampusId = Id AND faculty.year = fees.year
JOIN
    enrollments ON enrollments.year = fees.year AND enrollments.CampusId = Id
WHERE
        Campus = 'Fresno State University'
    AND
        fees.Year >= 2002 AND fees.Year <= 2004;


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
SELECT
    t2.Campus,
    STUDENTS,
    Faculty,
    ROUND(STUDENTS / Faculty, 1) AS RATIO 
FROM
    (SELECT 
        FTE 
    FROM 
        campuses 
    JOIN
        enrollments ON CampusId = Id
    WHERE 
        enrollments.year = 2003
    AND 
        Campus = 'San Jose State University') t1
JOIN 
    (SELECT 
        Campus,
        enrollments.FTE AS Students,
        faculty.FTE AS Faculty 
    FROM 
        campuses 
    JOIN
        enrollments ON enrollments.CampusId = Id
    JOIN 
        faculty ON faculty.CampusId = Id AND faculty.year = 2003
    WHERE 
            enrollments.year = 2003
        AND 
            Campus <> 'San Jose State University' ) t2
ON 
    t2.STUDENTS > t1.FTE
ORDER BY 
    RATIO;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
SELECT
    RoomCode, RoomName
FROM
    rooms
WHERE
        basePrice < 160
    AND
        beds = 2
    AND
        decor = 'modern'
ORDER BY
    RoomCode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
SELECT
    Lastname,
    CheckIn,
    CheckOut,
    Adults + Kids AS Gusts,
    Rate
FROM
    reservations
JOIN
    rooms ON Room = RoomCode
WHERE
        CheckIn >= '2010-7-1' AND CheckIn <= '2010-7-31'
    AND
        RoomName = 'Convoke and sanguine'
ORDER BY
    CheckIn;


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
SELECT
    RoomName, CheckIn, CheckOut
FROM
    rooms
JOIN
    reservations ON Room = RoomCode
WHERE
    CheckIn <= '2010-02-06' AND CheckOut > '2010-02-06'
ORDER BY
    RoomName;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

SELECT 
    CODE, RoomName, CheckIn, CheckOut, DATEDIFF(CheckOut, CheckIn) * Rate AS PAID
FROM
    rooms
JOIN
    reservations ON Room = RoomCode
WHERE
    FirstName = 'GRANT' AND LastName = 'KNERIEN'
ORDER BY
    CheckIn;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
SELECT
    RoomName, 
    Rate, 
    DATEDIFF(CheckOut, CheckIn) AS Nights, 
    DATEDIFF(CheckOut, CheckIn) * Rate AS Paid
FROM
    reservations
JOIN 
    rooms ON RoomCode = Room
WHERE
    CheckIn = '2010-12-31'
ORDER BY
    Nights DESC;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
SELECT 
    CODE, Room, RoomName, CheckIn, CheckOut 
FROM
    rooms
JOIN
    reservations ON Room = RoomCode
WHERE
    bedType = 'Double' AND Adults = 4
ORDER BY 
    CheckIn,RoomCode;;


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
SELECT
    Place, RunTime, Pace
FROM
    marathon
WHERE
    FirstName = 'TEDDY' AND LastName = 'BRASEL';


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
SELECT 
    FirstName, LastName, Place, RunTime, GroupPlace
FROM
    marathon
WHERE
        Town = 'QUNICY'
    AND
        State = 'MA'
    AND 
        Sex = 'F'
ORDER BY
    Place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
SELECT 
    FirstName, LastName, Town, RunTime
FROM
    marathon
WHERE
        Sex = 'F'
    AND
        Age = 34
    AND
        State = 'CT'
ORDER BY
    RunTime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
SELECT DISTINCT
    m1.BibNumber
FROM
    marathon as m1, marathon AS m2
WHERE
        m1.BibNumber = m2.BibNumber
    AND
        m1.Place != m2.Place
ORDER BY
    m1.BibNumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Include only age/gender groups with both a first and second place runner. Order the output by gender, then by age group.
SELECT DISTINCT
    m1.Sex,
    m1.AgeGroup,
    m1.FirstName,
    m1.LastName,
    m1.Age,
    m2.FirstName,
    m2.LastName,
    m2.Age
FROM
    marathon as m1
JOIN
    marathon as m2 ON m1.AgeGroup = m2.AgeGroup AND m1.Sex = m2.Sex
WHERE
        m1.GroupPlace = 1
    AND
        m2.GroupPlace = 2
ORDER BY
    Sex, AgeGroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
SELECT DISTINCT 
    Name, Abbr 
FROM 
    flights 
JOIN 
    airlines ON Airline = ID
WHERE 
    Source = 'AXX'
ORDER BY 
    Name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

SELECT 
    flightno,Destination,airports.Name 
FROM
    flights 
JOIN 
    airlines ON Airline = ID
JOIN 
    airports ON airports.Code = Destination
WHERE 
    Source = 'AXX' AND airlines.Name = 'Northwest Airlines'
ORDER BY 
    flightno;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
SELECT 
    * 
FROM
    (SELECT 
        flightno,Destination AS Code,airports.Name 
    FROM
        flights 
    JOIN 
        airlines ON Airline = ID
    JOIN 
        airports ON airports.Code = Destination
    WHERE 
            Source = 'AXX' 
        AND 
            airlines.Name = 'Northwest Airlines') t1
JOIN
    (SELECT 
        * 
    FROM 
        flights
    JOIN 
        airlines ON Airline = ID
    WHERE 
        airlines.Name = 'Northwest Airlines') t2 ON t1.Code = t2.Source
ORDER BY
    Code;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
SELECT DISTINCT
    flights.Source, flights.Destination
FROM
    flights 
JOIN 
    airlines ON Airline = ID
JOIN
    flights AS t1
JOIN 
    airlines AS t2 ON t1.Airline = t2.ID
WHERE
        ((airlines.Name = 'Frontier Airlines'
    OR
        t2.Name = 'Frontier Airlines')
    AND
        (airlines.Name = 'JetBlue Airways'
    OR
        airlines.Name = 'JetBlue Airways'))
    AND
        flights.Source = t1.Source
    AND
        flights.Source < t1.Destination
    AND
        flights.Destination = t1.Destination;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
SELECT DISTINCT
    flights.Source
FROM
    flights
JOIN
    airlines ON Airline = ID
JOIN 
    flights AS t1 ON flights.Source = t1.Source
JOIN
    airlines AS t2 ON t1.Airline = t2.ID
JOIN 
    flights AS t3 ON flights.Source = t3.Source
JOIN
    airlines AS t4 ON t3.Airline = t4.ID
JOIN 
    flights AS t5 ON flights.Source = t5.Source
JOIN
    airlines AS t6 ON t5.Airline = t6.ID
JOIN 
    flights AS t7 ON flights.Source = t7.Source
JOIN
    airlines AS t8 ON t7.Airline = t8.ID
WHERE
        airlines.Name = 'Frontier Airlines'
    AND
        t2.Name = 'Southwest Airlines'
    AND
        t4.Name = 'US Airways'
    AND
        t6.Name = 'Delta Airlines'
    AND
        t8.Name = 'United Airlines'
ORDER BY
    flights.Source;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
SELECT 
    Destination
FROM 
    flights 
JOIN 
    airlines ON Airline = ID
WHERE 
    airlines.Name = 'Southwest Airlines'
GROUP BY 
    Destination
HAVING 
    COUNT(Destination) >= 3
ORDER BY 
    Destination;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
SELECT 
    Songs.Title 
FROM 
    Albums 
JOIN
    Tracklists ON AId = Album
JOIN 
    Songs ON Song = SongId
WHERE 
    Albums.Title = 'Le Pop';


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
SELECT
    FirstName,Instrument 
FROM 
    Songs 
JOIN
    Instruments ON Song = SongId 
JOIN 
    Band ON Bandmate = Id
WHERE 
    Title = 'Mother Superior'
ORDER BY 
    FirstName;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT
    DISTINCT Instrument 
FROM
    Performance 
JOIN
    Songs ON Performance.Song = SongId
JOIN 
    Band On Performance.Bandmate = Id
JOIN
    Instruments ON Instruments.Song = SongId AND Instruments.Bandmate = Id
WHERE 
    FirstName = 'Anne-Marit'
ORDER BY 
    Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
SELECT
    Title 
FROM
    Songs 
JOIN
    Instruments ON Song = SongId
WHERE 
    Instrument = 'ukalele'
ORDER BY 
    Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT
    Distinct Instrument 
FROM 
    Songs 
JOIN 
    Instruments ON Instruments.Song = SongId
JOIN 
    Band On Id = Instruments.Bandmate
JOIN 
    Vocals ON Id = Vocals.Bandmate AND Vocals.Song = SongId
WHERE 
    FirstName = 'Turid' AND VocalType = 'lead'
ORDER BY 
    Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
SELECT 
    s.Title, b.FirstName, p.StagePosition
FROM 
    Songs s
JOIN 
    Performance p ON s.SongId = p.Song
JOIN 
    Band b ON b.Id = p.Bandmate
JOIN 
    Vocals v ON v.Song = s.SongId AND v.Bandmate = b.Id
WHERE 
        p.StagePosition <> 'center'
    AND 
        v.VocalType = 'lead'
ORDER BY 
    s.Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
SELECT
    Title 
FROM
    Songs 
JOIN 
    Instruments ON Instruments.Song = SongId
JOIN 
    Band On Id = Instruments.Bandmate
WHERE 
    FirstName = 'Anne-Marit'
GROUP BY
    Title
HAVING 
    COUNT(Title) = 3;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
SELECT
    b1.FirstName, b2.FirstName, b3.FirstName, b4.FirstName
FROM
    Songs AS s1
JOIN 
    Performance AS p1 ON p1.Song = s1.SongId
JOIN 
    Band AS b1 ON b1.Id = p1.Bandmate
JOIN 
    Performance AS p2 ON p2.Song = s1.SongId
JOIN 
    Band AS b2 ON b2.Id = p2.Bandmate
JOIN 
    Performance AS p3 ON p3.Song = s1.SongId
JOIN 
    Band AS b3 ON b3.Id = p3.Bandmate
JOIN 
    Performance AS p4 ON p4.Song = s1.SongId
JOIN 
    Band AS b4 ON b4.Id = p4.Bandmate
WHERE 
        s1.Title = 'A Bar in Amsterdam'
    AND
        p1.StagePosition = 'right'
    AND
        p2.StagePosition = 'center'
    AND
        p3.StagePosition = 'back'
    AND
        p4.StagePosition = 'left';


