CREATE DATABASE SistemControlTraficAerian2
ON PRIMARY
(
	Name = Data_1,
	FileName ='C:\Users\andre\OneDrive\Desktop\BazedeDate\Proiect1.2\Data_1.mdf',
	size = 10MB, -- KB, Mb, GB, TB  
	maxsize = unlimited,
	filegrowth = 1GB
),
(
	Name = Data_2,
	FileName ='C:\Users\andre\OneDrive\Desktop\BazedeDate\Proiect1.2\Data_2.ndf',
	size = 10MB, -- KB, Mb, GB, TB  
	maxsize = unlimited,
	filegrowth = 1GB
),
(
	Name = Data_3,  
	FileName = 'C:\Users\andre\OneDrive\Desktop\BazedeDate\Proiect1.2\Data_3.ndf',  
	size = 10MB, -- KB, Mb, GB, TB  
	maxsize = unlimited,  
	filegrowth = 1GB 
)
LOG ON
(
	Name = Log_1,  
	FileName = 'C:\Users\andre\OneDrive\Desktop\BazedeDate\Proiect1.2\Log_1.ldf',  
	size = 10MB, -- KB, Mb, GB, TB  
	maxsize = unlimited,  
	filegrowth = 1024MB 
),
(
	Name = Log_2,  
	FileName = 'C:\Users\andre\OneDrive\Desktop\BazedeDate\Proiect1.2\Log_2.ldf',  
	size = 10MB, -- KB, Mb, GB, TB  
	maxsize = unlimited,  
	filegrowth = 1024MB 
)

use [SistemControlTraficAerian2]

create table [Angajat Civil]
(
	IDAngajat_Civil int IDENTITY(1,1) primary key NOT NULL,
	Nume nvarchar(64) NOT NULL,
	Prenume nvarchar(64) NOT NULL,
	CNP nvarchar(64) NOT NULL, 
	Data_Nastere date NOT NULL,
	Sex nvarchar(64) NOT NULL,
	Oras nvarchar(64) NOT NULL,
	Judet nvarchar(64) NOT NULL,
	Adresa nvarchar(64) NOT NULL,
	NumarTelefon nvarchar(64) NOT NULL
)

create table [Functie Civila]
(
	IDFunctie int IDENTITY(1,1) primary key NOT NULL,
	[Denumire Functie] nvarchar(64) NOT NULL
)

create table [Functii Angajati Civili]
(
	IDFac int IDENTITY(1,1) primary key NOT NULL,
	IDAngajat_Civil int foreign key references [Angajat Civil](IDAngajat_Civil),
	IDFunctie int foreign key references [Functie Civila](IDFunctie),
	Data_Numire date NOT NULL,
	Data_Iesire date
)

create table [Firma Zbor]
(
	IDFirma_Zbor int IDENTITY(1,1) primary key NOT NULL,
	Denumire nvarchar(64) not null,
	Rating nvarchar(64) not null
)

create table [Firme Angajati Civili]
(
	IDFirmeAC int IDENTITY(1,1) primary key NOT NULL,
	IDAngajat_Civil int foreign key references [Angajat Civil](IDAngajat_Civil),
	IDFirma_Zbor int foreign key references [Firma Zbor](IDFirma_Zbor),
	Data_Angajare date not null,
	Data_Plecarii date
)

create table Aeroport
(
	IDAeroport int IDENTITY(1,1) primary key NOT NULL,
	Denumire nvarchar(64) not null, 
	Oras nvarchar(64) not null,
	Tara nvarchar(64) not null
)

create table [MarcaModelTip Avion]
(
	IDMMT int IDENTITY(1,1) primary key NOT NULL,
	Marca nvarchar(64) not null, 
	Model nvarchar(64) not null,
	Tip nvarchar(64) not null,
	CapacitateMaxima int not null
)

create table Avion
(
	IDAvion int IDENTITY(1,1) primary key NOT NULL,
	IDMMT int foreign key references [MarcaModelTip Avion](IDMMT),
	AnFabricatie int not null, 
	TaraFabricatie nvarchar(64) not null
)

create table Cursa
(
	IDCursa int IDENTITY(1,1) primary key NOT NULL,
	IDAvion int foreign key references Avion(IDAvion),
	DataPlecarii date not null, 
	DataSosirii date not null, 
	OraPlecarii nvarchar(64) not null, 
	OraSosirii nvarchar(64) not null,
	IDAeroportPlecare int foreign key references Aeroport(IDAeroport),
	IDAeroportSosire int foreign key references Aeroport(IDAeroport)
)

create table Bilet
(
	IDBilet int IDENTITY(1,1) primary key NOT NULL,
	Tip nvarchar(64) not null, 
	Clasa nvarchar(64) not null,
	Pret int not null,
	IDCursa int foreign key references Cursa(IDCursa),
	IDFirma_Zbor int foreign key references [Firma Zbor](IDFirma_Zbor)
)

create table Pasager
(
	IDPasager int IDENTITY(1,1) primary key NOT NULL,
	Nume nvarchar(64) not null, 
	Prenume nvarchar(64) not null, 
	Varsta int not null,
	NumarTelefon nvarchar(64) not null, 
	IDBilet int foreign key references Bilet(IDBilet)
)

create table [AngajatiC per Cursa]
(
	IDAnajatiCperCursa int IDENTITY(1,1) primary key NOT NULL,
	IDAngajat_Civil int foreign key references [Angajat Civil](IDAngajat_Civil),
	IDCursa int foreign key references Cursa(IDCursa)
)

create table [Informatii Zbor]
(
	IDInfo int IDENTITY(1,1) primary key NOT NULL,
	IDCursa int foreign key references Cursa(IDCursa),
	Ora nvarchar(64) not null, 
	StareVreme nvarchar(64) not null, 
	ProcentCombustibil int not null,
	ProcentDistanta int not null,
	Locatia nvarchar(64) not null
)

create table Militar
(
	IDMilitar int IDENTITY(1,1) primary key NOT NULL,
	Nume nvarchar(64) not null, 
	Prenume nvarchar(64) not null, 
	CNP nvarchar(64) not null, 
	Data_Nastere date not null,
	Sex nvarchar(64) not null, 
	Oras nvarchar(64) not null, 
	Judet nvarchar(64) not null, 
	Adresa nvarchar(64) not null, 
	NumarTelefon nvarchar(64) not null
)

create table GradMilitar
(
	IDGrad int IDENTITY(1,1) primary key NOT NULL,
	Denumire nvarchar(64) not null
)

create table GradeMilitari
(
	IDGradeMilitari int IDENTITY(1,1) primary key NOT NULL,
	IDMilitar int foreign key references Militar(IDMilitar),
	IDGrad int foreign key references GradMilitar(IDGrad),
	Data1Perioada date not null,
	Data2Perioada date 
)

create table Functie
(
	IDFunctie int IDENTITY(1,1) primary key not null,
	Denumire nvarchar(64) not null,
)

create table FunctiiMilitari
(
	IDFunctieMilitar int IDENTITY(1,1) primary key not null,
	IDMilitar int foreign key references Militar(IDMilitar),
	IDFunctie int foreign key references Functie(IDFunctie),
	DataNumiriiinFunctie date not null,
	DataIesiriidinFunctie date
)

create table [Unitate Militara]
(
	IDUnitateMilitara int IDENTITY(1,1) primary key not null,
	Denumire nvarchar(64) not null,
	Oras nvarchar(64) not null,
	Tara nvarchar(64) not null
)

create table [Unitati Militare Militari]
(
	IDUMM int IDENTITY(1,1) primary key not null,
	IDMilitar int foreign key references Militar(IDMilitar),
	IDUnitateMilitara int foreign key references [Unitate Militara](IDUnitateMilitara),
	Data1Perioada date not null,
	Data2Perioada date
)

create table Misiune
(
	IDMisiune int IDENTITY(1,1) primary key not null,
	IDAvion int foreign key references Avion(IDAvion),
	Denumire nvarchar(64) not null,
	DataPlecarii date not null,
	DataSosirii date not null,
	OraPlecarii nvarchar(64) not null,
	OraSosirii nvarchar(64) not null,
	IDUnitateMilitaraPlecare int foreign key references [Unitate Militara](IDUnitateMilitara),
	IDUnitateMilitaraSosire int foreign key references [Unitate Militara](IDUnitateMilitara)
)

create table [Militari per Misiune]
(
	IDMilperMis int IDENTITY(1,1) primary key not null,
	IDMilitar int foreign key references Militar(IDMilitar),
	IDMisiune int foreign key references Misiune(IDMisiune)
)

create table [RaportM Zbor]
(
	IDRaport int IDENTITY(1,1) primary key not null,
	IDMisiune int foreign key references Misiune(IDMisiune),
	Ora nvarchar(64) not null,
	StareVreme nvarchar(64) not null,
	ProcentCombustibil int not null,
	ProcentDistanta int not null,
	Locatia nvarchar(64) not null
)



use [SistemControlTraficAerian2]

insert into [Angajat Civil](Nume, Prenume, CNP, Data_Nastere, Sex, Oras, Judet, Adresa, NumarTelefon)
values
(
	'Laufer','Andreea','6030726055143','2003-07-26','feminin','Slatioara','Olt','Str.Manastirii,nr.66',40774383514
),
(
	'Tudorache','Andreea','2931015173920','1993-10-15','feminin','Tecuci','Galati','Str.Tecui,nr.24',40774383392
),
(
	'Pop','Teodora','2950809079724','1995-08-09','feminin','Slatina','Olt','Str.Banului,nr.77',40774383972
),
(
	'Popescu','Sorina','2920204213809','1992-02-04','feminin','Slobozia','Ialomita','Str.Ploii,nr.1',40799383666
),
(
	'Lascu','Mihaela','2890713114680','1989-07-13','feminin','Resita','Caras-Severin','Str.Primaverii,nr.3',40799383380
),
(
	'Dima','Denisa','6010306525961','2001-03-06','feminin','Giurgiu','Giurgiu','Str.Soarelui,nr.1',40799383596
),
(
	'Miclaus','Simona','2880107118405','1988-01-07','feminin','Resita','Caras-Severin','Str.Primaverii,nr.1',40799383840
),
(
	'Baltag','Octavian','1950612362469','1995-06-12','masculin','Macin','Tulcea','Str.Rasarit,nr.17',40799333246
),
(
	'Stanescu','Constantin','1970705027441','1997-07-05','masculin','Lipova','Arad','Str.Mineri,nr.1',40799033744
),
(
	'Voicu','Violeta','2990413353641','1999-04-13','feminin','Buzias','Timis','Str.Tudor,nr.2',40799032364
),
(
	'Vascan','Teodor','1891203401820','1989-12-03','masculin','Sect.1','Bucuresti','Str.Higa,nr.1',40799032182
),
(
	'Titihazan','Viorel','1880404284957','1988-04-04','masculin','Craiova','Dolj','Str.Universitatii,nr.2',40799032495
),
(
	'Popescu','Constantin','1890320452314','1989-03-20','masculin','Slatina','Olt','Str.Muncii,nr.1',40774032111
),
(
	'Pacurar','Claudia','2870825085505','1987-08-25','feminin','Sacele','Brasov','Str.Livezii,nr.1',40774032550
),
(
	'Oltean','Ioan-Danut','1900421246541','1990-04-21','masculin','Baia Mare','Maramures','Str.Toamnei,nr.4',40774032654
),
(
	'Marinescu','Andrei','1970215466251','1997-02-15','masculin','Sect.6','Bucuresti','Str.General Praporgescu,nr.2',40766032625
),
(
	'Golovanov','Carmen','2980612191677','1998-06-12','feminin','Caracal','Olt','Str.Manastirii,nr.1',40766042167
),
(
	'Darie','Emanuel','1990801399297','1999-08-01','masculin','Focsani','Vrancea','Str.Libertatii,nr.2',40766022929
),
(
	'Cernat','Mihai','1900208260300','1990-02-08','masculin','Reghin','Mures','Str.Aiud,nr.33',40774022030
),
(
	'Bicu','Aida','6020430433856','2002-04-30','feminin','Sect.3','Bucuresti','Str.Muncii,nr.1',40774092385
),
(
	'Ardeleanu','Mircea','1910911195016','1991-09-11','masculin','Borsec','Harghita','Str.Primaverii,nr.14',40765092501
)

insert into [Functie Civila]([Denumire Functie])
values
(
	'Pilot'
),
(
	'Co-pilot'
),
(
	'Mecanic aeronave'
),
(
	'Stewardesa'
),
(
	'Agent de pista'
)

insert into [Functii Angajati Civili](IDAngajat_Civil,IDFunctie,Data_Numire,Data_Iesire)
values
(
	1,4,'2022-01-05',null
),
(
	2,4,'2019-10-01',null
),
(
	3,4,'2020-11-03',null
),
(
	4,4,'2019-06-01',null
),
(
	5,4,'2015-03-17',null
),
(
	6,4,'2019-12-28',null
),
(
	7,4,'2014-05-05',null
),
(
	8,5,'2017-10-01',null
),
(
	9,5,'2018-11-12',null
),
(
	10,4,'2020-04-13',null
),
(
	11,2,'2017-02-03','2019-05-07'
),
(
	11,1,'2019-05-07',null
),
(
	12,2,'2010-12-03','2014-10-07'
),
(
	12,1,'2014-10-07',null
),
(
	13,3,'2011-11-27','2015-12-01'
),
(
	13,2,'2015-12-01','2018-10-07'
),
(
	13,1,'2018-10-07',null
),
(
	14,2,'2010-10-07',null
),
(
	15,3,'2018-05-07',null
),
(
	16,3,'2022-02-02',null
),
(
	17,4,'2020-05-14',null
),
(
	18,3,'2021-03-13',null
),
(
	19,2,'2020-03-13','2021-04-04'
),
(
	19,1,'2021-04-04',null
),
(
	20,4,'2022-01-02',null
),
(
	21,5,'2014-02-22',null
)


