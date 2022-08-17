CREATE DATABASE IF NOT EXISTS cga103g4;
USE cga103g4;

DROP TABLE IF EXISTS CreditCardInformation;
DROP TABLE IF EXISTS ReceiptInformation;
DROP TABLE IF EXISTS AUTHORITY;
DROP TABLE IF EXISTS EmpFunction;
DROP TABLE IF EXISTS ANNOUNCEMENT;
DROP TABLE IF EXISTS MemberServicePicture;
DROP TABLE IF EXISTS MemberServiceRecord;
DROP TABLE IF EXISTS ClassPicture;
DROP TABLE IF EXISTS RegisttrationForm;
DROP TABLE IF EXISTS ClassIfm;
DROP TABLE IF EXISTS ChefSchedule;
DROP TABLE IF EXISTS ChefAppointmentForm;
DROP TABLE IF EXISTS ChefSkills;
DROP TABLE IF EXISTS ChefSubscription;
DROP TABLE IF EXISTS OrderDetail;
DROP TABLE IF EXISTS MemberCoupon;
DROP TABLE IF EXISTS PromotionsDetail;
DROP TABLE IF EXISTS cartDetail;
DROP TABLE IF EXISTS FavoriteProduct;
DROP TABLE IF EXISTS ProductPic;
DROP TABLE IF EXISTS RecipePicture;
DROP TABLE IF EXISTS RecipeIngredients;
DROP TABLE IF EXISTS RecipeCollect;
DROP TABLE IF EXISTS Recipe;
DROP TABLE IF EXISTS ArticlePicture;
DROP TABLE IF EXISTS ArticleSave;
DROP TABLE IF EXISTS ArticleGood;
DROP TABLE IF EXISTS MsgReport;
DROP TABLE IF EXISTS ArticleMsg;
DROP TABLE IF EXISTS REPORT;
DROP TABLE IF EXISTS ARTICLE;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Promotions;
DROP TABLE IF EXISTS CouponType;
DROP TABLE IF EXISTS ChefSkillsType;
DROP TABLE IF EXISTS Chef;
DROP TABLE IF EXISTS ClassTag;
DROP TABLE IF EXISTS Teacher;
DROP TABLE IF EXISTS KeyWord;
DROP TABLE IF EXISTS EMPLOYEE;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Productsort;
DROP TABLE IF EXISTS FORUM;
DROP TABLE IF EXISTS MEMBER;

