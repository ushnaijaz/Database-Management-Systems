CREATE TABLE Student(

    [RegNo] [nvarchar] (9) NOT NULL,
	[StdName] [nvarchar](40) NOT NULL,
	[Address] [nvarchar](60) NOT NULL,
	[City] [nvarchar](15) NOT NULL,
	[Country] [nvarchar](15) NOT NULL,
	[Phone] [nvarchar](24) NULL,
	[GPA] [float] NULL,
    CONSTRAINT PK_Person PRIMARY KEY (RegNo)
)

CREATE TABLE Course(

    [CourseID] [nvarchar](20) NOT NULL,
	[CName] [nvarchar](100) NOT NULL,
	[tid] [nvarchar] (10) NULL,
	[RegNo] [nvarchar] (10) NULL,
    CONSTRAINT PK_Course PRIMARY KEY (CourseID),
	FOREIGN KEY (RegNo) REFERENCES Student(RegNo)
)

CREATE TABLE Teacher(

    [tid] [nvarchar] (9) NOT NULL,
	[tName] [nvarchar](40) NOT NULL,
	[Address] [nvarchar](60) NULL,
	[City] [nvarchar](15) NULL,
	[Country] [nvarchar](15) NULL,
	[Phone] [nvarchar](24) NULL,
	[CourseID] [nvarchar](10) NULL,
    CONSTRAINT PK_teacher PRIMARY KEY (tid),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
)
CREATE TABLE CLO(
    [CourseID] [nvarchar](20) NOT NULL,
	[Clo] [nvarchar](10) NOT NULL
	CONSTRAINT courseID PRIMARY KEY (CourseID),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
)

CREATE TABLE Assessment(
	[CourseID] [nvarchar](10) NOT NULL,
	[Aid] [nvarchar] NOT NULL,
	[RegNo] [nvarchar] (9) NOT NULL,
	[clo] [nvarchar](10) NOT NULL,
	[rubric] [nvarchar](10) NOT NULL,
	[component] [nvarchar](10) NOT NULL,
	[sRubric] [int] NULL,
	[obtMarks] [int] NULL,
	PRIMARY KEY (Aid),
	FOREIGN KEY (RegNo) REFERENCES Student(RegNo),
	FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
)