insert into [Firma Zbor](Denumire,Rating)
values
(
	'Wizz Air', '4/5'
),
(
	'Blue Air', '3.8/5'
),
(
	'Tarom', '3.8/5'
),
(
	'Ryanair', '3.8/5'
),
(
	'Lufthansa', '4.1/5'
),
(
	'Emirates', '4.4/5'
),
(
	'Air Europa', '3.8/5'
),
(
	'Austrian', '3.9/5'
),
(
	'ITA Airways', '3.9/5'
)


insert into [Firme Angajati Civili](IDAngajat_Civil,IDFirma_Zbor,Data_Angajare,Data_Plecarii)
values
(
	1,1,'2022-01-05',null
),
(
	2,2,'2019-10-01',null
),
(
	3,3,'2020-11-03',null
),
(
	4,4,'2019-06-01',null
),
(
	5,5,'2015-03-17','2016-03-17'
),
(
	5,6,'2016-03-17',null
),
(
	6,6,'2019-12-28',null
),
(
	7,7,'2014-05-05','2016-05-05'
),
(
	7,8,'2016-05-05',null
),
(
	8,8,'2017-10-01','2019-10-01'
),
(
	8,9,'2019-10-01',null
),
(
	9,6,'2018-11-12',null
),
(
	10,9,'2020-04-13',null
),
(
	11,1,'2017-02-03','2019-05-07'
),
(
	11,2,'2019-05-07',null
),
(
	12,2,'2010-12-03',null
),
(
	13,3,'2011-11-27',null
),
(
	14,4,'2010-10-07',null
),
(
	15,5,'2018-05-07',null
),
(
	16,6,'2022-02-02',null
),
(
	17,8,'2020-05-14',null
),
(
	18,9,'2021-03-13',null
),
(
	19,6,'2020-03-13',null
),
(
	20,7,'2022-01-02',null
),
(
	21,5,'2014-02-22',null
)

insert into Aeroport(Denumire,Oras,Tara)
values
(
	'Aeroportul internationa "Henri Coanda"','Bucuresti','Romania'
),
(
	'Aeroportul internationa "Avram Iancu"','Cluj-Napoca','Romania'
),
(
	'Aeroportul internationa Craiova','Craiova','Romania'
),
(
	'Aeroportul internationa "Traian Vuia"','Timisoara','Romania'
),
(
	'Aeroportul internationa Sibiu','Sibiu','Romania'
),
(
	'Aeroportul internationa Arad','Arad','Romania'
),
(
	'Aeroportul internationa "George Enescu"','Bacau','Romania'
),
(
	'Aeroportul internationa Heathrow','Londra','Regatul Unit'
),
(
	'Aeroportul internationa Frankfurt','Frankfurt am Main','Germania'
),
(
	'Aeroportul internationa "Charles de Gaulle"','Roissy-en-France','Franta'
)


insert into [MarcaModelTip Avion]
values
(
	'Airbus','A220','civil',145
),
(
	'Airbus','A320','civil',195
),
(
	'Airbus','A330','civil',200
),
(
	'Airbus','A340','civil',380
),
(
	'Boeing','737NG','civil',400
),
(
	'Boeing','737MAX','civil',410
),
(
	'E-jet','E2','civil',150
),
(
	'Airbus','A400M','militar de transport',200
),
(
	'Antonov','An-225','militar de transport',300
),
(
	'Antonov','An-124','militar de transport',88
),
(
	'Boeing','737NG','militar de transport',6
),
(
	'Lockheed','C-5 Galaxy','militar de transport',7
),
(
	'Lockheed','C-130 Hercules','militar de transport',6
),
(
	'F-22','Raptor','militar de vanatoare',1
),
(
	'F-35','Lighting II','militar de vanatoare',1
),
(
	'F-18','Hornet','militar de vanatoare',1
),
(
	'Eurofighter','Typhoon','militar de vanatoare',1
),
(
	'Suhoi','SU-35','militar de vanatoare',1
)

insert into Avion(IDMMT,AnFabricatie,TaraFabricatie)
values
(
	1,2013,'Canada'
),
(
	1,2014,'Canada'
),
(
	2,1988,'Franta'
),
(
	3,1992,'Franta'
),
(
	4,1993,'Franta'
),
(
	5,1997,'USA'
),
(
	6,2017,'Malaezia'
),
(
	7,2016,'Brazilia'
),
(
	8,2009,'Germania'
),
(
	9,1988,'Ucraina'
),
(
	10,1986,'Rusia'
),
(
	11,1998,'USA'
),
(
	12,1970,'USA'
),
(
	13,1988,'USA'
),
(
	14,2005,'USA'
),
(
	15,2016,'USA'
),
(
	16,1984,'USA'
),
(
	17,2003,'Germania'
),
(
	18,1988,'Rusia'
)

insert into Cursa(IDAvion,DataPlecarii,DataSosirii,OraPlecarii,OraSosirii,IDAeroportPlecare,IDAeroportSosire)
values
(
	1,'2022-02-01','2022-02-01','15:00','21:00', 1,9
),
(
	2,'2022-03-22','2022-03-23','21:00','01:30', 2,10
),
(
	3,'2022-04-23','2022-04-24','23:00','05:00',3,8
),
(
	4,'2022-06-11','2022-06-11','03:00','09:00',4,9
),
(
	5,'2022-05-11','2022-05-11','14:00','15:00',5,1
),
(
	6,'2022-11-12','2022-11-12','05:00','07:30',6,1
),
(
	7,'2022-07-01','2022-07-01','5:45','8:00',7,1
)

insert into Bilet(Tip,Clasa,Pret,IDCursa,IDFirma_Zbor)
values
(
	'Dus','I',250,1,1
),
(
	'Dus-intors','II',100,2,2
),
(
	'Dus','I',300,3,3
),
(
	'Dus-intors','II',200,4,4
),
(
	'Dus','II',150,5,5
),
(
	'Dus-intors','II',150,6,6
),
(
	'Dus','I',370,7,7
),
(
	'Dus-intors','I',400,1,8
),
(
	'Dus-intors','II',120,2,9
),
(
	'Dus','II',110,3,1
),
(
	'Dus-intors','II',140,4,2
),
(
	'Dus','II',150,5,3
),
(
	'Dus','I',275,6,4
),
(
	'Dus','II',200,7,5
),
(
	'Dus-intors','I',370,1,6
)

insert Pasager(Nume, Prenume,Varsta, NumarTelefon,IDBilet)
values
(
	'Dinca','Andrei	',25,'40774232385',1
),
(
	'Florescu','Maria',40,'40772192385',2
),
(
	'Marienscu','Cosmin',33,'40774093285',3
),
(
	'Soare','Sorin',22,'40774092765',4
),
(
	'Popescu','Alberto',20,'40774045385',5
),
(
	'Ciusnel','Daria',45,'40774092655',6
),
(
	'Dicu','Ruxandra',24,'40788092385',7
),
(
	'Calinescu','Marina',44,'40789092385',8
),
(
	'Zorlescu','George',55,'40774492385',9
),
(
	'Dinica','Gheorghe',34,'40773492385',10
),
(
	'Patriciu','Dan',19,'40774094385',11
),
(
	'Secui','Mariana',21,'40774065385',12
),
(
	'Bob','Marley',21,'4077556385',13
),
(
	'Peru','Sandel',21,'40774076385',14
),
(
	'Ionescu','Eugen',21,'40773465385',15
)

insert [AngajatiC per Cursa](IDAngajat_Civil,IDCursa)
values
(
	1,1
),
(
	2,2
),
(
	3,3
),
(
	4,4
),
(
	5,5
),
(
	6,6
),
(
	7,7
),
(
	8,1
),
(
	9,2
),
(
	10,3
),
(
	11,4
),
(
	12,5
),
(
	13,6
),
(
	14,7
),
(
	15,1
),
(
	16,2
),
(
	17,3
),
(
	18,4
),
(
	19,5
),
(
	20,6
),
(
	21,7
)

insert into [Informatii Zbor](IDCursa,Ora,StareVreme,ProcentCombustibil,ProcentDistanta,Locatia)
values
(
	1,'17:00','noros',70,45,'Polonia'
),
(
	2,'1:00','buna',30,80,'Belgia'
),
(
	3,'00:00','noros',45,25,'Olanda'
),
(
	4,'6:00','buna',50,75,'Austria'
),
(
	5,'14:30','buna',34,50,'Romania(Arges)'
),
(
	6,'7:00','precipitatii reduse',30,60,'Romania(Valcea)'
),
(
	7,'6:00','noros',45,20,'Romania(Vrancea)'
),
(
	1,'19:00','buna',40,80,'Germania'
),
(
	2,'1:30','noros',20,95,'Franta'
),
(
	3,'4:45','precipitatii reduse',30,89,'Londra'
),
(
	4,'8:30','buna',30,90,'Germania'
),
(
	5,'15:00','buna',20,95,'Romania(Bucuresti)'
),
(
	6,'7:20','noros',10,90,'Romania(Bucuresti)'
),
(
	7,'7:50','buna',20,92,'Romania(Bucuresti)'
)

insert into [Militar](Nume, Prenume,CNP,Data_Nastere,Sex,Oras,Judet,Adresa,NumarTelefon)
values
(
	'Florescu','Andrei','1940327439456','1994-03-27','masculin','Sector 3','Bucuresti','Str. Soarelui, nr.1',40746064503
),
(
	'Roman','Tudor','1910905133137','1991-09-05','masculin','Medgidia','Constanta','Str. General, nr.89',40774383392
),
(
	'Siciu','Marian','1980416449064','1998-04-16','masculin','Sector 4','Bucuresti','Str. Emanuel, nr.1',40727371164
),
(
	'Florea','Sorin','1910811129414','1991-07-11','masculin','Cluj-Napoca','Cluj','Str. Alverna, nr.2',40742266517
),
(
	'Soare','Radu','1870716100221','1987-06-16','masculin','Buzau','Buzau','Str. Miron, nr.45',40744513618
),
(
	'Radulescu','Robert','1930921059695','1993-09-21','masculin','Oradea','Bihor','Str. Rasarit, nr.22',40722737856
),
(
	'Neacsu','Alexandra','2890103076661','1989-01-03','feminin','Stefanesti','Botosani','Str. Muncii, nr.2',40740507090
),
(
	'Tudorache','Sorina','2890417322431','1989-05-17','feminin','Medias','Sibiu','Str. Aleru, nr.3',40724572055
),
(
	'Popescu','Roberto','1891016402888','1989-10-16','masculin','Sector 1','Bucuresti','Str. Radu, nr.3',40742110378
),
(
	'Dumitrascu','Andreea','6020110354354','2002-01-10','feminin','Timisoara','Timis','Str. Flori, nr.1',40731199768
),
(
	'Mitran','Luca','1880920321221','1988-09-20','masculin','Sibiu','Sibiu','Str. Jean, nr.2',40764175572
),
(
	'Raducu','Vlad','1920518144686','1992-05-18','masculin','Sfantu Gheorghe','Covasna','Str. David, nr.4',40746148353
),
(
	'Demen','Erik','1970626412638','1997-06-26','masculin','Sector 1','Bucuresti','Str. Andrei, nr.45',40752343465
),
(
	'Ciusnel','Ciprian','5010428275311','2001-04-28','masculin','Roman','Neamt','Str. Pil, nr.6',40722690293
),
(
	'Predescu','Valeriu','1990303264328','1999-03-03','masculin','Reghin','Mures','Str. Eugen, nr.7',40744764183
),
(
	'Horea','Tudor','1980122336060','1998-01-22','masculin','Falticeni','Suceava','Str. Jon, nr.44',40744764183
)

insert into [GradMilitar](Denumire)
values
(
	'Sublocotenent'
),
(
	'Locotenent'
),
(
	'Capitan'
),
(
	'Locotenent comandor'
),
(
	'Capitan comandor'
),
(
	'Comandor'
),
(	
	'Sergent'
),
(
	'Sergent major'
),
(	
	'Plutonier'
),
(	
	'Plutonier major'
),
(	
	'Plutonier adjutant'
),
(	
	'Plutonier adjutant principal'
)

insert into [GradeMilitari](IDMilitar,IDGrad,Data1Perioada,Data2Perioada)
values
(
	1,2,'2022-01-05',null
),
(
	2,3,'2019-10-01',null
),
(
	3,1,'2020-11-03',null
),
(
	4,4,'2019-06-01',null
),
(
	5,5,'2016-03-17',null
),
(
	6,2,'2019-12-28',null
),
(
	7,10,'2016-05-05',null
),
(
	8,4,'2019-10-01',null
),
(
	9,4,'2019-11-01',null
),
(
	10,1,'2020-04-13',null
),
(
	11,11,'2019-05-07',null
),
(
	12,3,'2018-05-07',null
),
(
	13,10,'2020-05-14',null
),
(
	14,7,'2021-03-13',null
),
(
	15,1,'2022-02-02',null
),
(
	16,2,'2022-01-02',null
)

insert into [Functie](Denumire)
values
(
	'Pilot'
),
(
	'Copilot'
),
(
	'Inginer'
),
(
	'Infanterie'
)