-- ================== CREATE TABLE(會員）================== --

CREATE TABLE MEMBER(
memid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
memName VARCHAR(45) NOT NULL,
memAccount VARCHAR(20) NOT NULL,
memPassword VARCHAR(20) NOT NULL,
memGender CHAR(1) NOT NULL,
memPhone VARCHAR(10) NOT NULL,
memEmail VARCHAR(40) NOT NULL,
memAddres VARCHAR(100),
memBirthday DATE NOT NULL,
memStatus TINYINT DEFAULT(0),
memNation VARCHAR(20) NOT NULL,
CONSTRAINT unikey_memaccount unique(memAccount)
)auto_increment=201;
INSERT INTO MEMBER(memName, memAccount, memPassword, memGender, memPhone, memEmail, memBirthday, memNation)  
VALUES  ('料理臭銅牌', 'bronze123', 'sp4sp4sp4', 'm', 0999000000,'bronze@gmail.com',STR_TO_DATE('1994-11-02','%Y-%m-%d'), '美國'),
		('料理臭銀牌', 'silver123', 'sp4sp4sp4', 'm', 0988000000, 'silver@gmail.com', STR_TO_DATE('1995-11-03','%Y-%m-%d'), '英國'),
		('料理臭金牌', 'gold123', 'sp4sp4sp4', 'f', 0977000000, 'gold@gmail.com',STR_TO_DATE('1996-11-04','%Y-%m-%d'), '日本'),
		('銅銀金一家親', 'family', 'sp4sp4sp4', 'f', 0966000000,'family@gmail.com',STR_TO_DATE('1997-11-05','%Y-%m-%d'), '台灣');

-- 常用信用卡 -- 
CREATE TABLE CreditCardInformation(
creditCardid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
memid INT NOT NULL,
creditCardNumber VARCHAR(16) NOT NULL,
creditCardName VARCHAR(20) NOT NULL,
creditCardTime VARCHAR(4) NOT NULL,
cvcCode VARCHAR(3) NOT NULL,
CONSTRAINT CreditCardInformation_memid_FK FOREIGN KEY (memid) REFERENCES Member (memid)
);
INSERT INTO CreditCardInformation(memid, creditCardNumber, creditCardName, creditCardTime, cvcCode)
VALUES  (202, '0000111122223333', '張正綠', '0826', 111),
 		(202, '4444333322221111', '張正綠', '0827', 222);

-- 常用收貨資訊 --
create table ReceiptInformation(
rcpid int auto_increment not null primary key,
memid int not null,
rcpName varchar(45) not null,
rcpCvs varchar(255) ,
rcpAddress varchar(255) ,
rcpPhone varchar(10) not null,
constraint ReceiptInformation_member_fk foreign key (memid) references member(memid)
);
insert into ReceiptInformation(memid,rcpName,rcpCvs,rcpPhone)
values ('201','臭銅牌','全家中壢中山店','0999000000');

-- ================== CREATE TABLE(管理員相關）================== --
        
-- 管理員 --
CREATE TABLE EMPLOYEE(
empid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
empName VARCHAR(20) NOT NULL,
empPhone varchar(10) NOT NULL,
empAccount VARCHAR(20) NOT NULL,
empPassword VARCHAR(20) NOT NULL,
empStatus TINYINT(1) NOT NULL,
empHiredate DATE NOT NULL,
CONSTRAINT unikey_empaccount unique(empAccount)
)auto_increment=101;
INSERT INTO EMPLOYEE(empName, empPhone, empAccount, empPassword, empStatus, empHiredate)  
VALUES  ('吳冠宏', 0912345678,'empaccount1', 'emppassword1','0',STR_TO_DATE('2004-01-07','%Y-%m-%d')),
		('吳永志', 0987654321,'empaccount2', 'emppassword2','0',STR_TO_DATE('2005-01-07','%Y-%m-%d')),
		('郭惠民', 0912876345,'empaccount3', 'emppassword3','0',STR_TO_DATE('2006-01-07','%Y-%m-%d')),
        ('小當家', 0912876345,'empaccount4', 'emppassword3','0',STR_TO_DATE('2007-01-07','%Y-%m-%d')),
        ('零勝恩', 0912876345,'empaccount5', 'emppassword3','0',STR_TO_DATE('2008-01-07','%Y-%m-%d'));
		
        
-- 後台功能-- 
CREATE TABLE EmpFunction(
funcid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
funcName VARCHAR(40) NOT NULL
);
INSERT INTO EmpFunction(funcName)  
VALUES  ('後台管理'),
		('前台管理'),
		('商城管理'),
        ('課程管理'),
        ('私廚管理');
        
-- 管理員權限 --
 CREATE TABLE AUTHORITY(
empid INT NOT NULL,
funcid INT NOT NULL,
CONSTRAINT AUTHORITY_EMPLOYEE_FK FOREIGN KEY (empid) references EMPLOYEE(empid),
CONSTRAINT AUTHORITY_EMP_FUNCTION_FK FOREIGN KEY (funcid) references EmpFunction(funcid), 
CONSTRAINT PK_AUTHORITY_empid_funcid PRIMARY KEY (empid, funcid) 
);
INSERT INTO AUTHORITY(empid, funcid)
VALUES  (101, 1),(101,2),(101,3),(101,4),(101,5),(104,5),(105,5);

-- 公告 --
create table ANNOUNCEMENT(
annid int auto_increment not null primary key,
empid int not null,
annContent varchar(255),
annPic longblob,
annStatus tinyint (1) default '0',
annUpdate datetime not null default current_timestamp on update current_timestamp,
annTime datetime not null default current_timestamp,
constraint ANNOUNCEMENT_EMPLOYEE_FK foreign key(empid) references EMPLOYEE(empid) 
);

insert into ANNOUNCEMENT(empid,annContent)
VALUES ('101','慶祝父親節，全館88折'),
	   ('102','歡慶中元節，全館9折'),
       ('103','光棍節快樂，全館1.1折起');

-- ================== CREATE TABLE(客服相關）================== --

-- 客服關鍵字 --
create table KeyWord(
	kwid int auto_increment not null primary key,
	kwName varchar(45) not null,
	kwContext varchar(255) not null
);

insert into KeyWord (kwName,kwContext)
value('會員',"1"),
	 ('商城',"2"),
	 ('課程',"3"),
	 ('私廚',"4"),
	 ('食譜',"5"),
	 ('討論區',"6"),
	 ('客服',"7"),
	 ('優惠','8');

-- 客服聊天紀錄 --
create table MemberServiceRecord(
	msrid int auto_increment not null primary key,
	empid int not null,
    constraint MemberServiceRecord_Employee_fk foreign key (empid) references Employee(empid),
	memid int not null,
    constraint MemberServiceRecord_Member_fk foreign key (memid) references Member(memid),
	msrText varchar(3000),
	msrTime	datetime default current_timestamp on update current_timestamp not null,
	direction tinyint not null
);

insert into MemberServiceRecord (empid,memid,msrText,direction)
value(101,201,"HI",0),
	 (101,201,"Hello",0),
	 (101,201,"Hello World",1),
	 (101,202,"HI",0),
	 (101,202,"Hello",0),
	 (101,202,"Hello World",1);

-- 客服聊天圖片 --
create table MemberServicePicture(
	mspPicid int auto_increment not null primary key,
	msrid	int not null ,
    constraint MemberServicePicture_MemberServiceRecord_fk foreign key (msrid) references MemberServiceRecord(msrid),
	mspPic longblob 
);

insert into MemberServicePicture(msrid,mspPic)
value(1,null),
	 (2,null);
     
-- ================== CREATE TABLE(課程相關）================== --

-- 教師 --
create table Teacher(
	thrid int primary key not null auto_increment,
    thrName varchar(20) not null,
    thrGender varchar(5) not null,
    thrPhone varchar(10) not null,
    thrEmail varchar(100),
    thrStatus tinyint(1) not null,
    thrIntroduction varchar(1000),
    thrComment int,
    thrCmnumber int,
    thrPic longblob
);
insert into Teacher(thrName,thrGender,thrPhone,thrEmail,thrStatus,thrIntroduction) 
value('楊小弟','男','0912345678','yang123@gmail.com','0','從事廚藝相關工作近十年，一直對於料理擁有很高度的熱情，偉忠老師認為是料理帶他走入整個世界，不僅因為到世界各地從事料理工作而開闊眼界，更因為料理讓自己的生活更加豐富精采。包括曾經參與邦交國的晚宴以及去杜拜帆船飯店擔任廚師等等過程，不同經歷讓他增加更多對料理技藝的深度，也認為自己對料理的執著是支持他走下去的動力。在學校授課時，他最常告訴學生一段話：「給自己目標不管做什麼，只要是對的，就堅持到底。」也因為經歷豐富，常到世界各地交流廚藝，因此中、日、西式及現在相當流行的異國創意料理都相當擅長。現在偉忠老師來到窩廚房，將他對料理滿滿的熱情與技巧都傳遞給大家，跟著偉忠老師一起探索廚藝吧！'),
	 ('林某宏','男','0987654321','linnnnnn@yahoo.com.tw','0','從老字號新都里懷石日本料理餐廳開始，歷經大倉久和飯店及日本Tokyo Baycourt Club的歷練，十數年正宗日料的深厚功力，透過俐落雙手與親切風趣的教學，把嚴謹繁複的正統日本料理，變成大家開心煮的好滋味，在家輕鬆端出和風好料理，你家也有不一樣的和食餐桌！'),
	 ('楊大姊','女','0909876543','sisterrrrrr@gmail.com','0','從小就愛窩在廚房看媽媽做菜的Maggie，對於做菜時的視覺、聽覺及味覺的感受著迷不已，於是開始自己專研廚藝，專精於烘焙甜點、創意料理。喜歡簡單、純粹的原味，現任窩廚房講師，希望透過餐桌上人與人之間互動、與美味的料理來傳遞幸福。');

-- 課程標籤 --
create table ClassTag(
	claTagid int primary key not null auto_increment,
    claTagName varchar(100) not null,
    claTagStatus tinyint(1) not null
);
insert into ClassTag(claTagName,claTagStatus) 
value('中式烹飪','0'),
	 ('西式法餐','0'),
     ('蛋糕甜點','0');

-- 課程資訊 --
create table ClassIfm(
	claid int  primary key not null auto_increment,
    thrid int not null,
    CONSTRAINT ClassIfm_Teacher_FK FOREIGN KEY (thrid) REFERENCES Teacher (thrid),
    claTagid int not null,
    CONSTRAINT ClassIfm_ClassTag_FK FOREIGN KEY (claTagid) REFERENCES ClassTag (claTagid),
    claTitle varchar(100) not null,
    claIntroduction varchar(1000) not null,
    claTime datetime not null,
    claPrice int not null,
    claPeopleMax int not null,
    claPeopleMin int not null,
    claPeople int not null,
    claStatus tinyint(1) not null,
    claStrTime datetime not null,
    claFinTime datetime not null

);
insert into ClassIfm(thrid,claTagid,claTitle,claIntroduction,claTime,claPrice,claPeopleMax,claPeopleMin,claPeople,claStatus,claStrTime,claFinTime) 
value ('3','1','傳湘千里湖南菜-剁椒魚頭','剁椒魚頭將肥美大魚頭的鮮味和剁椒的辣融合為一，蒸煮後香氣四溢，鹹辣可口，這道料理風味有層次，學會訣竅後準備也不複雜，宴客的時候又非常好看、大氣，是非常有上館子感覺的正宗湖南好味道！','2022-12-25 10:00:00','1500','10','4','0','0','2022-12-01 00:00:00','2022-12-20 10:00:00'),
	  ('1','3','一吻傾心黑醋栗玫瑰塔','以法式甜點表露甜蜜心意，以熱情香氛創造伴侶間浪漫的回憶。彭建文老師以一吻傾心香氛蠟燭的香氛調發想，設計充滿法式風情的精緻法式甜點。用黑醋栗果泥製作市面少見的黑醋栗水果奶油霜，搭配玫瑰香緹，黑醋栗的酸甜香氣搭配玫瑰溫柔淡雅的清香，奶油霜和香緹以花嘴巧妙裝飾在塔殼上，整道甜點外型絕美、風味清爽而不膩口。今年的七夕情人節還沒想好要怎麼慶祝嗎？嘗一口黑醋栗玫瑰塔，點起香氛蠟燭，彷彿置身芬芳馥郁的普羅旺斯花園，一起創造最浪漫的夜晚吧！','2023-03-25 10:00:00','2000','10','3','0','0','2023-01-01 00:00:00','2022-03-20 10:00:00'),
	  ('2','2','名廚來晚餐－熱情西班牙餐桌','西班牙飲食文化非常繽紛多彩，中世紀時受到阿拉伯人統治，引入了大量的香料和食材，據傳西班牙燉飯(在台灣以西班牙海鮮飯較為知名)，就是這個時期產生的特色料理。偉忠老師這次要帶來在家中餐桌上也能嚐到的西班牙燉飯，透過聰明作法，縮短料理時間，晚餐或是宴客都能輕鬆上桌。週五晚上跟著偉忠老師學習，享受一場來自西班牙的異國美食饗宴吧！','2023-10-25 10:00:00','2500','10','8','0','0','2023-08-01 00:00:00','2023-10-20 10:00:00');

-- 課程圖片 --
create table ClassPicture(
	claPicid int primary key not null auto_increment,
    claid int not null,
    CONSTRAINT ClassPicture_ClassIfm_FK FOREIGN KEY (claid) REFERENCES ClassIfm (claid)	,
    claPic longblob
);
insert into ClassPicture(claid) 
value (1),
      (2),
	  (3);
	
-- 報名表 --
create table RegisttrationForm(
	claid int not null ,
	memid int not null ,
	regPayment TINYINT(1) not null,
	regTime datetime default current_timestamp on update current_timestamp not null,
	regStatus TINYINT(1) not null,
	regReview TINYINT(1),
	regReviewContent VARCHAR(255),
    primary key(claid, memid),
    constraint RegisttrationForm_ClassIfm_fk foreign key (claid) references ClassIfm(claid),
    constraint RegisttrationForm_Member_fk foreign key (memid) references Member(memid)
);
insert into RegisttrationForm(claid,memid,regPayment,regStatus)
values (1,201,1,0),
	   (1,202,1,0),
	   (2,201,0,0),
	   (2,202,0,0);

-- ================== CREATE TABLE(私廚相關）================== --
-- 私廚 --
CREATE TABLE Chef(
chefid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
chefAccount VARCHAR(20) NOT NULL UNIQUE,
chefPassword VARCHAR(20) NOT NULL,
chefStatus TINYINT DEFAULT(0),
chefName VARCHAR(45) NOT NULL,
chefNickname VARCHAR(45),
chefPrice INT NOT NULL,
schDate VARCHAR(7) DEFAULT('0000000'),
reserve INT,
com INT,
gomg INT,
license LONGBLOB,
idCard LONGBLOB,
idCardBack LONGBLOB,
chefPhoto LONGBLOB,
chefIntroduction VARCHAR(250)
)auto_increment=301;
INSERT INTO Chef(chefAccount, chefPassword, chefName, chefNickname, chefPrice)
VALUES  ('Account1', 'Pass123', '張正弘', '小弘', 10000),
		('Account2', 'Pass456', '張正弘2', '小弘2', 20000),
		('Account3', 'Pass789', '張正弘3', '小弘3', 30000);
        
-- 專長種類 -- 
CREATE TABLE ChefSkillsType(
skillid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
skill VARCHAR(100)
);
INSERT INTO ChefSkillsType(skill)  
VALUES  ('中式料理'),
		('台式料理'),
		('義式料理'),
        ('港式料理'),
        ('法式料理'),
        ('美式料理'),
        ('日式料理');
        
-- 私廚預約表 --
CREATE TABLE ChefSchedule(
chefSchid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
chefid INT NOT NULL,
schDate DATE NOT NULL,
schTime TINYINT DEFAULT(3),
CONSTRAINT ChefSchedule_chefid_FK FOREIGN KEY (chefid) REFERENCES chef (chefid)
);
INSERT INTO ChefSchedule(chefid, schDate, schTime)
VALUES  (302, STR_TO_DATE('2022-10-07','%Y-%m-%d'), 2),
 		(302, STR_TO_DATE('2022-10-09','%Y-%m-%d'), 1),
 		(303, STR_TO_DATE('2022-10-10','%Y-%m-%d'), 2); 
        
-- 私廚預約單 -- 
CREATE TABLE ChefAppointmentForm(
apmid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
memid INT NOT NULL,
chefid INT NOT NULL,
apmDate DATE NOT NULL,
apmTime TINYINT,
apmPrice INT NOT NULL,
apmStatus TINYINT DEFAULT(0),
star TINYINT,
comments VARCHAR(500),
CONSTRAINT ChefAppointmentForm_memid_FK FOREIGN KEY (memid) REFERENCES Member (memid),
CONSTRAINT ChefAppointmentForm_chefid_FK FOREIGN KEY (chefid) REFERENCES Chef (chefid)
);
INSERT INTO ChefAppointmentForm(memid, chefid, apmDate, apmTime, apmPrice, apmStatus, star, comments)
VALUES  (202, 301, STR_TO_DATE('2022-11-01','%Y-%m-%d'), 0, 5000, 2, 5, null),
 		(202, 302, STR_TO_DATE('2022-11-02','%Y-%m-%d'), 0, 6000, 2, 5, null),
 		(201, 303, STR_TO_DATE('2022-11-01','%Y-%m-%d'), 0, 5000, 2, 5, '很棒'); 
        
-- 私廚專長-- 
CREATE TABLE ChefSkills(
chefid INT NOT NULL,
skillid INT NOT NULL,
CONSTRAINT PK_ChefSkills_chefid_skillsid PRIMARY KEY (chefid, skillid)
);
INSERT INTO ChefSkills(chefid, skillid)
VALUES  (301, 1), (301, 2), (301, 4),
		(302, 5), (302, 3),
 		(303, 2), (303, 6), (303, 7);
        
-- 私廚訂閱清單 -- 
CREATE TABLE ChefSubscription(
chefid INT NOT NULL,
memid INT NOT NULL,
CONSTRAINT PK_ChefSkills_chefid_memid PRIMARY KEY (chefid, memid) 
);
INSERT INTO ChefSubscription(chefid, memid)
VALUES  (301, 201), 
		(301, 202), 
		(301, 203);
        
-- ================== CREATE TABLE(商城相關）================== --
 
-- 商品種類 --
create table Productsort(
	pdsid int auto_increment not null primary key,
    pdsName varchar(10)
);

insert into productsort(pdsname)
values ('肉'),
	   ('青菜');       

-- 商品 --
create table Product(
	pdid int auto_increment not null primary key,
    pdsid int not null,
    pdName varchar(30) unique,
    pdPrice int not null,
    pdDiscountPrice int,
    pdDescription varchar(200),
    pdStatus tinyint(1) not null default 0,
    pdUpdate datetime default current_timestamp on update current_timestamp not null,
    constraint product_productsort_fk FOREIGN KEY (pdsid) REFERENCES productsort(pdsid)
)auto_increment=4001;
insert into product(pdsid, pdname, pdprice, pddiscountprice, pddescription)
values (1, '牛肉', 300, 250, '曰本和牛'),
       (2, '香菜', 10, 10, '不吃香菜都邪教');
       
-- 商品圖片 --
create table ProductPic (
	pdPicid int auto_increment not null primary key,
    pdid int,
    pdPic longblob,
    constraint productpic_product_fk foreign key (pdid) references product(pdid)
);
insert into productpic(pdid)
values (4001),
       (4002);

-- 收藏商品 -- 
create table FavoriteProduct(
	pdid int not null,
    memid int not null,
    constraint favoriteProduct_product_fk foreign key (pdid) references product(pdid),
    constraint favoriteProduct_member_fk foreign key (memid) references member(memid),
    primary key(pdid, memid)
);
insert into favoriteproduct(pdid, memid)
values (4001, 202),
       (4002, 202);
       
-- 購物車-- 
create table cartDetail(
	memid int not null,
    pdid int not null,
    pdNumber int not null,
    constraint cartDetail_member_fk foreign key (memid) references member(memid),
    constraint cartDetail_product_fk foreign key (pdid) references product(pdid),
    primary key(memid, pdid)
);
insert into cartDetail(memid, pdid, pdnumber)
values (201, 4001, 3),
	   (201, 4002, 5);

-- 優惠券種類 --
create table CouponType(
	cpTpid int auto_increment not null primary key,
    cpName varchar(45) not null,
    cpDiscount int not null,
    cpStart datetime not null,
    cpEnd datetime not null,
    cpStatus tinyint not null,
    cpPic longblob
);
insert into coupontype(cpname, cpdiscount, cpStart, cpend, cpstatus)
values ('50元購物金', 50, str_to_date('2022-08-20','%Y-%m-%d'), str_to_date('2022-08-31','%Y-%m-%d'), 1),
       ('10元折價券', 10, str_to_date('2022-08-10','%Y-%m-%d'), str_to_date('2022-08-20','%Y-%m-%d'), 0);
 
 -- 活動優惠方案 --
 create table Promotions(
pmid int not null primary key auto_increment,
pmName varchar(45) not null,
pmDescription varchar(255),
pmDiscount decimal(3,2) not null,
pmStart datetime not null,
pmEnd datetime not null,
pmStatus tinyint(1) not null
);

insert into Promotions(pmname,pmdescription,pmdiscount,pmstart,pmend,pmstatus)
values('中秋節特價','所有烤肉相關品項79折',0.79,str_to_date('2022-08-08','%Y-%m-%d'),str_to_date('2022-09-30','%Y-%m-%d'),1);
 
 -- 優惠活動明細 create
create table PromotionsDetail(
pmid int not null,
pdid int not null,
pmpdDiscountPrice int ,
constraint PromotionsDetail_Promotions_fk foreign key (pmid) references Promotions(pmid),
constraint PromotionsDetail_product_fk foreign key (pdid) references product(pdid),
primary key(pmid, pdid));
insert into PromotionsDetail(pmid,pdid,pmpdDiscountPrice)
values(1,4001,399);

	-- 會員優惠券 --
create table MemberCoupon(
	memCpid int auto_increment not null primary key,
    memid int not null,
    cpTpid int not null,
    memCpDate datetime not null,
    memCpStatus tinyint not null,
    memCpRecord datetime,
    constraint MemberCoupon_member_fk foreign key (memid) references member(memid),
    constraint MemberCoupon_CouponType_fk foreign key (cpTpid) references CouponType(cpTpid)
);
insert into membercoupon(memid, cptpid, memcpdate, memcpstatus, memcprecord)
values (201, 1, str_to_date('2022-08-31','%Y-%m-%d'), 1, null),
       (201, 2, str_to_date('2022-08-20','%Y-%m-%d'), 0, str_to_date('2022-08-15','%Y-%m-%d'));
       
-- 訂單 --
create table Orders(
	ordid int auto_increment not null primary key,
    memid int not null,
    memCpid int,
    ordSubtotal int not null,
    ordTotal int not null,
    ordStatus tinyint(1) not null,
    ordCreate datetime default current_timestamp,
    ordRecipient varchar(20) not null,
    recPhone varchar(10) not null,
    ordPayment tinyint(1) not null,
    ordDelivery tinyint(1) not null,
    ordAddress varchar(100) not null,
    ordHopetime datetime
);
insert into orders(memid, memcpid, ordsubtotal, ordtotal, ordstatus, ordrecipient, recphone, ordpayment, orddelivery, ordaddress, ordhopetime)
values (201, null, 270, 270, 1, 'leoblue', '0987654321', 1, 1, '桃園', null),
       (202, 1, 300, 250, 1, 'ericdon', '0912345678', 2, 2, '天龍國', str_to_date('2022-09-01','%Y-%m-%d'));
       
-- 訂單明細 --
create table OrderDetail(
	ordid int not null,
    pdid int not null,
    detailNumber int not null,
    detailPrice int not null,
    detailGoodPrice int not null,
    primary key(ordid, pdid),
    constraint OrderDetail_Orders_fk foreign key (ordid) references Orders(ordid),
    constraint OrderDetail_product_fk foreign key (pdid) references product(pdid)
);
insert into orderdetail(ordid, pdid, detailnumber, detailprice, detailgoodprice)
values (1, 4001, 3, 300, 270),
       (1, 4002, 5, 50, 50);

-- ================== CREATE TABLE(食譜相關）================== --

-- 食譜 --
create table Recipe(
	reid int auto_increment not null primary key,
    memid int not null,
    reContext varchar(3000) not null,
    reStime datetime not null default current_timestamp,
    reLtime datetime not null default current_timestamp on update current_timestamp,
    constraint Recipe_member_fk foreign key (memid) references member(memid)
);
insert into recipe(memid, recontext)
values (201, '我不會煮'),
       (201, '叫你媽煮比較快');

-- 食譜收藏 --
create table RecipeCollect(
	reid int not null,
    memid int not null,
    constraint RecipeCollect_Recipe_fk foreign key (reid) references Recipe(reid),
    constraint RecipeCollect_member_fk foreign key (memid) references member(memid),
    primary key(reid, memid)
);
insert into recipecollect(reid, memid)
values (1, 202),
       (2, 202);

-- 食譜組成 --
create table RecipeIngredients(
	reid int not null,
    pdid int not null,
    constraint RecipeIngredients_Recipe_fk foreign key (reid) references Recipe(reid),
    constraint RecipeIngredients_Product_fk foreign key (pdid) references Product(pdid),
    primary key (reid, pdid)
);
insert into recipeingredients(reid, pdid)
values (1, 4001),
       (1, 4002);
       
-- 食譜圖片 --
create table RecipePicture(
	rePicid int auto_increment not null primary key,
    reid int not null,
    rePic longblob,
    constraint RecipePicture_Recipe_fk foreign key (reid) references Recipe(reid)
);
insert into recipepicture(reid)
values (1),
	   (1);
       
       
-- ================== CREATE TABLE(討論區）================== --
                          
-- 討論版 --
CREATE TABLE FORUM(
frid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
frName VARCHAR(45) NOT NULL);

INSERT INTO FORUM(frName)
VALUES ('廚藝討論'),
	   ('烘焙討論'),
       ('廚具討論'),
       ('美味好店'),
       ('閒聊雜談');
       
-- 文章 --
CREATE TABLE ARTICLE(
atcid INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
frid INT NOT NULL,
memid INT NOT NULL,
atcTitle VARCHAR(45) not null,
actContent varchar(3000) not null,
atcStime datetime not null default current_timestamp,
atcLtime datetime not null default current_timestamp on update current_timestamp,
atcLike int,
atcStatus tinyint(1) not null,
constraint ARTICLE_FORUM_FK foreign key (frid) references FORUM(frid),
constraint ARTICLE_MEMBER_FK foreign key (memid) references MEMBER(memid)
);
INSERT INTO ARTICLE(frid, memid, atcTitle, actContent,atcStatus)
	   VALUES (1,201,'會單手打蛋，可以當特級廚師了嗎？','如題，特級廚師什麼時候考試啊？可以帶嘟嘟過去嗎？','1'),
			  (5,202,'咖啡算是一種豆漿嗎？','如題，豆漿是黃豆做的，咖啡是咖啡豆做的，也算是一種豆漿吧？','1'),
              (5,203,'完蛋了，我咬到舌頭！！！','不小心咬到舌頭，我是吃素的，這樣算破戒嗎？','1');
              
-- 文章檢舉 --
create table REPORT(
atcReportid int not null auto_increment primary key,
atcid int not null,
memid int not null,
reportStatus tinyint(1) default '0',
reportContent varchar(300) not null,
constraint REPORT_ARTICLE_FK foreign key (atcid) references ARTICLE (atcid),
constraint REPORT_MEMBER_FK foreign key (memid) references MEMBER (memid)
);
insert into REPORT(atcid, memid, reportContent)
	   VALUES(1,204,'廢文'),
			 (2,204,'又一個廢文'),
             (3,204,'難道這裡只有廢文嗎？');

-- 文章留言 --
create table ArticleMsg(
atcMsgid int auto_increment not null primary key,
atcid int not null,
memid int not null,
msgContent varchar(50) not null,
msgTime datetime not null default current_timestamp,
msgStatus tinyint(1) default '1',
constraint ARTICLE_MSG_ARTICLE_FK foreign key (atcid) references ARTICLE (atcid),
constraint ARTICLE_MSG_MEMBER_FK foreign key (memid) references MEMBER (memid)
);
insert into ArticleMsg(atcid, memid, msgContent)
	   VALUES(1,202,'笑死'),
             (2,203,'那茶也算是一種蔬菜湯吧'),
             (3,201,'我昨晚刷牙流血，吸進去，我也破戒了，完了');

-- 文章留言檢舉 --
create table MsgReport(
msgReportid int auto_increment not null primary key,
atcMsgid int not null,
memid int not null,
msgReportStatus tinyint(1) default '0',
msgReportTime datetime not null default current_timestamp,
msgReportContent varchar(50) not null,
constraint MSG_REPORT_ARTICLE_MSG_FK foreign key (atcMsgid) references ArticleMsg (atcMsgid),
constraint MSG_REPORT_MEMBER_FK foreign key (memid) references MEMBER (memid)
);
insert into MsgReport(atcMsgid,memid,msgReportContent)
       VALUES(2,204,'連留言都廢');
       
-- 文章讚數 --
 CREATE TABLE ArticleGood(
memid INT NOT NULL,
atcid INT NOT NULL,
CONSTRAINT ARTICLE_GOOD_MEMBER_FK FOREIGN KEY (memid) references MEMBER(memid),
CONSTRAINT ARTICLE_GOOD_ARTICLE_FK FOREIGN KEY (atcid) references ARTICLE(atcid), 
CONSTRAINT PK_ARTICLE_GOOD_MEMID_ATCID PRIMARY KEY (memid, atcid) 
);
insert into ArticleGood(memid,atcid)
	   VALUES(202,1);

-- 文章收藏 --
CREATE TABLE ArticleSave(
memid INT NOT NULL,
atcid INT NOT NULL,
CONSTRAINT ARTICLE_SAVE_MEMBER_FK FOREIGN KEY (memid) references MEMBER(memid),
CONSTRAINT ARTICLE_SAVE_ARTICLE_FK FOREIGN KEY (atcid) references ARTICLE(atcid), 
CONSTRAINT PK_ARTICLE_SAVE_MEMID_ATCID PRIMARY KEY (memid, atcid) 
);

insert into ArticleSave(memid,atcid)
	   VALUES(203,2);

-- 文章圖片 --
create table ArticlePicture(
atcPicid int auto_increment not null primary key,
atcid int not null,
atcPic longblob,
constraint ARTICLE_PICTURE_ARTICLE_FK foreign key (atcid) references ARTICLE(atcid)
);
insert into ArticlePicture(atcid,atcPic)
values ('1',null);
