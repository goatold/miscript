DROP TABLE IF EXISTS Members;
CREATE TABLE Members (
    firstname TEXT NOT NULL,
    lastname TEXT NOT NULL,
    email TEXT NOT NULL,
    PRIMARY KEY (firstname, lastname)
    UNIQUE(email)
);
INSERT INTO "Members" VALUES('Andrew','Milne','andrew_a.milne@nokia.com');
INSERT INTO "Members" VALUES('Barry','Mark','barry.mark@nokia.com');
INSERT INTO "Members" VALUES('Christopher','Hnetka','christopher.hnetka@nokia.com');
INSERT INTO "Members" VALUES('Reza','Ataei','reza.ataei@nokia.com');
INSERT INTO "Members" VALUES('Jonathan','Gu','jonathan.gu@nokia.com');
INSERT INTO "Members" VALUES('John','Chuah','john.chuah@nokia.com');
INSERT INTO "Members" VALUES('John','Coffell','john.coffell@nokia.com');
INSERT INTO "Members" VALUES('Leo','Wang','li.5.wang@nokia.com');

DROP TABLE IF EXISTS Places;
CREATE TABLE Places (
    name text primary key,
    address text not null,
    info text not null
);
INSERT INTO "Places" VALUES('Swan at Carp','108 Falldown Ln', 'http://www.theswanatcarp.ca/');
INSERT INTO "Places" VALUES('Juke Joint','3740 Carp Rd', 'https://www.thejukejointsoulkitchen.com/');
INSERT INTO "Places" VALUES('Old Mill at Ashton', '113 Old Mill Road', 'http://www.ashtonbrewingcompany.com/contact');
INSERT INTO "Places" VALUES('Flavours of Kerala', '1104 Klondike Rd', 'http://flavoursofkerala.com/');
INSERT INTO "Places" VALUES('Cheshire Cat Pub', '2193 Richardson Side Rd', 'http://www.cheshirecatpub.com/');
INSERT INTO "Places" VALUES('Central Bierhaus', '650 Kanata Ave', 'https://www.centralbierhaus.com/');

DROP TABLE IF EXISTS Events;
CREATE TABLE Events (
date DATE,
coordinator text not null references members (email),
place text not null references Places (name)
);
INSERT INTO "Events" VALUES('2017-12-07','john.coffell@nokia.com','Flavours of Kerala');
INSERT INTO "Events" VALUES('2018-01-04','john.chuah@nokia.com','Cheshire Cat Pub');
INSERT INTO "Events" VALUES('2018-02-01','jonathan.gu@nokia.com','Old Mill at Ashton');
INSERT INTO "Events" VALUES('2018-03-01','christopher.hnetka@nokia.com','Juke Joint');
INSERT INTO "Events" VALUES('2018-04-05','barry.mark@nokia.com','Swan at Carp');
INSERT INTO "Events" VALUES('2018-05-03','andrew_a.milne@nokia.com','Central Bierhaus');

