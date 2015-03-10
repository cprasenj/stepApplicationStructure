conn / as sysdba
DROP USER STEP_COORDINATOR cascade;
clear screen
-- PROMPT 'Creating Tablespaces'

-- CREATE TABLESPACE ts_step_system DATAFILE 'C:\ORACLEXE\APP\ORACLE\ORADATA\XE\ts_system_01.dbf' SIZE 200M AUTOEXTEND ON;
-- PROMPT '.... Tablespace creation completed.'

PROMPT 'Creating user'
CREATE USER STEP_COORDINATOR IDENTIFIED BY STEP DEFAULT TABLESPACE ts_step_system QUOTA UNLIMITED ON ts_step_system;
GRANT CREATE SESSION TO STEP_COORDINATOR;
GRANT CREATE TABLE TO STEP_COORDINATOR;
GRANT CREATE VIEW TO STEP_COORDINATOR;
GRANT RESOURCE TO STEP_COORDINATOR;(has to be done by STEP_COORDINATOR)

PROMPT '.... User created with required privileges'

-- Connect as the schema user
PROMPT 'Connecting as STEP user'
conn STEP_COORDINATOR/STEP

PROMPT '....applicant table is in creation'

CREATE TABLE applicant (
	id          				NUMBER(10),
	name        				VARCHAR(50) NOT NULL,
	gender      				char(1) NOT NULL,
	dob         				DATE NOT NULL,
	bloodgroup  				VARCHAR(5) NOT NULL,
	yearOfPassing_diploma 		NUMBER(5) NOT NULL,
	boardFor10th				VARCHAR(200) NOT NULL,
	yearOfPassing_10th 		    NUMBER(5) NOT NULL,
	registrationNumber_10th 	NUMBER(30) NOT NULL UNIQUE,
	registrationNumber_diploma  NUMBER(30) NOT NULL UNIQUE,
	ExamCenterId				NUMBER(3),
	stateId						NUMBER(3) NOT NULL,
	percentageOfMarks_diploma	NUMBER(3) NOT NULL,
	contactNunber				NUMBER(12) NOT NULL,
	email						VARCHAR(50) NOT NULL,
	address						VARCHAR(50) NOT NULL,
	parentsName					VARCHAR(30),
	CONSTRAINT id PRIMARY KEY(id),
	CONSTRAINT emp_gender_chk CHECK(gender IN ('M', 'F') )
); 

PROMPT '....applicant table created'

PROMPT '....examCenter table is in creation'

CREATE TABLE examCenter (
	center_id 	NUMBER(10),
	stateId 	NUMBER(3),
	address 	VARCHAR(50) UNIQUE,	
	CONSTRAINT center_id PRIMARY KEY(center_id)
); 

PROMPT '....examCenter table created'

PROMPT '....clearedAptitude table is in creation'

CREATE TABLE clearedAptitude (
	application_id 	NUMBER(10),
	state_id 		NUMBER(3),
	examCenter_id 	NUMBER(10)
);

PROMPT '....clearedAptitude table is created'

PROMPT '....state table is in creation'

CREATE TABLE state (
	state_id 	NUMBER(3),
	stateName 	VARCHAR(20),
	CONSTRAINT state_id PRIMARY KEY(state_id)
);

PROMPT '....state table is created'

PROMPT '....interview table is in creation'

CREATE TABLE interview (
	interview_center_code 	NUMBER(5),
	candidate_id 			NUMBER(10),
	interview_date 			DATE,
	interview_time 			VARCHAR(5)
);

PROMPT '....interview table is created'

PROMPT '....interview center table'

CREATE TABLE interviewCenter(
	stId 			NUMBER(3),
	centerCode 		NUMBER(5),
	centerAddress 	NUMBER(50),
	CONSTRAINT centerCode PRIMARY KEY(centerCode)
);

PROMPT '....interviewCenter table created'

PROMPT '....selected table is in creation'

CREATE TABLE selected(
	cadidateId 			NUMBER(10),
	interviewCenterCode NUMBER(5)
);

PROMPT '....selected table created'

PROMPT '....TPinterview table is in creation'

CREATE TABLE TPinterview(
	candidate_Id NUMBER(10),
	timeOfInterView VARCHAR(5),
	contactNunber NUMBER(12)
);

PROMPT '....TPinterview table created'

PROMPT 'student confirmed for interview table in creation'

CREATE TABLE confirmedForInterview(
	studId 			NUMBER(10),
	preferenceCode 	NUMBER(5)
);

PROMPT 'student confirmed for interview table created'

-- PROMPT 'preference table is in creation'