insert into [FunctiiMilitari](IDMilitar,IDFunctie,DataNumiriiinFunctie,DataIesiriidinFunctie)
values
(
	1,1,'2022-01-05',null
),
(
	2,2,'2019-10-01',null
),
(
	3,3,'2020-11-03',null
),
(
	4,4,'2019-06-01',null
),
(
	5,4,'2016-03-17',null
),
(
	6,4,'2019-12-28',null
),
(
	7,1,'2016-05-05',null
),
(
	8,1,'2019-10-01',null
),
(
	9,2,'2019-11-01',null
),
(
	10,2,'2020-04-13',null
),
(
	11,3,'2019-05-07',null
),
(
	12,4,'2018-05-07',null
),
(
	13,4,'2020-05-14',null
),
(
	14,4,'2021-03-13',null
),
(
	15,4,'2022-02-02',null
),
(
	16,4,'2022-01-02',null
)

insert into [Unitate Militara](Denumire,Oras,Tara)
values
(
	'Escadrila 142 Cercetare','','Romania'
),
(
	'Flotila 95 Aeriană','','Romania'
),
(
	'Flotila 71 Aeriană','','Romania'
),
(
	'Flotila 86 Aeriană','','Romania'
),
(
	'Flotila 90 Transport Aerian','','Romania'
),
(
	'Baza aeriană 105 Évreux-Fauville','Eure','Franta'
),
(
	'Baza aeriană 106 Bordeaux-Mérignac','Bordeaux','Franta'
),
(
	'Baza Aeriană Nörvenich','Nörvenich','Germania'
),
(
	'Tactical Air Force Wing 71 "Richthofen"','Wittmundhafen','Germania'
),
(
	'Tactical Air Force Wing 73 "Steinhoff"','Laage','Germania'
)

insert into [Unitati Militare Militari](IDMilitar,IDUnitateMilitara,Data1Perioada,Data2Perioada)
values
(
	1,1,'2022-01-05',null
),
(
	2,2,'2019-10-01',null
),
(
	3,3,'2020-11-03',null
),
(
	4,4,'2019-06-01',null
),
(
	5,5,'2016-03-17',null
),
(
	6,1,'2019-12-28',null
),
(
	7,2,'2016-05-05',null
),
(
	8,3,'2019-10-01',null
),
(
	9,4,'2019-11-01',null
),
(
	10,5,'2020-04-13',null
),
(
	11,1,'2019-05-07',null
),
(
	12,2,'2018-05-07',null
),
(
	13,3,'2020-05-14',null
),
(
	14,4,'2021-03-13',null
),
(
	15,5,'2022-02-02',null
),
(
	16,1,'2022-01-02',null
)

insert into [Misiune](IDAvion,Denumire,DataPlecarii,DataSosirii,OraPlecarii,OraSosirii,IDUnitateMilitaraPlecare,IDUnitateMilitaraSosire)
values
(
	8,'Alpha','2022-02-01','2022-02-01','15:00','21:00',1,6
),
(
	9,'Betta','2022-03-22','2022-03-23','21:00','01:30',2,7
),
(
	10,'Tetta','2022-04-23','2022-04-24','23:00','05:00',3,8
),
(
	11,'Coanda','2022-06-11','2022-06-11','03:00','09:00',4,9
),
(
	12,'General','2022-05-11','2022-05-11','14:00','15:00',5,10
),
(
	13,'Tiger','2022-11-12','2022-11-12','05:00','07:30',1,7
),
(
	14,'Scorpion','2022-07-01','2022-07-01','5:45','8:00',2,8
),
(
	15,'Vanatori','2022-02-01','2022-02-01','15:00','21:00',3,9
),
(
	16,'Sigma','2022-03-22','2022-03-23','21:00','01:30',4,10
),
(
	17,'Radu','2022-04-23','2022-04-24','23:00','05:00',1,8
),
(
	18,'Delta','2022-06-11','2022-06-11','03:00','09:00',2,10
)

insert into [Militari per Misiune](IDMilitar,IDMisiune)
values
(
	1,1
),
(
	1,4
),
(
	1,7
),
(
	1,8
),
(
	2,1
),
(
	3,2
),
(
	4,3
),
(
	5,4
),
(
	6,5
),
(
	7,2
),
(
	7,5
),
(
	7,9
),
(
	7,10
),
(
	8,3
),
(
	8,6
),
(
	8,11
),
(
	9,1
),
(
	10,2
),
(
	11,3
),
(
	12,4
),
(
	13,5
),
(
	14,6
),
(
	15,7
),
(
	16,8
)

insert into [RaportM Zbor](IDMisiune,Ora,StareVreme,ProcentCombustibil,ProcentDistanta,Locatia)
values
(
	1,'17:00','buna',80,20,'Ungaria'
),
(
	2,'00:00','precipitatii',70,10,'Ungaria'
),
(
	3,'00:00','buna',80,20,'Ucraina'
),
(
	4,'04:00','precipitatii',90,20,'Ucraina'
),
(
	5,'15:00','buna',90,10,'Ungaria'
),
(
	6,'06:00','precipitatii',78,20,'Croatia'
),
(
	7,'6:00','precipitatii',89,30,'Cehia'
),
(
	8,'16:00','noros',60,20,'Ungaria'
),
(
	9,'02:00','noros',60,10,'Ungaria'
),
(
	10,'00:00','noros',70,30,'Polonia'
),
(
	11,'04:00','buna',90,20,'Polonia'
)


use [SistemControlTraficAerian2]
--1.Afiseaza numele angajatilor civili care au functie de pilot precum si id-ul zborului in care se afla
SELECT ac.IDAngajat_Civil ,ac.Nume+  ' ' + ac.Prenume as NumeAngajat , c.IDCursa 
from [Angajat Civil] as ac inner join [Functii Angajati Civili] as fac
on fac.IDAngajat_Civil=ac.IDAngajat_Civil inner join [AngajatiC per Cursa] as apc
on ac.IDAngajat_Civil=apc.IDAngajat_Civil inner join [Functie Civila] as fc
on fc.IDFunctie=fac.IDFunctie inner join Cursa as c
on c.IDCursa=apc.IDCursa
where fc.[Denumire Functie] like 'Pilot'

--2.Sa se afiseze toti pasagerii care au cumparat un bilet pentru zborul cu ID 2 precum si pretul si firma de zbor
SELECT p.Nume + ' ' + p.Prenume as NumePasager , b.Pret, fz.Denumire
from Pasager as p inner join Bilet as b
on p.IDBilet=b.IDBilet inner join Cursa as c
on b.IDCursa=c.IDCursa inner join [Firma Zbor] as fz
on fz.IDFirma_Zbor=b.IDFirma_Zbor
where c.IDCursa=2

--3.Sa se afiseze toti militarii din misiunea Delta si id-ul avionului 
SELECT m.Nume + ' ' + m.Prenume as NumeMilitar,  a.IDAvion
from Militar as m inner join [Militari per Misiune] as mpm
on m.IDMilitar=mpm.IDMilitar inner join Misiune as mi
on mi.IDMisiune=mpm.IDMisiune inner join Avion as a
on a.IDAvion=mi.IDAvion
where mi.Denumire like 'Delta'

--4.Sa se afiseze marca si modelul avionului folosit in misiunea 'Alpha' si unitatea militara de unde a avut loc plecarea
SELECT mmt.Marca, mmt.Model, um.Denumire
from Misiune as m inner join Avion as a
on m.IDAvion=a.IDAvion inner join [MarcaModelTip Avion] as mmt
on mmt.IDMMT=a.IDMMT inner join [Unitate Militara] as um
on um.IDUnitateMilitara=m.IDUnitateMilitaraPlecare
where m.Denumire like 'Alpha'

--5.Afisati numarul de misiuni , grupate dupa anul in care au fost inregistrate
SELECT year(m.DataPlecarii) as AnMisiune, count(*) as NumarMisiuni
from Misiune as m
group by year(m.DataPlecarii)

--6.Afisati numarul de pasageri din fiecare cursa , impreuna cu id avionului
SELECT c.IDCursa, a.IDAvion, count(*) as NumarPasageri
from Pasager as p inner join Bilet as b
on p.IDBilet=b.IDBilet inner join Cursa as c
on c.IDCursa=b.IDCursa inner join Avion as a
on a.IDAvion=c.IDAvion
group by c.IDCursa , a.IDAvion

--7.Sa se afiseze toate zborurile civile din anul 2022
SELECT min(c.IDCursa) as IdCURSA, year(c.DataPlecarii) as Anul, COUNT(*) as NrZboruri
from Cursa as c
group by year(c.DataPlecarii)
having year(c.DataPlecarii)=2022

--8.Sa se afiseze nr de angajati care sunt incadrati pe functia de Mecanic Aeronave
SELECT fac.IDFunctie, COUNT(*) as NrAngajatiFunctie
FROM [Functii Angajati Civili] as fac inner join [Functie Civila] as f
on fac.IDFunctie=f.IDFunctie
Group by fac.IDFunctie, f.[Denumire Functie]
having f.[Denumire Functie]='Mecanic Aeronave'

--9.Afisati numarul de avioane din categoria militar de vanatoare
SELECT count(*)
from Avion as a inner join [MarcaModelTip Avion] as mmt
on a.IDMMT = mmt.IDMMT 
where mmt.Tip='militar de vanatoare'
group by a.IDAvion

--10.Afisati id ul curselor grupate pe categoriile avionelor
SELECT DISTINCT mmt.Tip, c.IDCursa 
from Cursa as c inner join Avion as a
on c.IDAvion=a.IDAvion inner join [MarcaModelTip Avion] as mmt
on a.IDMMT=mmt.IDMMT
group by mmt.Tip, c.IDCursa

--11.Afisati pasageri grupati in functie de tipul biletului pe care il au
SELECT b.Tip, p.Nume
FROM Pasager as p inner join Bilet as b
on p.IDBilet=b.IDBilet
Group by b.Tip, p.Nume

--12.Selectati in ordine descrescatoare id - ul avionului dupa capacitatea unui avion
SELECT a.IDAvion, mmt.CapacitateMaxima
from Avion as a inner join [MarcaModelTip Avion] as mmt
on a.IDMMT=mmt.IDMMT
group by a.IDAvion , mmt.CapacitateMaxima
order by mmt.CapacitateMaxima DESC

--13.Afisati tarile cu un singur aeroport la care se realizeaza o cursa
SELECT a.Denumire, a.Tara
from Aeroport as a inner join Cursa as c
on a.IDAeroport=c.IDAeroportPlecare
group by a.Denumire, a.Tara
having count(*)=1

--14.Afisati avioanele cu mai putin de 50 de pasageri dintr o cursa
SELECT a.IDAvion
from Avion as a inner join Cursa as c
on a.IDAvion=c.IDAvion inner join Bilet as b
on b.IDCursa=c.IDCursa inner join Pasager as p
on p.IDBilet=b.IDBilet
group by a.IDAvion
having COUNT(p.IDPasager)<=50

--15.Sa se afiseze cel mai mare si mai mic al unui bilet
SELECT min(Bilet.Pret) as 'Pretul cel mai mic' , max(Bilet.Pret) as 'Pretul cel mai mare'
from Bilet

--16.Afisati pretul mediu al unui bilet la clasa 1
SELECT AVG(Bilet.Pret) as 'Pret mediu'
from Bilet
where Bilet.Tip like 'I'

--17.Afisati media de varsta din cursa din aeroportul 'Henri Coanda'
with PasageriHC as
(
	SELECT p.Varsta
	from Pasager as p inner join Bilet as b
	on p.IDBilet=b.IDBilet inner join Cursa as c
	on b.IDCursa=c.IDCursa inner join Avion as a
	on a.IDAvion=c.IDAvion inner join Aeroport as aer
	on aer.IDAeroport=c.IDAeroportSosire 
	where c.IDAeroportPlecare like 'Aeroportul international "Henri Coanda"'
)
SELECT AVG(Varsta) as 'Media de varsta'
from PasageriHC

--18.Afisati cate curse a avut firma Wizz Air in anul 2022
with CurseWizz as
(
	SELECT c.IDCursa
	from Bilet as b inner join Cursa as c
	on b.IDCursa=c.IDCursa inner join [Firma Zbor] as fz
	on b.IDFirma_Zbor=fz.IDFirma_Zbor 
	where fz.Denumire like 'Wizz Air'
)

SELECT Count(*) as 'Curse'
from CurseWizz

--19.Afisati numarul de rapoarte in care vremea este ploioasa si procentul distantei se afla intre 10 si 90
with Rap as
(
	SELECT [RaportM Zbor].IDRaport
	from [RaportM Zbor]
	where [RaportM Zbor].StareVreme like 'noros' and [RaportM Zbor].ProcentCombustibil >=10 and [RaportM Zbor].ProcentCombustibil <=90
)

SELECT Count(*) as 'Nr Rapoarte'
from Rap

--20.Afisati nr misiunilor in care procentul combustibilului este 10 la suta cand procentul distantei este maxim
with Mis as
(
	SELECT Misiune.Denumire
	from [RaportM Zbor] inner join Misiune
	on [RaportM Zbor].IDMisiune=Misiune.IDMisiune
	where [RaportM Zbor].ProcentCombustibil = 30 and [RaportM Zbor].ProcentDistanta = 100
)
SELECT Count(*) as 'Nr Misiuni'
from Mis

--21.Afisati numele si prenumele militarilor din misiunea "Betta" 
SELECT Militar.Nume , Militar.Prenume
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Misiune.Denumire like 'Betta'

--22.Afisati functiile militarilor si numele acestora din unitatea militara 'Escadrila 142 Cercetare'
SELECT Militar.Nume , Functie.Denumire
from Militar
inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDMilitar=Militar.IDMilitar
inner join [Unitate Militara] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara
inner join [FunctiiMilitari] on [FunctiiMilitari].IDMilitar=Militar.IDMilitar
inner join [Functie] on [Functie].IDFunctie=[FunctiiMilitari].IDFunctie
where [Unitate Militara].Denumire like 'Escadrila 142 Cercetare'


