 CREATE TABLE [table name]
([field1] [data type],
[field2] [data type],
CONSTRAINT [constraint name] PRIMARY KEY
[field name],
CONSTRAINT [constraint name] FOREIGN KEY
[field name] REFERENCES [table name of foreign
key],
ON DELETE [CASCADE, etc.])

-- Don't forget to change to smallint/etc
CREATE TABLE ZipCodes
(
    ZipCode CHAR(10),
    City VARCHAR,
    StateAbbr CHAR(2),
    CONSTRAINT pk_ZipCodes PRIMARY KEY (ZipCode)
)

CREATE TABLE Campuses
(
    CampusID INT,
    CampusName VARCHAR,
    CONSTRAINT pk_Campuses PRIMARY KEY (CampusID)
)

CREATE TABLE Courses
(
    CourseID INT,
    CoursePrefix VARCHAR,
    CourseNumber SMALLINT,
    CourseName VARCHAR,
    CONSTRAINT pk_Courses PRIMARY KEY (CourseID)
)

CREATE TABLE Buildings
(
    BuildingID INT,
    `Address` VARCHAR,
    BuildingName VARCHAR,
    CampusID INT NOT NULL,
    ZipCode CHAR(10) NOT NULL,
    CONSTRAINT pk_Buildings PRIMARY KEY (BuildingID),
    CONSTRAINT fk_ZipCode_Buildings FOREIGN KEY ZipCode REFERENCES ZipCodes,
    CONSTRAINT fk_CampusID_Buildings FOREIGN KEY CampusID REFERENCES, Campuses
)

CREATE TABLE ClassRooms
(
    RoomNumber SMALLINT,
    Occupancy SMALLINT,
    BuildingID INT NOT NULL,
    CONSTRAINT pk_ClassRooms PRIMARY KEY (RoomNumber, BuildingID)
)

CREATE TABLE FacultyOffices
(
    OfficeNumber SMALLINT,
    BuildingID INT NOT NULL,
    CONSTRAINT pk_FacultyOffices PRIMARY KEY (OfficeNumber, BuildingID)
)


CREATE TABLE Faculty
(
    FacultyID INT,
    FirstName VARCHAR,
    LastName VARCHAR,
    `Address` VARCHAR,
    Rank VARCHAR, -- not really sure about what type this one should be
    Salary MONEY,
    Specialty VARCHAR,
    ZipCode CHAR(10) NOT NULL,
    OfficeNumber SMALLINT,
    BuildingID INT,
    CONSTRAINT pk_Faculty PRIMARY KEY (FacultyID),
    CONSTRAINT fk_ZipCode_Faculty FOREIGN KEY ZipCode REFERENCES ZipCodes,
    CONSTRAINT fk_FacultyOffices_Faculty FOREIGN KEY (OfficeNumber, BuildingID) REFERENCES FacultyOffices
)

CREATE TABLE Students
(
    StudentID INT,
    FirstName VARCHAR,
    LastName VARCHAR,
    StreetAddress VARCHAR,
    Phone VARCHAR,
    Birthdate DATE,
    ZipCode CHAR(10) NOT NULL,
    MentorID INT,
    FacultyID INT NOT NULL,
    CONSTRAINT pk_Students PRIMARY KEY (StudentID),
    CONSTRAINT fk_ZipCode_Students FOREIGN KEY ZipCode REFERENCES ZipCodes,
    CONSTRAINT fk_FacultyID_Students FOREIGN KEY FacultyID REFERENCES FacultyID
)

CREATE TABLE Enroll
(
    StudentID INT NOT NULL,
    SectionID INT NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Grade VARCHAR(2),
    CONSTRAINT pk_Enroll PRIMARY KEY (StudentID)
)

CREATE TABLE Sections
(
    SectionID INT,
    SectionNumber SMALLINT,
    Term VARCHAR(10),
    `Year` SMALLINT,
    CourseID INT NOT NULL,
    RoomNumber SMALLINT NOT NULL,
    BuildingID INT NOT NULL,
    FacultyID INT NOT NULL,
    CONSTRAINT pk_Sections PRIMARY KEY (SectionID),
    CONSTRAINT fk_CourseID_Sections FOREIGN KEY CourseID REFERENCES Courses,
    CONSTRAINT fk_ClassRooms_Sections FOREIGN KEY (RoomNumber, BuildingID) REFERENCES ClassRooms,
    CONSTRAINT fk_FacultyID_Sections FOREIGN KEY FacultyID REFERENCES Faculty
)