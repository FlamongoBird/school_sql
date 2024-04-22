
CREATE TABLE Inventory (
    InventoryID INT,
    Name VARCHAR,
    Cost DECIMAL(10, 2),
    CONSTRAINT pk_Inventory PRIMARY KEY (InventoryID)
)

INSERT INTO Inventory VALUES
(1, "syringe", 10.00),
(2, "catheter", 25.00),
(3, "breathing apparatus", 75.00);

CREATE TABLE ZipCodes (
    ZipCode CHAR(10),
    City VARCHAR,
    State VARCHAR,
)

INSERT INTO ZipCodes VALUES
("37025-0000", "Nashville", "TN"),
("37025-0001", "New York", "NY"),
("37025-0002", "Pittsburgh", "PA");


CREATE TABLE Availability (
    AvailabilityID INT,
    Monday BOOLEAN,
    Tuesday BOOLEAN,
    Wednesday BOOLEAN,
    Thursday BOOLEAN,
    Friday BOOLEAN,
    Saturday BOOLEAN,
    Sunday BOOLEAN,
    CONSTRAINT pk_Availability PRIMARY KEY (AvailabilityID)
)

INSERT INTO Availability VALUES
(1, true, true, true, true, true, true, true),
(2, false, true, true, true, true, false, true),
(3, false, false, true, false, true, true, true);


CREATE TABLE Staff (
    StaffID INT,
    SkillLevel SMALLINT,
    ZipCode CHAR(10) NOT NULL,
    Name VARCHAR,
    Position VARCHAR,
    Salary DECIMAL(10, 2),
    CONSTRAINT pk_Staff PRIMARY KEY (StaffID),
    CONSTRAINT fk_ZipCode_Staff FOREIGN KEY (ZipCode) REFERENCES ZipCodes
)

INSERT INTO Staff VALUES
(1, 3, "37025-0000", "John Doe", "aide", 20000.00),
(2, 7, "37025-0000", "Jane Doe", "LPN", 60000.00),
(3, 10, "37025-0000", "Joe Doe", "RN", 80000.00);


CREATE TABLE Contract (
    ContractID INT,
    MaximumVisits INT,
    ServicesPerformed VARCHAR,
    VisitsPerWeek INT,
    EndDate DATE,
    StartDate DATE,
    PaymentType VARCHAR(25),
    InventoryID INT,
    CONSTRAINT pk_Contract PRIMARY KEY (ContractID),
    CONSTRAINT fk_Inventory FOREIGN KEY (InventoryID) REFERENCES Inventory
)

INSERT INTO Contract VALUES
(1, 5, "wound dressing", 3, 01/01/1970, 02/02/1970, "private pay", 1),
(2, 10, "catheterization", 5, 01/01/1970, 02/02/1970, "medicare", 2),
(3, 20, "bathing", 8, 01/01/1970, 02/02/1970, "private insurance", 3);

CREATE TABLE Insurance (
    InsuranceID INT,
    RatePerVisit DECIMAL(10, 2),
    MaximumVisits INT,
    Visits INT,
    CONSTRAINT pk_Insurance PRIMARY KEY (InsuranceID)
)

INSERT INTO Insurance VALUES
(1, 105.50, 10, 5),
(2, 150.00, 15, 3),
(3, 200.75, 5, 3);


CREATE TABLE Patients (
    PatientID INT,
    Name VARCHAR,
    InsuranceID INT,
    CONSTRAINT pk_Patients PRIMARY KEY (PatientID),
    CONSTRAINT fk_InsuranceID_Patients FOREIGN KEY (InsuranceID) REFERENCES Insurance
)

INSERT INTO Patients VALUES
(1, "Paul", 1),
(2, "Martha", 2),
(3, "Sarake", 3);

CREATE TABLE Referrals (
    ReferralID INT,
    CareNeeded VARCHAR,
    EquipmentNeeded VARCHAR,
    CareDesc VARCHAR,
    StaffID INT,
    PatientID INT,
    CONSTRAINT pk_Referrals PRIMARY KEY (ReferralID),
    CONSTRAINT fk_StaffID_Referrals FOREIGN KEY (StaffID) REFERENCES Staff,
    CONSTRAINT fk_PatientID_Referrals FOREIGN KEY (PatientID) REFERENCES Patients
)

INSERT INTO Referrals VALUES
(1, "skilled nursing", "change wound bandages twice a week", 1, 1),
(2, "home health aide", "provide baths twice a week", 2, 2),
(3, "skilled nursing", "provide baths every other day", 3, 3),


CREATE TABLE Visits (
    VisitID INT,
    LaborCosts DECIMAL(10, 2),
    InventoryID INT,
    CONSTRAINT pk_Visits PRIMARY KEY (VisitID),
    CONSTRAINT fk_VisitsInventory FOREIGN KEY (InventoryID) REFERENCES Inventory
)

INSERT INTO Visits VALUES
(1, 145.00, 1),
(1, 145.00, 2),
(2, 200.00, 3);