--23.Sa se selecteze toate misiunile dupa 01 mai 2022
SELECT Misiune.Denumire
from Misiune
where DataPlecarii>'2022-05-01'

--24.Sa se afiseze numele si gradele militarilor , ordonate dupa data numirii
SELECT Militar.Nume , GradMilitar.Denumire, GradeMilitari.Data1Perioada
from Militar
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGradeMilitari
order by GradeMilitari.Data1Perioada ASC

--25.Sa se afiseze toti pilotii civili
SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume
from [Angajat Civil]
inner join [Functii Angajati Civili] on [Angajat Civil].IDAngajat_Civil=[Functii Angajati Civili].IDAngajat_Civil
inner join [Functie Civila] on [Functii Angajati Civili].IDFunctie=[Functie Civila].IDFunctie
where [Functie Civila].[Denumire Functie] like 'Pilot'

--26.Sa se afiseze pilotul si misiunea la care participa(misiunile ordonate alfabetic)
SELECT Militar.Nume, Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join [Misiune] on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join [FunctiiMilitari] on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join [Functie] on Functie.IDFunctie=FunctiiMilitari.IDFunctie
where Functie.Denumire like 'Pilot'
order by Misiune.Denumire 

--27.Sa se afiseze numele si prenumele pilotilor si pasagerii acestora , primii 10 pasageri, ordonate dupa numele pilotilor
SELECT top(10) [Angajat Civil].Nume, [Angajat Civil].Prenume, Pasager.Nume
from [Angajat Civil]
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join Cursa on Cursa.IDCursa=[AngajatiC per Cursa].IDCursa
inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
inner join Pasager on Pasager.IDBilet=Bilet.IDBilet
inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
where [Functie Civila].[Denumire Functie] like 'Pilot'
order by [Angajat Civil].Nume

--28.Sa se afiseze rapoartele de zbor din misiunea 'Sigma' si pilotul acesteia
SELECT [RaportM Zbor].IDRaport,[RaportM Zbor].Ora,[RaportM Zbor].ProcentCombustibil,[RaportM Zbor].ProcentDistanta,[RaportM Zbor].StareVreme , Militar.Nume, Militar.Prenume
from [RaportM Zbor]
inner join Misiune on Misiune.IDMisiune=[RaportM Zbor].IDMisiune
inner join [Militari per Misiune] on [Militari per Misiune].IDMisiune=Misiune.IDMisiune
inner join Militar on Militar.IDMilitar=[Militari per Misiune].IDMilitar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=[FunctiiMilitari].IDFunctie
where Functie.Denumire like 'Pilot' and Misiune.Denumire like 'Sigma'

--29.Sa se afiseze militarii si avioanele in care se afla, ordonate dupa numele avioanelor
SELECT Militar.Nume, Militar.Prenume , [MarcaModelTip Avion].Marca
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join [Misiune] on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join [Avion] on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
order by [MarcaModelTip Avion].Marca

--30.Sa se afiseze pasagerii cu bilete la clasa I si varsta lor
SELECT Pasager.Nume, Pasager.Prenume, pasager.Varsta
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
where bilet.Clasa like 'I'

--31.Sa se afiseze numele prenumele varsta angajatilor de la firma 'Tarom'
SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume , DATEDIFF(year,[Angajat Civil].Data_Nastere, '2022-05-09')
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
where [Firma Zbor].Denumire like 'Tarom'

--32.Sa se afiseze toti pasagerii cu bilet la clasa a doua si avionul de zbor
SELECT Pasager.Nume, Pasager.Prenume , [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model
from Pasager
inner join Bilet on bilet.IDBilet=Pasager.IDBilet
inner join Cursa on bilet.IDCursa=Cursa.IDCursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Bilet.Clasa like 'II'

--33.Sa se afiseze pasagerii care nu au bilet in lunile ianuarie , februarie sau martie si numele diferit de Andrei
SELECT Pasager.Nume, Pasager.Prenume
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
where not (DATEPART(MONTH,Cursa.DataPlecarii) between 1 and 3)
and not Pasager.Prenume='Andrei'

--34.Sa se afiseze pilotii militari al caror nume incepe cu N si misiunile in 2022
SELECT Militar.Nume, Militar.Prenume , Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Militar.Nume like 'N%' and DATEPART(year,Misiune.DataPlecarii)='2022'

--35.Sa se afiseze militarii al caror nume se termina cu U si au varsta intre 20 si 40 de ani
SELECT *
from Militar
where Militar.Nume like '%u'
and DATEDIFF(year, Militar.Data_Nastere,'2022-05-09') between 20 and 30


--36.Sa se afiseze unitatea militara al militarilor care au un nume care are pe a doua pozitie caracterul o sau e
SELECT [Unitate Militara].Denumire, Militar.Nume, Militar.Prenume
from [Unitate Militara]
inner join [Unitati Militare Militari] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara
inner join Militar on Militar.IDMilitar=[Unitati Militare Militari].IDMilitar
where Militar.Nume like '_e%' or Militar.Nume like '_o%'

--37.Sa se afiseze militarii care sunt intr o misiune ce contine 'et', ordonati dupa numele militarului
SELECT Militar.Nume, militar.Prenume, Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Misiune.Denumire like '%et%' 

 --38.Sa se afiseze angajatii civili al caror nume incepe cu 'P' si se termica cu 'A' si a caror data de nastere nu este in zilele pare
 SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume, [Angajat Civil].Data_Nastere
 from [Angajat Civil]
 where [Angajat Civil].Nume like 'L%u' and datepart(d, [Angajat Civil].Data_Nastere) not in (2,4,6,8,10,12,14,16,18,20,22,24,26,28,30)
 
 --39.Sa se afiseze numarul de pasageri din avionele al caror model incepe cu litera A
 SELECT count(distinct Pasager.Nume), [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model
 from Pasager
 inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
 inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
 inner join Avion on Avion.IDAvion=Cursa.IDAvion
 inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
 where [MarcaModelTip Avion].Model like 'A%'
 group by [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model

 --40.Sa se afiseze militarii care zboara cu avioane de vanatoare
 SELECT Militar.Nume, Militar.Prenume , [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model, [MarcaModelTip Avion].Tip
 from Militar
 inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
 inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
 inner join Avion on Misiune.IDAvion=avion.IDAvion
 inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=avion.IDMMT
 where [MarcaModelTip Avion].Tip like 'militar de vanatoare'

 --41.Sa se afiseze numele si prenumele inginerilor militari din misiuni ordonati dupa misiuni
SELECT Militar.Nume, Militar.Prenume, Functie.Denumire, Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
where Functie.Denumire like 'Inginer'
order by Misiune.Denumire

--42.Sa se afiseze numele si prenumele pasagerilor cu varsta intr 20 si 30 care au ca pilot pe Vascan Teodor
SELECT Pasager.Nume, Pasager.Prenume
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join [AngajatiC per Cursa] on Cursa.IDCursa=[AngajatiC per Cursa].IDCursa
inner join [Angajat Civil] on [Angajat Civil].IDAngajat_Civil=[AngajatiC per Cursa].IDAngajat_Civil
where [Angajat Civil].Nume like 'Vascan' and Pasager.Varsta between 20 and 30

--43.Sa se afiseze numele militarilor grupati dupa avioane
SELECT distinct [MarcaModelTip Avion].Marca, Militar.Nume, Militar.Prenume
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
group by [MarcaModelTip Avion].Marca, Militar.Nume, Militar.Prenume

--44.Sa se afiseze numele , prenumele , CNP-ul , functia si numarul total de misiuni al fiecarui militar
SELECT Militar.Nume, Militar.Prenume, Militar.CNP, Functie.Denumire , count([Militari per Misiune].IDMisiune) as 'Numar de misiuni'
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
group by Militar.Nume, Militar.Prenume, Militar.CNP, Functie.Denumire

--45.Sa se afiseze pilotii care au pasageri cu varsta cuprinsa intre 30 si 40 si numarul de telefon care incepe cu 0774 si avionul pe care il conduc
SELECT distinct [Angajat Civil].Nume, [Angajat Civil].Prenume, Pasager.Nume, Pasager.Prenume, Pasager.Varsta, Pasager.NumarTelefon , [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model
from [Angajat Civil]
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join Functie on Functie.IDFunctie=[Functii Angajati Civili].IDFunctie
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join Cursa on Cursa.IDCursa=[AngajatiC per Cursa].IDCursa
inner join Avion on avion.IDAvion=Cursa.IDAvion
inner join Bilet on Bilet.IDCursa=Bilet.IDCursa
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
inner join Pasager on Pasager.IDBilet=Bilet.IDBilet
where (Pasager.Varsta between 30 and 40) and Pasager.NumarTelefon like '40774%' and Functie.Denumire like 'Pilot'
group by [Angajat Civil].Nume, [Angajat Civil].Prenume, Pasager.Nume, Pasager.Prenume, Pasager.Varsta, Pasager.NumarTelefon,[MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model

--46.Sa se afiseze ziua , luna , anul pe coloane diferit a primilor 10 angajati civili care indeplinesc conditiile: sa nu fie nascuti intr o luna para si sa fie nascuti intr o zi intre 10 si 20
SELECT top(10) [Angajat Civil].Nume , [Angajat Civil].Prenume, DATEPART(day, [Angajat Civil].Data_Nastere) as 'Ziua de nastere', DATEPART(month, [Angajat Civil].Data_Nastere) as 'Luna de nastere', DATEPART(year, [Angajat Civil].Data_Nastere) as 'Anul de nastere'
from [Angajat Civil]
where DATEPART(month, [Angajat Civil].Data_Nastere) not in(2,4,6,8,10,12) and DATEPART(day,[Angajat Civil].Data_Nastere) between 10 and 20

--47.Sa se afiseze in ce data a avut loc majoratul militarilor 
SELECT Militar.Nume, Militar.Prenume, dateadd(year, 18, Data_Nastere) as 'data majorat'
from Militar

--48.Sa se afiseze militarii si cate zile au trecut de la data nasterii acestora
SELECT Militar.Nume, Militar.Prenume, DATEDIFF(day, Militar.Data_Nastere, GETDATE()) as 'Zile de la nastere'
from Militar

--49.Sa se afiseze angajatii civili si vechimea lor in firma cea mai recent lucrata
SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume, DATEDIFF(day,[Firme Angajati Civili].Data_Angajare, '2022-05-09') as 'Zile lucrate'
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil 
where [Firme Angajati Civili].Data_Plecarii is null


--50.Sa se afiseze toti pasagerii al caror nume incepe cu litera 'A', 'B' si 'C' folosind functia ASCII
SELECT Pasager.Nume, Pasager.Prenume,ASCII('A') as A, ASCII('B') as B, ASCII('C') as C
from Pasager
where ASCII(Pasager.Nume) in (65,66,67)

--51.Sa se codifice ziua , luna si anul de nastere al angajatilor civili  in fucntie de caracterul corespunzator din tabela ascii
SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume, CHAR(DATEPART(day,Data_Nastere)%255) as 'Ziua de Nastere', CHAR(DATEPART(month,Data_Nastere)%255) as 'Luna de Nastere', CHAR(DATEPART(year,Data_Nastere)%255) as 'Anul de Nastere'
from [Angajat Civil]

 --52.Sa se afiseze militarii in ordine descrescatoare a lungimii numelui si a prenumelui
 SELECT Militar.Nume, Militar.Prenume, LEN(Militar.Nume)+LEN(Militar.Prenume) as 'Lungime nume+prenume'
 from Militar
 order by LEN(Militar.Nume)+len(Militar.Prenume) DESC

 --53.Sa se dubleze initialele numelui si prenumelui pasagerilor
 SELECT REPLICATE(LEFT(pasager.Nume,1),2)+REPLICATE(LEFT(Pasager.Prenume,1),2) as '2xnume_2xprenume'
 from Pasager

 --54.Sa se afiseze invers numele pilotilor militari cat si inversul modelul de avion pe care il conduc in misiuni
 SELECT REVERSE(Militar.Nume) , REVERSE([MarcaModelTip Avion].Model)
 from Militar
 inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
 inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
 inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
 inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
 inner join Avion on Avion.IDAvion=Misiune.IDAvion
 inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
 where Functie.Denumire like 'Pilot'


 --55.Sa se afiseze toate firmele de zbor si cati angajati au 
 SELECT [Firma Zbor].Denumire, count([Angajat Civil].Nume) as 'Numar angajati'
 from [Firma Zbor],[Angajat Civil]
 inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
 where [Firme Angajati Civili].IDFirma_Zbor=[Firma Zbor].IDFirma_Zbor
 group by [Firma Zbor].Denumire

 --56.Sa se afiseze pilotii civili si cati pasageri au acestia
 SELECT [Angajat Civil].Nume, count(Pasager.Nume) as 'Numar de pasageri'
 from [Angajat Civil]
 inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
 inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
 inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
 inner join Cursa on Cursa.IDCursa=[AngajatiC per Cursa].IDCursa
 inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
 inner join Pasager on Pasager.IDBilet=Bilet.IDBilet
 where [Functie Civila].[Denumire Functie] like 'Pilot'
 group by [Angajat Civil].Nume

 --57.Sa se afiseze media de varsta a pasagerilor din zborul catre 'Aeroportul internationa "Charles de Gaulle"'
 SELECT AVG(Pasager.Varsta)
 from Pasager
 inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
 inner join Cursa on Bilet.IDCursa=Cursa.IDCursa
 inner join Aeroport on Aeroport.IDAeroport=Cursa.IDAeroportSosire
 where Aeroport.Denumire like 'Aeroportul internationa "Charles de Gaulle"'

 --58.Sa se afiseze	cati angajati civili au fost nascuti grupati dupa anul nasterii si ordinea descrescatoare
SELECT YEAR([Angajat Civil].Data_Nastere) as 'Anul nasterii', COUNT([Angajat Civil].Nume) as 'Numar angajati nascuti'
from [Angajat Civil]
group by year([Angajat Civil].Data_Nastere)
order by count([Angajat Civil].Nume) DESC

--59.Sa se afiseze numarul de zboruri pe anul 2022 in zilele impare
SELECT DATEPART(day, Cursa.DataPlecarii) as 'Ziua plecarii',
count(distinct(Cursa.DataPlecarii))
from Cursa
group by DATEPART(day, cursa.DataPlecarii)
having DATEPART(day, Cursa.DataPlecarii) in(1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31)

--60.Sa se afiseze cati pasageri au numele incepand cu 'A'-'E' grupati dupa varsta.Sortati desc dupa numarul de pasageri
SELECT Pasager.Varsta , count(*) as 'Numar pasageri'
from Pasager
where Pasager.Nume between 'A' and 'E'
group by Varsta
order by count(*) DESC

--61.Sa se creeze o expresie care afiseaza pasagerii, avionul cursei, pilotul acestuia si denumirea aeroportului destinatie
WITH CTE5
as
(
	SELECT distinct Pasager.Nume+' '+Pasager.Prenume as 'Nume Prenume Pasager', [MarcaModelTip Avion].Marca +' '+[MarcaModelTip Avion].Model as 'Marca Model Avion', [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume PILOT', Aeroport.Denumire
	from Pasager
	inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
	inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
	inner join Avion on Avion.IDAvion=Cursa.IDAvion
	inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
	inner join Aeroport on Aeroport.IDAeroport=Cursa.IDAeroportSosire
	inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDCursa=Cursa.IDCursa
	inner join [Angajat Civil] on [Angajat Civil].IDAngajat_Civil=[AngajatiC per Cursa].IDAngajat_Civil
	inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
	inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
	where [Functie Civila].[Denumire Functie] like 'Pilot'
)
select * from CTE5

--62.Sa se creeze o expresie care afiseaza cel mai ieftin bilet pe curse
WITH CTE6(ID_CURSA,[Pret minim])
as
(
	SELECT Cursa.IDCursa as 'ID_CURSA', min(Bilet.Pret) as 'Pret minim'
	from Bilet
	inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
	group by Cursa.IDCursa
)
SELECT * from CTE6

--63.Sa se creeze o expresie care sa afiseze grupat pe luna cate curse sunt 
WITH CTE7(Luna_Cursa, Numar)
as
(
	SELECT convert(varchar(40),month(Cursa.DataPlecarii),6),count(*)
	from Cursa
	group by Month(Cursa.DataPlecarii)
	having count(*)>=1
)
SELECT * from CTE7

--64.Sa se creeze o expresie ce afiseaza numele si prenumele inginerilor militari din misiuni ordonati dupa misiuni
with CTE8(Nume, Prenume, Functie, Misiune)
as
(
	SELECT Militar.Nume, Militar.Prenume, Functie.Denumire, Misiune.Denumire
	from Militar
	inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
	inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
	inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
	inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
	where Functie.Denumire like 'Inginer'
	
)
SELECT * from CTE8
order by cte8.Misiune 

--65.Sa se creeze o expresie care afiseaza numele prenumele angajatilor civili de la firma 'Emirates' si varsta acestora
with CTE9(Nume, Prenume, Varsta, Firma)
as
(
	SELECT [Angajat Civil].Nume, [Angajat Civil].Prenume , DATEDIFF(year,[Angajat Civil].Data_Nastere, '2022-05-09'), [Firma Zbor].Denumire
	from [Angajat Civil]
	inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
	inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
	where [Firma Zbor].Denumire like 'Emirates'
)
select * from CTE9

--66.Sa se verifice exista unei coloane
IF EXISTS(SELECT*FROM INFORMATION_SCHEMA.COLUMNS WHERE COLUMN_NAME='IDCursa')
BEGIN
PRINT'EXISTA'
END

--67.Sa se verifice exista unei tabele
IF EXISTS(SELECT* FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME='Functie')
BEGIN
PRINT'Exista'
END

--68.Sa se modifice tipul orei de plecare din Cursa in varchar(50) si sa ii se puna constragere sa nu fie NULL.
ALTER TABLE Cursa
ALTER COLUMN Oraplecarii VARCHAR(50) NOT NULL
SELECT *
FROM Cursa

--69.Sa se adauge o coloana noua in tabela Functie cu urmatoarele constrangeri: sa nu existe camp NULL si valoarea default sa fie =’Fara functie’
ALTER TABLE Functie
ADD Functie VARCHAR(30) NOT NULL DEFAULT 'FARA FUNCTIE'
GO
SELECT *
FROM Functie

--70.Sa se stearga coloana adaugata in tabela.?
ALTER TABLE Functie
DROP COLUMN Functie.Functie


--71.Sa se creeze o tranzactie in care sa inserati un rand in tabela militar.Tratati cazurile de eroare.
begin try
	begin tran;
		set identity_insert.Militar on
		INSERT INTO Militar(IDMilitar,Nume,Prenume,CNP,Data_Nastere,Sex,Oras,Judet,Adresa,NumarTelefon)
		values(13,'Salcie','Mirel','1720416449064','1972-04-16','masculin','Slatioara','Olt','Str. Mircea, nr.44', 40799190087)
		set identity_insert.Militar off;
	commit tran;
end try

begin catch
	if ERROR_NUMBER()=2627
	begin
		print'Primary Key Violation';
	end
	else if ERROR_NUMBER()=547
	begin
		print'Constraint violation';
	end
	else
	begin
		print'Unhandled error';
	end
	if @@TRANCOUNT>0 rollback transaction;
end catch

--72.Sa se creeze o tranzactie in care sa se insereze 2 randuri in tabela pasager . Tratati cazurile de eroare (2)
DECLARE @errnum as int;

begin tran;
	set IDENTITY_INSERT.Pasager on;
	insert into Pasager(IDPasager,Nume, Prenume,Varsta,NumarTelefon,IDBilet)
	values(1,'Marin','Radu',45,4074566892,2);

	set @errnum = @@ERROR;
	if @errnum <>0
	begin
		if @@TRANCOUNT > 0 ROLLBACK tran;
		print'Insert failed'+cast(@errnum as varchar);
	end;
	INSERT INTO Pasager(IDPasager,Nume, Prenume,Varsta,NumarTelefon,IDBilet)
	VALUES(50, 'Silviu','Andrei', 33,4074566891,3);
	SET @errnum = @@ERROR;
	IF @errnum <> 0
	BEGIN
		IF @@TRANCOUNT > 0 ROLLBACK TRAN;
		PRINT 'Insert2 failed'+ CAST(@errnum AS VARCHAR);
	END;
	SET IDENTITY_INSERT.Pasager OFF;
	IF @@TRANCOUNT > 0 COMMIT TRAN;

--73.Sterge randul inserat
	DELETE from Pasager where IDPasager=50;
	print'DELETED'+ cast(@@rowcount as varchar)+'rows';

--74-75.Creeaza o tranzactie in care sa se realizeze o modificare si una pentru insertie .Tratati cazurile de eroare
begin try
	begin tran;
		--set identity_insert.Aeroport on
		INSERT INTO Aeroport(IDAeroport,Denumire,Oras,Tara)
		values(11,'Aeroportul international Maadrid','Madrid','Spania');

		select * from Aeroport where IDAeroport=11;
			begin tran
			select @@TRANCOUNT;

			update Aeroport
			set Denumire='Aeroportul international Miguel'
			where IDAeroport=10

			select * from Aeroport where IDAeroport=11
			commit

		--set identity_insert.Aeroport off;
		select @@TRANCOUNT;
	commit tran;
end try

begin catch
	if ERROR_NUMBER()=2627
	begin
		print'Primary Key Violation';
	end
	else if ERROR_NUMBER()=547
	begin
		print'Constraint violation';
	end
	else
	begin
		print'Unhandled error';
	end
	if @@TRANCOUNT>0 rollback transaction;
end catch

--76.Sterge randul de mai sus inserat
delete from Aeroport where IDAeroport=11;
print'deleted '+ CAST(@@rowcount as varchar)+ ' rows';

--77.
begin try
	begin tran
	set identity_insert.[MarcaModelTip Avion] on
	select *from [MarcaModelTip Avion]
	INSERT INTO [MarcaModelTip Avion](IDMMT,Marca,Model,Tip,CapacitateMaxima)
		VALUES (19,'Airbus','A600','militar de transport',300)
	INSERT INTO [MarcaModelTip Avion](IDMMT,Marca,Model,Tip,CapacitateMaxima)
		VALUES (20,'Airbus','A336','civil',300)

	update [MarcaModelTip Avion]
	SET CapacitateMaxima=CapacitateMaxima+5
	where model='A336'


	select  CapacitateMaxima from [MarcaModelTip Avion]
	where Model='A336'
	
	set identity_insert.[MarcaModelTip Avion] off
	commit tran
end try

begin catch
	if ERROR_NUMBER()=2627
	begin
		print'Primary Key Violation';
	end
	else if ERROR_NUMBER()=547
	begin
		print'Constraint violation';
	end
	else
	begin
		print'Unhandled error';
	end
	if @@TRANCOUNT>0 rollback transaction;
end catch

--78.
begin try
	begin tran
	set identity_insert.Pasager on
	select MAX(Pasager.Varsta) from Pasager
	INSERT INTO Pasager( IDPasager,Nume, Prenume,Varsta, NumarTelefon,IDBilet)
		VALUES (15,'Sulger','Ramona',24,40774092666,5)
	INSERT INTO Pasager(IDPasager,Nume, Prenume,Varsta, NumarTelefon,IDBilet)
		VALUES (14,'Roma','Silviu',68,40775876123,6)

	  update Pasager
	  set Varsta='Dacia'
	  WHERE IDPasager=31
		
	select * from Pasager
	where IDPasager=31
	
	set identity_insert.Pasager off
	commit tran
end try
begin catch
	IF ERROR_NUMBER() = 2627 -- Duplicate key violation
	BEGIN
	PRINT 'Primary Key violation';
	END
	ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
	BEGIN
	PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
	PRINT 'Unhandled error';
	END;

end catch

--79.
begin try
	begin tran
	set identity_insert.Aeroport on
	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Lisabona','Lisabona','Portugalia')
	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Bruxelles','Bruxelles','Belgia')

	  update Aeroport
	  set Denumire='Aeroportul international "Zaventem"'
	  WHERE Oras='Bruxelles'
		
	select * from Aeroport
	where IDAeroport>5
	
	set identity_insert.Aeroport off
	commit tran
end try
begin catch
	if ERROR_NUMBER()=2627
	begin
		print'Primary Key Violation';
	end
	else if ERROR_NUMBER()=547
	begin
		print'Constraint violation';
	end
	else
	begin
		print'Unhandled error';
	end
	if @@TRANCOUNT>0 rollback transaction;
end catch

--80.(7)
begin try
	begin tran
	set identity_insert.[MarcaModelTip Avion] on

delete [MarcaModelTip Avion] from [MarcaModelTip Avion]
where [MarcaModelTip Avion].Model like 'A336'

	INSERT INTO [MarcaModelTip Avion](IDMMT,Marca,Model,Tip,CapacitateMaxima)
		VALUES (19,'Airbus','A779','militar de transport',300)

	SELECT *FROM [MarcaModelTip Avion]
	set identity_insert.[MarcaModelTip Avion] off
	commit tran
end try


begin catch
	if ERROR_NUMBER()=2627
	begin
		print'Primary Key Violation';
	end
	else if ERROR_NUMBER()=547
	begin
		print'Constraint violation';
	end
	else
	begin
		print'Unhandled error';
	end
	if @@TRANCOUNT>0 rollback transaction;
end catch

--81.(8)
begin try
	begin tran
	
	select * from [Functie Civila]
	
	INSERT INTO [Functie Civila](IDFunctie,[Denumire Functie])
	values
	(1078,'Paramedic')
	INSERT INTO [Functie Civila](IDFunctie,[Denumire Functie])
	values
	(1080,'Paza')

	select *from [Functie Civila]
	where IDFunctie=1080 and IDFunctie=1078

	commit tran
end try
begin catch
	IF ERROR_NUMBER() = 2627 -- Duplicate key violation
	BEGIN
	PRINT 'Primary Key violation';
	END
	ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
	BEGIN
	PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
	PRINT 'Unhandled error';
	END;

end catch

--82.(9)

begin try
	begin tran
	
	select *from Aeroport
	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Lisabona','Lisabona','Portugalia')

		begin tran
	update Aeroport
	SET Tara='Portugal'
	where Tara='Portugalia'

	commit 
	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Barcelona','Barcelona','Spania')

	commit tran
end try
begin catch
	IF ERROR_NUMBER() = 2627 -- Duplicate key violation
	BEGIN
	PRINT 'Primary Key violation';
	END
	ELSE IF ERROR_NUMBER() = 547 -- Constraint violations
	BEGIN
	PRINT 'Constraint violation';
	END
	ELSE
	BEGIN
	PRINT 'Unhandled error';
	END;

end catch

--83.(10).
begin tran
	

	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Lisabona','Lisabona','Portugalia')

		begin tran
	delete from Aeroport
	where Aeroport.Tara like 'Portugal'

	commit 
	INSERT INTO Aeroport(Denumire,Oras,Tara)
		VALUES ('Aeroportul international Falticeni','Falticeni','Romania')

	commit tran

	select *from Aeroport

--84.
SELECT Militar.IDMilitar,Nume,Prenume
		FROM Militar
		INNER JOIN FunctiiMilitari as fm
		ON fm.IDMilitar=Militar.IDMilitar
		UNION ALL
		SELECT Militar.IDMilitar,Nume,Prenume
		FROM Militar
		INNER JOIN GradeMilitari as gm
		ON gm.IDMilitar=Militar.IDMilitar

--85
SELECT [Angajat Civil].IDAngajat_Civil,Nume,Prenume
		FROM [Angajat Civil]
		INNER JOIN [Functii Angajati Civili] as fm
		ON fm.IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
		UNION ALL
		SELECT [Angajat Civil].IDAngajat_Civil,Nume,Prenume
		FROM [Angajat Civil]
		INNER JOIN [Firme Angajati Civili] as gm
		ON gm.IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil

--86
SELECT Pasager.IDPasager,Pasager.Nume,Pasager.Varsta
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
where Bilet.Tip like 'I'
union all
select Pasager.IDPasager,Pasager.Nume,Pasager.Varsta
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
where Bilet.Pret>100

--87
SELECT Militar.IDMilitar,Militar.Nume+' '+Militar.Prenume
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join [Misiune] on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Misiune.Denumire like 'Alpha'
union all
SELECT Militar.IDMilitar,Militar.Nume+' '+Militar.Prenume
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join [Misiune] on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Misiune.Denumire like 'Betta' 


--@@@@@ UPDATE @@@@@
--1. Actualizam varsta pasagerilor din avionul Airbus A200
UPDATE Pasager
set Pasager.Varsta=Pasager.Varsta+1
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join Avion on Cursa.IDAvion=Avion.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Airbus' and Model like 'A200'

--2.Actualizam numarul de telefon pentru militari din misiunea 'Betta' si functia de pilot
UPDATE Militar
set NumarTelefon=40774092987
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
where Functie.Denumire like 'Pilot'

--3.Actualizam judetul pentru angajatii cu functia de copilot din firma lufthansa
UPDATE [Angajat Civil]
set Judet='Cluj-Napoca'
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
where [Firma Zbor].Denumire like 'Lufthansa' and [Functie Civila].[Denumire Functie] like 'Copilot'

--4.Actualizam starea vremii din raport zbor unde misiunea este 'Alpha' si tip 'militar de transport'
UPDATE [RaportM Zbor]
set StareVreme='buna'
from [RaportM Zbor]
inner join Misiune on Misiune.IDMisiune=[RaportM Zbor].IDMisiune
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Misiune.Denumire like 'Alpha' and [MarcaModelTip Avion].Tip like 'militar de transport' 
--5.Actualizam procentul combustibilului din informatii zbor pentru modele de marca Airbus
update [Informatii Zbor]
set ProcentCombustibil=ProcentCombustibil+1
from [Informatii Zbor]
inner join Cursa on [Informatii Zbor].IDCursa=Cursa.IDCursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where [MarcaModelTip Avion].Marca like 'Airbus'
--6.Actualizam pretul biletelor pentru 
update Bilet
set	Pret=Pret+5
from Bilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Airbus'
--7.Actualizam Adresa militarilor cu functie de inginer si grad de locotenent 
update Militar
set Adresa='Str. Soarelui,Nr 2'
from Militar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
where GradMilitar.Denumire like 'Locotenent' and Functie.Denumire like 'Inginer'
--8.Actualizam denumirea unitatii militare din misiunea Betta si marca 'Airbus' a avionului
update [Unitate Militara]
set Denumire='UM40568'
from [Unitate Militara]
inner join Misiune on Misiune.IDUnitateMilitaraPlecare=[Unitate Militara].IDUnitateMilitara
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Airbus' and Misiune.Denumire like 'Betta'


--9.Actualizam procentul combustibilului pentru avioanele din marca 'Boeing'
update [Informatii Zbor]
set ProcentCombustibil=ProcentCombustibil-10
from [Informatii Zbor]
inner join Cursa on Cursa.IDCursa=[Informatii Zbor].IDCursa
inner join Avion on Avion.IDAvion=Cursa.IDCursa
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Boeing'

--10.Actualizati datele personale ale militarilor sa apara cu "*" pentru cei ce merg in misiunea Tiger
update Militar
set CNP='*',Data_Nastere='*',Sex='*',Oras='*',Judet='*',Adresa='*',NumarTelefon='*'
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
where Misiune.Denumire like 'Tiger' and GradMilitar.Denumire in('Sublocotenent','Locotenent','Capitan','Maior','Locotenent-Colonel','Colonel')

--11.
UPDATE Militar
set Judet='*',NumarTelefon='********'
from Militar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
where Militar.CNP like '1%'

--12.
UPDATE Pasager
set Pasager.Varsta=Pasager.Varsta+5
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join Avion on Cursa.IDAvion=Avion.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Boeing'

--13.
update Bilet
set	Pret=Pret+100
from Bilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Marca like 'Airbus' and Bilet.Tip like 'I'

--14.
UPDATE [RaportM Zbor]
set Locatia='Locatie Privata'
from [RaportM Zbor]
inner join Misiune on Misiune.IDMisiune=[RaportM Zbor].IDMisiune
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where Misiune.Denumire like 'Betta' and [MarcaModelTip Avion].Tip like 'militar de vanatoare' 

--15.
UPDATE [Angajat Civil]
set NumarTelefon='Detaliu confidential'
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
where [Firma Zbor].Denumire like 'Emirates' and [Functie Civila].[Denumire Functie] like 'Pilot'

--@@@@@ DELETE @@@@@
--1.
--DELETE [MarcaModelTip Avion] 
--FROM [MarcaModelTip Avion]
--inner join Avion on Avion.IDMMT=[MarcaModelTip Avion].IDMMT
--inner join Cursa on Cursa.IDAvion=Avion.IDAvion
--inner join Misiune on Avion.IDAvion=Misiune.IDAvion
--inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
--inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDCursa=Cursa.IDCursa
--inner join [Informatii Zbor] on [Informatii Zbor].IDCursa=Cursa.IDCursa
--inner join [Militari per Misiune] on [Militari per Misiune].IDMisiune=Misiune.IDMisiune
--inner join [RaportM Zbor] on [RaportM Zbor].IDMisiune=Misiune.IDMisiune
--inner join Pasager on Pasager.IDBilet=Bilet.IDBilet
--where [MarcaModelTip Avion].IDMMT=19

begin tran

select * from [MarcaModelTip Avion]

alter table Avion NOCHECK CONSTRAINT FK__Avion__IDMMT__35BCFE0A

DELETE [MarcaModelTip Avion]
FROM [MarcaModelTip Avion]
inner join Avion on Avion.IDMMT=[MarcaModelTip Avion].IDMMT
where [MarcaModelTip Avion].IDMMT=10

select * from [MarcaModelTip Avion]

rollback tran

--2
begin tran

select * from Misiune

alter table [RaportM Zbor] NOCHECK CONSTRAINT [FK__RaportM Z__IDMis__656C112C]
alter table [Militari per Misiune] NOCHECK CONSTRAINT [FK__Militari __IDMis__628FA481]

DELETE Misiune
from Misiune
inner join [Militari per Misiune] on [Militari per Misiune].IDMisiune=Misiune.IDMisiune
inner join Militar on Militar.IDMilitar=[Militari per Misiune].IDMilitar
inner join [RaportM Zbor] on [RaportM Zbor].IDMisiune=Misiune.IDMisiune
where [RaportM Zbor].StareVreme like 'precipitatii'

select * from Misiune

rollback tran
--3
begin tran

select * from Militar

alter table FunctiiMilitari NOCHECK CONSTRAINT [FK__FunctiiMi__IDMil__534D60F1]
alter table [Unitati Militare Militari] NOCHECK CONSTRAINT [FK__Unitati M__IDMil__59063A47]
alter table [Militari per Misiune] NOCHECK CONSTRAINT [FK__Militari __IDMil__619B8048]
alter table GradeMilitari NOCHECK CONSTRAINT [FK__GradeMili__IDMil__68487DD7]

DELETE Militar
FROM Militar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDMilitar=Militar.IDMilitar
inner join [Unitate Militara] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
where DATEDIFF(year,Data_Nastere,getdate())>25

select * from Militar

rollback tran
--4
begin tran

select * from [Angajat Civil]

alter table [Functii Angajati Civili] NOCHECK CONSTRAINT [FK__Functii A__IDAng__286302EC]
alter table [Firme Angajati Civili] NOCHECK CONSTRAINT [FK__Firme Ang__IDAng__2E1BDC42]
alter table [AngajatiC per Cursa] NOCHECK CONSTRAINT [FK__AngajatiC__IDAng__440B1D61]

DELETE [Angajat Civil]
FROM [Angajat Civil]
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
where [Angajat Civil].Nume like 'P%'

select * from [Angajat Civil]

rollback tran
--5
begin tran

select * from Aeroport

alter table [Cursa] NOCHECK CONSTRAINT [FK__Cursa__IDAeropor__3A81B327]

DELETE Aeroport
FROM Aeroport
inner join Cursa on Cursa.IDAeroportPlecare=IDAeroport and cursa.IDAeroportSosire=IDAeroport
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
where Aeroport.Tara like 'Franta'

select * from Aeroport

rollback tran
--6
begin tran

select * from Cursa

alter table [Bilet] NOCHECK CONSTRAINT [FK__Bilet__IDCursa__3D5E1FD2]
alter table [AngajatiC per Cursa] NOCHECK CONSTRAINT [FK__AngajatiC__IDCur__44FF419A]
alter table [Informatii Zbor] NOCHECK CONSTRAINT [FK__Informati__IDCur__47DBAE45]



DELETE Cursa
FROM Cursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=avion.IDMMT
inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
where [MarcaModelTip Avion].Marca like 'Boeing'

select * from Cursa

rollback tran
--7
begin tran

select * from Cursa

alter table [Bilet] NOCHECK CONSTRAINT [FK__Bilet__IDCursa__3D5E1FD2]
alter table [AngajatiC per Cursa] NOCHECK CONSTRAINT [FK__AngajatiC__IDCur__44FF419A]
alter table [Informatii Zbor] NOCHECK CONSTRAINT [FK__Informati__IDCur__47DBAE45]

DELETE Cursa
FROM Cursa
inner join Aeroport on Cursa.IDAeroportPlecare=Aeroport.IDAeroport
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where [MarcaModelTip Avion].Marca like 'Boeing' and Aeroport.Tara like 'Romania'

select * from Cursa

rollback tran
--8
begin tran

select * from [Angajat Civil]

alter table [Functii Angajati Civili] NOCHECK CONSTRAINT [FK__Functii A__IDAng__286302EC]
alter table [Firme Angajati Civili] NOCHECK CONSTRAINT [FK__Firme Ang__IDAng__2E1BDC42]
alter table [AngajatiC per Cursa] NOCHECK CONSTRAINT [FK__AngajatiC__IDAng__440B1D61]

DELETE [Angajat Civil]
FROM [Angajat Civil]
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
where [Angajat Civil].Nume like 'T%' and [Firma Zbor].Denumire like 'Lufthansa'

select * from [Angajat Civil]

rollback tran
--9
begin tran

select * from Misiune

alter table [RaportM Zbor] NOCHECK CONSTRAINT [FK__RaportM Z__IDMis__656C112C]
alter table [Militari per Misiune] NOCHECK CONSTRAINT [FK__Militari __IDMis__628FA481]

DELETE Misiune
from Misiune
inner join [Militari per Misiune] on [Militari per Misiune].IDMisiune=Misiune.IDMisiune
inner join Militar on Militar.IDMilitar=[Militari per Misiune].IDMilitar
inner join [RaportM Zbor] on [RaportM Zbor].IDMisiune=Misiune.IDMisiune
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where [RaportM Zbor].StareVreme like 'buna' and [MarcaModelTip Avion].CapacitateMaxima<200

select * from Misiune

rollback tran
--10
begin tran

select * from Aeroport

alter table [Cursa] NOCHECK CONSTRAINT [FK__Cursa__IDAeropor__3A81B327]

DELETE Aeroport
FROM Aeroport
inner join Cursa on Cursa.IDAeroportPlecare=IDAeroport and cursa.IDAeroportSosire=IDAeroport
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join Bilet on Bilet.IDCursa=Cursa.IDCursa
where Aeroport.Tara like 'Romania' and Bilet.Tip like 'I'

select * from Aeroport

rollback tran

--11.
begin tran

select * from Militar

alter table FunctiiMilitari NOCHECK CONSTRAINT [FK__FunctiiMi__IDMil__534D60F1]
alter table [Unitati Militare Militari] NOCHECK CONSTRAINT [FK__Unitati M__IDMil__59063A47]
alter table [Militari per Misiune] NOCHECK CONSTRAINT [FK__Militari __IDMil__619B8048]
alter table GradeMilitari NOCHECK CONSTRAINT [FK__GradeMili__IDMil__68487DD7]

DELETE Militar
FROM Militar

inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDMilitar=Militar.IDMilitar
inner join [Unitate Militara] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
where [Unitate Militara].Tara like 'Romania' and GradMilitar.Denumire in('Sublocotent','Locotenent')

select * from Militar

rollback tran

--12.
begin tran

select * from [MarcaModelTip Avion]

DELETE [MarcaModelTip Avion]
FROM [MarcaModelTip Avion]
inner join Avion on Avion.IDMMT=[MarcaModelTip Avion].IDMMT
inner join Cursa on Cursa.IDAvion=Avion.IDAvion
inner join Bilet on Cursa.IDCursa=Bilet.IDCursa

where [MarcaModelTip Avion].CapacitateMaxima<100 and Bilet.Tip like 'Dus-intors'

select * from [MarcaModelTip Avion]

rollback tran

--13.
begin tran

select * from [Cursa]

alter table Bilet NOCHECK CONSTRAINT [FK__Bilet__IDCursa__3D5E1FD2]
alter table [AngajatiC per Cursa] NOCHECK CONSTRAINT [FK__AngajatiC__IDCur__44FF419A]
alter table [Informatii Zbor] NOCHECK CONSTRAINT [FK__Informati__IDCur__47DBAE45]

DELETE [Cursa]
FROM [Cursa]
inner join Bilet on Cursa.IDCursa=Bilet.IDCursa
where datediff(month,DataPlecarii,GETDATE())>1 and Bilet.Clasa like 'I'

select * from [Cursa]

rollback tran

--14.
begin tran

select * from [Unitate Militara]

alter table [Unitati Militare Militari] NOCHECK CONSTRAINT [FK__Unitati M__IDUni__59FA5E80]
alter table Misiune NOCHECK CONSTRAINT [FK__Misiune__IDUnita__5DCAEF64]


DELETE [Unitate Militara]
FROM [Unitate Militara]
inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDUnitateMilitara=[Unitate Militara].IDUnitateMilitara
inner join Misiune on Misiune.IDUnitateMilitaraPlecare=[Unitate Militara].IDUnitateMilitara and Misiune.IDUnitateMilitaraSosire=[Unitate Militara].IDUnitateMilitara

where [Unitate Militara].Tara like 'Romania'

select * from [Unitate Militara]

rollback tran

--15.
begin tran

select * from Militar

alter table FunctiiMilitari NOCHECK CONSTRAINT [FK__FunctiiMi__IDMil__534D60F1]
alter table [Unitati Militare Militari] NOCHECK CONSTRAINT [FK__Unitati M__IDMil__59063A47]
alter table [Militari per Misiune] NOCHECK CONSTRAINT [FK__Militari __IDMil__619B8048]
alter table GradeMilitari NOCHECK CONSTRAINT [FK__GradeMili__IDMil__68487DD7]

DELETE Militar
FROM Militar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDMilitar=Militar.IDMilitar
inner join [Unitate Militara] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
where Functie.Denumire like 'Pilot' and Misiune.Denumire like 'Alpha' and GradMilitar.Denumire like 'Locotenent'

select * from Militar

rollback tran


		 
--@@@@@@@@@ VIEWS @@@@@@@@@

--1.Sa se creeze un view cu pasagerii care au bilet. Sa se afiseze CNP-ul si numele angajatilor din avion , data cursei , modelul si marca avionului , informatii despre zbor
IF OBJECT_ID('View1','V') is not null
	drop view View1
go
CREATE VIEW View1
AS
SELECT Pasager.Nume +' '+ Pasager.Prenume as NumePasager,
Aeroport.Tara, [Angajat Civil].Nume, [Angajat Civil].Prenume, [Angajat Civil].CNP, Cursa.DataPlecarii, [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model, [Informatii Zbor].Locatia, [Informatii Zbor].Ora, [Informatii Zbor].ProcentCombustibil, [Informatii Zbor].ProcentDistanta, [Informatii Zbor].StareVreme
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDCursa=Bilet.IDCursa
inner join [Angajat Civil] on [Angajat Civil].IDAngajat_Civil=[AngajatiC per Cursa].IDAngajat_Civil
inner join Aeroport on Aeroport.IDAeroport=Cursa.IDAeroportSosire
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
inner join [Informatii Zbor] on [Informatii Zbor].IDCursa=Cursa.IDCursa

SELECT * from View1


--2.Sa se creeze un view cu militarii , unitatea militara de care apartin, vechimea in aceea unitate, gradul si functia pe care o detin
IF OBJECT_ID('View2','V') is not null
	drop view View2
go
CREATE VIEW View2
AS
SELECT Militar.Nume+' '+Militar.Prenume as NumeMilitar,
[Unitate Militara].Denumire, datediff(year,[Unitati Militare Militari].Data1Perioada, getdate()) as 'Vechime in UM', GradMilitar.Denumire as 'Grad', Functie.Denumire as 'Functie'
from Militar
inner join [Unitati Militare Militari] on [Unitati Militare Militari].IDMilitar=Militar.IDMilitar
inner join GradeMilitari on GradeMilitari.IDMilitar=Militar.IDMilitar
inner join GradMilitar on GradMilitar.IDGrad=GradeMilitari.IDGrad
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
inner join [Unitate Militara] on [Unitate Militara].IDUnitateMilitara=[Unitati Militare Militari].IDUnitateMilitara

SELECT * from View2


--3.Sa se creeze un view cu angajatii civili al caror nume are initiala intre 'A'-'Q' sunt de sex masculin , firma la care lucreaza ,functiile ocupate si sunt din 'Olt', ('Bucuresti'), 'Brasov' sau 'Harghita' , numar de telefon 
IF OBJECT_ID('View3','V') is not null
	drop view View3
go
CREATE VIEW View3
AS
SELECT [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume', [Angajat Civil].Sex as 'Sex', [Firma Zbor].Denumire as 'Firma Zbor', [Functie Civila].[Denumire Functie] as 'Functie', [Angajat Civil].Oras as 'Oras', [Angajat Civil].Judet as 'Judet', [Angajat Civil].NumarTelefon as 'Numar de telefon'
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
where [Angajat Civil].Nume between 'A' and 'Q' and [Angajat Civil].Sex like 'masculin' and [Angajat Civil].Judet in ('Olt','Bucuresti','Brasov','Harghita')

select * from View3

--4.Sa se creeze un tabel cu angajatii civili ce ocupa functia de 'Mecanic Aeronave' si nu lucreaza la firma 'Lufthansa' pe baza vederii precedente si nu sunt nascuti in zile pare
IF OBJECT_ID('View4','V') is not null
	drop view View4
go
CREATE VIEW View4
AS
SELECT View3.[Nume Prenume]
from View3
inner join [Angajat Civil] on [Angajat Civil].Nume+' '+[Angajat Civil].Prenume=View3.[Nume Prenume]
where view3.[Firma Zbor] not like 'Lufthansa' and DAY([Angajat Civil].Data_Nastere) not in (2,4,6,8,10,12,14,16,18,20,22,24,26,28,30)

select * from View4

--5.Sa se creeze un view cu pilotii si firma la care lucreaza si data la care si au primit functia de 'Pilot'
IF OBJECT_ID('View5','V') is not null
	drop view View5
go
CREATE VIEW View5
AS
SELECT [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume', [Firma Zbor].Denumire, [Functii Angajati Civili].Data_Numire
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
inner join [Functii Angajati Civili] on [Functii Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Functie Civila] on [Functie Civila].IDFunctie=[Functii Angajati Civili].IDFunctie
where [Functie Civila].[Denumire Functie] like 'Pilot' 

select * from View5

--6.Sa se creeze un view cu pasagerii care au bilete de tipul 'Dus' la clasa 'I' dupa data de 2022-01-01 si pretul mai mare de 260
IF OBJECT_ID('View6','V') is not null
	drop view View6
go
CREATE VIEW View6
AS
SELECT Pasager.Nume, Pasager.Prenume, Bilet.Tip,Bilet.Clasa, Bilet.Pret, Cursa.DataPlecarii
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
where Bilet.Tip like 'Dus' and Bilet.Clasa like 'I' and Cursa.DataPlecarii >'2022-01-1' and bilet.Pret >260

select * from View6

--7.Sa se creeze o vedere cu militarii care sunt trecuti de media de varsta a tuturor militarilor
IF OBJECT_ID('View7','V') is not null
	drop view View7
go
CREATE VIEW View7
AS
SELECT Militar.Nume+' '+Militar.Prenume as 'Nume Prenume' , datediff(year,Militar.Data_Nastere, GETDATE()) as 'Varsta'
from Militar
where datediff(year, Militar.Data_Nastere, getdate()) > (SELECT avg(datediff(year,Militar.Data_Nastere ,GETDATE())) from Militar)

select * from View7

--8.Sa se creeaze un view cu angajatii civili , cnp-ul acestora, aeroportul de plecare de la urmatoarea cursa pe care lucreaza si modelul si marca avionului
IF OBJECT_ID('View8','V') is not null
	drop view View8
go
CREATE VIEW View8
AS
SELECT [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume', [Angajat Civil].CNP, Aeroport.Denumire as 'Cursa', [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model
from [Angajat Civil]
inner join [AngajatiC per Cursa] on [AngajatiC per Cursa].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join Cursa on Cursa.IDCursa=[AngajatiC per Cursa].IDCursa
inner join Avion on Cursa.IDAvion=Avion.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=avion.IDMMT
inner join Aeroport on Aeroport.IDAeroport=Cursa.IDAeroportPlecare

select * from View8

--9.Sa se creeze o vedere cu militarii mai mari de 20 de ani , data nasterii si data cand au avut majoratul , varsta actuala
IF OBJECT_ID('View9','V') is not null
	drop view View9
go
CREATE VIEW View9
AS
SELECT Militar.Nume + ' ' + Militar.Prenume as 'Nume Prenume' , Militar.Data_Nastere, DATEADD(year, 18, Militar.Data_Nastere) as 'Data Majorat' , datediff(year,Militar.Data_Nastere, GETDATE()) as 'Varsta actuala'
from Militar
where datediff(year,Militar.Data_Nastere, GETDATE())>20

select * from View9

--10.Sa se creeze o vedere cu militarii de sex feminin care au misiune intr o luna impara si si numele misiunii
IF OBJECT_ID('View10','V') is not null
	drop view View10
go
CREATE VIEW View10
AS
SELECT Militar.Nume+ ' ' +Militar.Prenume as 'Nume Prenume' , Militar.Sex, Misiune.DataPlecarii, Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Militar.Sex like 'feminin' and month(Misiune.DataPlecarii) in (1,3,5,7,9,11)

select * from View10


--@@@@@@@@@ PROCEDURI STOCATE @@@@@@@@@

--1.Sa se creeze o procedura care sa permita vizualizarea sumei varstelor pasagerilor dintr o cursa prin returnarea parametrului.Trimitem ca parametru id-ul cursei
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura1')
DROP procedure Procedura1
GO
CREATE PROCEDURE Procedura1 @id_cursa int, @suma_varstelor int=0 OUTPUT
AS
SELECT @suma_varstelor=SUM(Pasager.Varsta)
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=Bilet.IDCursa
where Cursa.IDCursa=@id_cursa

GO
DECLARE @p1 int 
EXEC Procedura1 @id_cursa=1,@suma_varstelor=@p1 OUTPUT
SELECT @p1 as 'SUMA VARSTELOR'

--2.Sa se creeze o procedura care sa permita vizualizarea varstei medii pentru o zi trimisa ca parametru care reprezinta ziua de nastere a militarilor
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura2')
DROP procedure Procedura2
GO
CREATE PROCEDURE Procedura2 @ziua int, @varsta_medie int output
as
SELECT @varsta_medie=AVG(DATEDIFF(year,Militar.Data_Nastere,GETDATE()))
from Militar
where day(Militar.Data_Nastere)=@ziua

GO
DECLARE @p2 int 
EXEC Procedura2 @ziua = 10, @varsta_medie=@p2 output
SELECT @p2 AS 'Varsta medie'

--3.Sa se creeze o procedura care permite prin trimiterea unui parametru intreg	pentru id_cursa, vizualizarea tuturor pasagerilor din cursa trimisa ca parametru
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura3')
DROP procedure Procedura3
GO
CREATE PROCEDURE Procedura3 @id_cursa int =1
as
select Pasager.Nume, Pasager.Prenume, Cursa.DataPlecarii as 'Data plecarii', Cursa.IDCursa
from Pasager
inner join Bilet on Bilet.IDBilet=Pasager.IDBilet
inner join Cursa on Cursa.IDCursa=bilet.IDCursa
where Cursa.IDCursa=@id_cursa

EXEC Procedura3 @id_cursa=2

--4.Sa se creeze o procedura care permite trimiterea unei misiuni ca parametru si afiseaza toti militarii care fac parte din aceea misiune
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura4')
DROP procedure Procedura4
GO
CREATE PROCEDURE Procedura4 @misiune varchar(30)
as
select Militar.Nume +  ' ' + Militar.Prenume as 'Nume militar', Misiune.Denumire
from Militar
inner join [Militari per Misiune] on [Militari per Misiune].IDMilitar=Militar.IDMilitar
inner join Misiune on Misiune.IDMisiune=[Militari per Misiune].IDMisiune
where Misiune.Denumire=@misiune

exec Procedura4 @misiune='Betta'

--5.Sa se creeze o procedura care permite vizualizarea firmelor de zbor la care a lucrat un angajat , avand ca parametru numele si prenumele acestuia
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura5')
DROP procedure Procedura5
GO
CREATE procedure Procedura5 @nume varchar(30) , @prenume varchar(30)
as 
select [Firma Zbor].Denumire as 'Firma Zbor', [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume Angajat'
from [Firma Zbor]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDFirma_Zbor=[Firma Zbor].IDFirma_Zbor
inner join [Angajat Civil] on [Angajat Civil].IDAngajat_Civil=[Firme Angajati Civili].IDAngajat_Civil
where [Angajat Civil].Nume=@nume and [Angajat Civil].Prenume=@prenume

exec Procedura5 @nume='Miclaus', @prenume='Simona'

--6.Sa se creeze o procedura care afiseaza toti pasagerii care au bilete la clasa ... , tip ... si pretul mai mare decat ... (parametrii)
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura6')
DROP procedure Procedura6
GO
create procedure Procedura6 @clasa varchar(30), @tip varchar(30) , @pret int
as
select Pasager.Nume + ' ' + Pasager.Prenume as 'Nume Prenume Pasager' , Bilet.Clasa, Bilet.Tip, Bilet.Pret
from Pasager
inner join Bilet on bilet.IDBilet=Pasager.IDBilet
where Bilet.Clasa=@clasa and Bilet.Tip=@tip and Bilet.Pret>@pret

exec Procedura6 @clasa='I', @tip='Dus', @pret=150

--7.Sa se creeze o procedura care permite prin trimiterea unui parametru , vizualizarea tuturor angajatilor civili in data trimisa ca parametru si firma la care lucreaza la acea data
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura7')
DROP procedure Procedura7
GO
create procedure Procedura7 @data date
as
select [Angajat Civil].Nume+' '+[Angajat Civil].Prenume as 'Nume Prenume Angajat', [Firma Zbor].Denumire, [Firme Angajati Civili].Data_Angajare, [Firme Angajati Civili].Data_Plecarii, @data as 'Data-Parametru'
from [Angajat Civil]
inner join [Firme Angajati Civili] on [Firme Angajati Civili].IDAngajat_Civil=[Angajat Civil].IDAngajat_Civil
inner join [Firma Zbor] on [Firma Zbor].IDFirma_Zbor=[Firme Angajati Civili].IDFirma_Zbor
where @data between [Firme Angajati Civili].Data_Angajare and [Firme Angajati Civili].Data_Plecarii

exec Procedura7 @data='2018-05-20'

--8.Sa se creeze o procedura care permite trimiterea unui model si marca de avion ca parametrii si afiseaza toate cursele data plecarii si data sosirii acelor curse
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura8')
DROP procedure Procedura8
GO
create procedure Procedura8 @model varchar(30), @marca varchar(30)
as
select Cursa.IDCursa, Cursa.DataPlecarii,Cursa.DataSosirii,@marca, @model
from Cursa
inner join Avion on Avion.IDAvion=Cursa.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where [MarcaModelTip Avion].Marca=@marca and [MarcaModelTip Avion].Model=@model

exec Procedura8 @model='A220' , @marca='Airbus'

--9.Sa se creeze o procedura care permite trimiterea unui model de avion si marca ca parametrii si afiseaza misiunea care se va desfasura cu acel avion si militarii respectivi
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura9')
DROP procedure Procedura9
GO
create procedure Procedura9 @marca varchar(30),@model varchar(30)
as
select Misiune.Denumire, Militar.Nume, Militar.Prenume, [MarcaModelTip Avion].Marca, [MarcaModelTip Avion].Model
from Misiune
inner join [Militari per Misiune] on [Militari per Misiune].IDMisiune=Misiune.IDMisiune
inner join Militar on Militar.IDMilitar=[Militari per Misiune].IDMilitar
inner join Avion on Avion.IDAvion=Misiune.IDAvion
inner join [MarcaModelTip Avion] on [MarcaModelTip Avion].IDMMT=Avion.IDMMT
where [MarcaModelTip Avion].Marca=@marca and [MarcaModelTip Avion].Model=@model

exec Procedura9 @marca='Airbus',@model='A400M'



--10.Sa se creeze o procedura care permite vizualizarea militarilor pe functia data ca parametru mai in varsta de 30 de ani
IF EXISTS (SELECT * FROM sys.objects where type = 'P' and name='Procedura10')
DROP procedure Procedura10
GO
create procedure Procedura10 @functie varchar(30)
as
select Militar.Nume, Militar.Prenume, Functie.Denumire, datediff(year,Militar.Data_Nastere,GETDATE()) as 'Varsta'
from Militar
inner join FunctiiMilitari on FunctiiMilitari.IDMilitar=Militar.IDMilitar
inner join Functie on Functie.IDFunctie=FunctiiMilitari.IDFunctie
where Functie.Denumire=@functie and DATEDIFF(year,Militar.Data_Nastere,GETDATE())>30

exec Procedura10 @functie='Pilot'


--@@@@@@@@@ TRIGGERE @@@@@@@@@

----1.Sa se creeze un trigger la adaugarea unui militar, daca acesta are varsta mare decat cel mai in varsta militar din tabela
--IF OBJECT_ID('tr_Varsta', 'TR') IS NOT NULL
--DROP TRIGGER tr_Varsta;
--GO
--CREATE TRIGGER tr_Varsta
--on Militar
--for insert
--as begin
--	declare @varsta int
--	select @varsta=DATEDIFF(year,inserted.Data_Nastere,GETDATE())
--	from inserted
--if @varsta>(SELECT MAX(DATEDIFF(year,militar.Data_Nastere,GETDATE())) from Militar)
--	print'Este cel mai batran!'
--end

--select * from Militar

--insert into [Militar](Nume,Prenume,CNP,Data_Nastere,Sex,Oras,Judet,Adresa,NumarTelefon)
--values
--(
--	'Enache','Ciprian','1750416779064','1975-04-16','masculin','Bals','Olt','Str. Principala, nr.5', 40786091987
--)

--insert into [Militar](Nume,Prenume,CNP,Data_Nastere,Sex,Oras,Judet,Adresa,NumarTelefon)
--values
--(
--	'Sica','Marian','1700416779064','1970-04-16','masculin','Reghin','Mures','Str. Secundara, nr.2', 40799091987
--)

--1.Sa se creeze un trigger pentru update sa afiseze ce a fost inainte si ce s-a adaugat nou
IF OBJECT_ID('TR_Update')IS NOT NULL
DROP TRIGGER TR_Update

GO

CREATE TRIGGER TR_Update
on [Firma Zbor]
for update
as begin
select *
from inserted
union
select * from deleted
end

update [Firma Zbor]
set Denumire='Pegasus'
where IDFirma_Zbor=8

--2.Sa se creeze un trigger care sa afiseze un mesaj de eroare 16,1 cand se executa un insert sau update in tabela angajati civili
IF OBJECT_ID('TR_2')IS NOT NULL
DROP TRIGGER TR_2

GO

create trigger TR_2
on [Angajat Civil]
for insert, update
as
begin
RAISERROR('S-a executat un INSERT sau un UPDATE',16,1)
end

insert into [Angajat Civil](Nume, Prenume, CNP, Data_Nastere, Sex, Oras, Judet, Adresa, NumarTelefon)
values('Florescu', 'Claudiu', '1950505779064','1995-05-05','masculin','Craiova','Dolj','Strada Pitesti, nr.4', 40774092444)

update [Angajat Civil]
set Nume='Radulescu'
where Nume='Florescu' and Prenume='Claudiu'

--3.Sa se creeze un trigger care sa afiseze un mesaj de eroare 16,1 cand se executa delete in tabela angajati civili
IF OBJECT_ID('TR_3')IS NOT NULL
DROP TRIGGER TR_3

GO

create trigger TR_3
on [Angajat civil]
for delete
as
begin
RAISERROR('S-a executat un delete',16,1)
end

delete from [Angajat Civil]
where Nume='Radulescu' and Prenume='Claudiu'

--4.Sa se creeze un declansator care sa afiseze un mesaj de eroare la inserarea sau modificarea tabelei militari.
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_4' AND type = 'TR')
DROP TRIGGER TR_4

go

create trigger TR_4
on Militar
FOR insert, update
as
declare
@@varsta integer,
@@nume_militar varchar(30)
SELECT @@nume_militar=inserted.Nume, @@varsta=datediff(year, inserted.Data_Nastere, GETDATE())
from inserted, Militar
where inserted.Nume=Militar.Nume
if(@@varsta<30)
begin
	raiserror('Militarul %s are varsta <30',16, 1, @@nume_militar)
	end
	else
	begin
	raiserror('Militarul %s are varsta de %d',16,1,@@nume_militar,@@varsta)
	end

insert into Militar(Nume, Prenume,CNP,Data_Nastere,Sex,Oras,Judet,Adresa,NumarTelefon)
values('Epureanu','Sandel','1720416779064','1972-04-16','masculin','Praid','Harghita','Str. Secund, nr.1', 40799191987)

--5.Sa se creeze un trigger pentru tabela Bilet	care dupa fiecare inserare adauga 5 la pretul biletului
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_5' AND type = 'TR')
DROP TRIGGER TR_5

go

CREATE TRIGGER TR_5
on Bilet
after insert
as
	update Bilet
	set bilet.Pret=Bilet.Pret+5
	from inserted
	where Bilet.IDBilet=inserted.IDBilet

insert into
Bilet(Tip,Clasa,Pret,IDCursa,IDFirma_Zbor)
values('Dus','I',200,2,1)

--6.Sa se creeze un trigger pentru tabela bilete care sa inlocuiasca operatia insert cu operatia UPDATE, cand dorim inserarea unui bilet, se va declansa un update pentru pretul biletelor cu 5 , numai pentru bilete dus 
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_6' AND type = 'TR')
DROP TRIGGER TR_6

go

CREATE TRIGGER TR_6
on Bilet
instead of insert 
as
UPDATE Bilet
set Bilet.Pret=Bilet.Pret+5
from inserted
where Bilet.Tip like 'Dus'

insert into
Bilet(Tip,Clasa,Pret,IDCursa,IDFirma_Zbor)
values('Dus','II',250,3,1)

--7.Sa se creeze un trigger pentru tabela Militar prin care sa se afiseze un mesaj de eroare daca s a modificat adresa unui militar si un alt mesaj daca s a modificat altceva
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_7' AND type = 'TR')
DROP TRIGGER TR_7

go

CREATE TRIGGER TR_7 
on Militar
for update
as
if update(Adresa)
raiserror('S-a modificat campul Adresa',16,1)
else
raiserror('S-a modificat alt camp al tabelei Militar',16,1)
go

UPDATE Militar SET Adresa='Str. Fan,Nr.66' where Adresa like 'Str. Sec,Nr.77'
UPDATE Militar SET NumarTelefon='40774092987' where NumarTelefon like '40799191987'

--8.Sa se creeze un trigger pentru tabela Pasager.Verifica daca numele pasagerului exista si afiseaza un mesaj corespunzator
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_8' AND type = 'TR')
DROP TRIGGER TR_8

go

CREATE TRIGGER TR_8
ON Pasager
FOR DELETE
AS
DECLARE @nume varchar(30)
SELECT @nume=deleted.Nume
from Pasager,deleted
if @nume in (SELECT Nume from Pasager)
print 'S-a sters'
else
begin
print 'Acest pasager nu exista'
rollback transaction
end
go

DELETE from pasager where Pasager.Nume='Ionescu'

--9.Sa se creeze un trigger care afiseaza un mesaj de eroare daca una din valorile adaugate este null in raportm zbor
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_9' AND type = 'TR')
DROP TRIGGER TR_9
go

CREATE TRIGGER TR_9
on [RaportM Zbor]
FOR INSERT
as
begin
	Declare
	@idraport int,
	@idmisiune int,
	@ora varchar(30),
	@starevreme varchar(30),
	@procentCombustibil varchar(30),
	@procentDistanta varchar(30),
	@locatia varchar(30)
	select
	@idraport=[RaportM Zbor].IDRaport,@idmisiune=[RaportM Zbor].IDMisiune,@ora=[RaportM Zbor].Ora,@starevreme=[RaportM Zbor].StareVreme,@procentCombustibil=[RaportM Zbor].ProcentCombustibil,@procentDistanta=ProcentDistanta,@locatia=[RaportM Zbor].Locatia
	from [RaportM Zbor]
	if(@idraport is null or @idmisiune is null or @ora is null or @starevreme is null or @procentCombustibil is null or @procentDistanta is null or @locatia is null)
		raiserror('Element null',16,1)
		return
end
go

insert into [RaportM Zbor](IDMisiune,Ora,StareVreme,ProcentCombustibil,ProcentDistanta,Locatia)
values(NULL,'20:00','ploios',30,30,'Bucuresti');

--10.Sa se creeze un trigger care sa afiseze un mesaj de eroare daca se insereaza o cursa care exista deja , daca nu sa o insereze
IF EXISTS (SELECT name
FROM sysobjects
WHERE name = 'TR_10' AND type = 'TR')
DROP TRIGGER TR_10
go

CREATE TRIGGER TR_10
on Cursa
instead of insert
as begin
declare
	@id_avion int,
	@data_plecarii date,
	@data_sosirii date,
	@ora_plecarii varchar(30),
	@ora_sosirii varchar(30),
	@id_aero1 int,
	@id_aero2 int
	select
@id_avion=IDAvion,@data_plecarii=DataPlecarii,@data_sosirii=DataSosirii,@ora_plecarii=OraPlecarii,@ora_sosirii=OraSosirii,@id_aero1=IDAeroportPlecare,@id_aero2=IDAeroportSosire
from Cursa

if exists(SELECT * from Cursa where IDAvion=@id_avion and DataPlecarii=@data_plecarii and DataSosirii=@data_sosirii and OraPlecarii=@ora_plecarii and OraSosirii=@ora_sosirii and IDAeroportPlecare=@id_aero1 and IDAeroportSosire=@id_aero2)
Raiserror('Aceasta cursa exista deja', 16,1)
else
	insert into Cursa
	VALUES(@id_avion,@data_plecarii,@data_sosirii,@ora_plecarii,@ora_sosirii,@id_aero1,@id_aero2)
end

insert into [Cursa]
values(3,'2022-04-23','2022-04-24','23:00','05:00',3,8)


