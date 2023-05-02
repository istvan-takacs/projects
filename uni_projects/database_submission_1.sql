/*1A*/
CREATE OR REPLACE FUNCTION input_reversed(input_string IN VARCHAR2) -- creates function that reverses a string
RETURN VARCHAR2
IS
    output_string VARCHAR2(4000);
BEGIN
    FOR i IN REVERSE 1..LENGTH(input_string) -- loops through the string in reverse order and loads that into the output string variable
    LOOP
        output_string := output_string || SUBSTR(input_string, i, 1);
    END LOOP;

    RETURN output_string;
END;


DECLARE -- tests whether the function works
  txt_in VARCHAR2(4000) := 'does this work';
  txt_out VARCHAR2(4000);
BEGIN
  txt_out := input_reversed(txt_in);
  DBMS_OUTPUT.PUT_LINE(txt_out); -- prints 'krow siht seod'
END;

/*1B*/
CREATE OR REPLACE FUNCTION my_factorial(n IN NUMBER) -- creates function to calculate (input number)!
RETURN NUMBER 
IS 
BEGIN 
    IF n = 0 THEN -- the function will no longer call itself if it reaches 0
        RETURN 1; 
    ELSE 
        RETURN n * my_factorial(n - 1); -- function recursively calls itself while decrementing the values of the input
    END IF; 
END; 
 
DECLARE -- tests whether the function works
  num_in INT := 3;
  num_out INT;
BEGIN
  num_out := my_factorial(num_in);
  DBMS_OUTPUT.PUT_LINE(num_out); -- prints '6'
END;

/*3A*/
/*Creating the table*/
CREATE TABLE SpamHam
(In_Ord NUMBER(5) NOT NULL, 
Target VARCHAR2(20), 
DateSent VARCHAR2(30), 
TimeSent VARCHAR2(20), 
Sender VARCHAR2(20), 
Message VARCHAR2(2000));

/*Only inserting two rows for testing the function*/
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (335,'ham','04-01-2009','13:15:14','Robertson','Any chance you might have had with me evaporated as soon as you violated my privacy by stealing my phone number from your employer''s paperwork. Not cool at all. Please do not contact me again or I will report you to your supervisor.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (109,'ham','01-01-2009','0:30:14','Rocha','How would my ip address test that considering my computer isn''t a minecraft server');


/* Creating the function to check whether the input text is present in the 'Message' entries or not*/
CREATE OR REPLACE FUNCTION check_message(input_text IN VARCHAR2)
RETURN VARCHAR2
IS
    found_count NUMBER := 0;
BEGIN -- counting all the occurances of the input text in the message column
    SELECT COUNT(*)
    INTO found_count
    FROM SpamHam
    /*Where input text is like the entry in the message but ignoring case sensitivity*/
    WHERE LOWER(Message) LIKE '%' || LOWER(input_text) || '%';

    IF found_count > 0 THEN -- only interested in whether it is present or not and not how many times
        RETURN 'Found';
    ELSE
        RETURN 'Not Found';
    END IF;
END;

DECLARE -- testing for both a present and not present message
    input_text VARCHAR2(4000) := 'any';
	input_text2 VARCHAR2(4000) := 'efjhkldfvjnksd';
    result_text VARCHAR2(4000);
	result_text2 VARCHAR2(4000);
BEGIN
    result_text := check_message(input_text);
	result_text2 := check_message(input_text2);
    DBMS_OUTPUT.PUT_LINE(result_text); -- prints out found 
	DBMS_OUTPUT.PUT_LINE(result_text2); -- prints out not found
END;
drop table SpamHam;
/*3B*/
/*Creating the table*/
CREATE TABLE SpamHam
(In_Ord NUMBER(5) NOT NULL, 
Target VARCHAR2(20), 
DateSent VARCHAR2(30), 
TimeSent VARCHAR2(20), 
Sender VARCHAR2(20), 
Message VARCHAR2(2000));

/*Only inserting three rows for testing the function*/
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (335,'ham','04-01-2009','13:15:14','Robertson','Any chance you might have had with me evaporated as soon as you violated my privacy by stealing my phone number from your employer''s paperwork. Not cool at all. Please do not contact me again or I will report you to your supervisor.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (335,'ham','04-01-2009','13:15:14','Robertson','Any chance you might have had with me evaporated as soon as you violated my privacy by stealing my phone number from your employer''s paperwork. Not cool at all. Please do not contact me again or I will report you to your supervisor.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (109,'ham','01-01-2009','0:30:14','Rocha','How would my ip address test that considering my computer isn''t a minecraft server');


/* Creating the function to check how many times the input text is present in the 'Message' in either the 'ham' or 'spam' collection */
CREATE OR REPLACE FUNCTION check_message_ham_spam(input_text IN VARCHAR2, spam_ham IN VARCHAR2)
RETURN INT
IS
    found_count_ham NUMBER := 0;
	found_count_spam NUMBER := 0;
BEGIN -- counting all the occurances of the input text in the message column
    /* Incrementing the occurences of the word into the found_count_ham variable*/
    SELECT COUNT(*)
    INTO found_count_ham
    FROM SpamHam
    /*Where input text is like the entry in the message but ignoring case sensitivity*/
    WHERE (LOWER(Message) LIKE '%' || LOWER(input_text) || '%')
    AND Target = 'ham'; --only if it belongs to the ham collection

 	/* Incrementing the occurences of the word into the found_count_spam variable*/
	SELECT COUNT(*)
    INTO found_count_spam
    FROM SpamHam
    /*Where input text is like the entry in the message but ignoring case sensitivity*/
    WHERE (LOWER(Message) LIKE '%' || LOWER(input_text) || '%')
    AND Target = 'spam'; --only if it belongs to the ham collection

	/*If user wants to see the number of occurences in ham collection it returns that value 
	  If user wants to see the number of occurences in spam collection it returns that value */
	IF spam_ham = 'spam' THEN
        RETURN found_count_spam;
    ELSIF spam_ham = 'ham' THEN
        RETURN found_count_ham;
	ElSE
      RETURN 0;  --returns 0 if the collection does not exist
	END IF;
END;

DECLARE -- testing for both a present and not present message
    input_text VARCHAR2(4000) := 'any'; --occurs twice in the 3 rows
	input_text2 VARCHAR2(4000) := 'efjhkldfvjnksd'; --occurs 0 times in the 3 rows
    result_text VARCHAR2(4000);
	result_text2 VARCHAR2(4000);
BEGIN
    result_text := check_message_ham_spam(input_text, 'ham');
	result_text2 := check_message_ham_spam(input_text2, 'spam');
    DBMS_OUTPUT.PUT_LINE(result_text); -- prints out 2 
	DBMS_OUTPUT.PUT_LINE(result_text2); -- prints out 0
END;
drop table SpamHam;
/*3C*/
/*Creating the table*/
CREATE TABLE SpamHam
(In_Ord NUMBER(5) NOT NULL, 
Target VARCHAR2(20), 
DateSent VARCHAR2(30), 
TimeSent VARCHAR2(20), 
Sender VARCHAR2(20), 
Message VARCHAR2(2000));

/*Inserting 150 rows for exploratory analysis*/
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (109,'ham','01-01-2009','0:30:14','Rocha','How would my ip address test that considering my computer isn''t a minecraft server');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (92,'ham','01-01-2009','1:30:08','Collins','Sorry to be a pain. Is it ok if we meet another night? I spent late afternoon in casualty and that means i haven''t done any of y stuff42moro and that includes all my time sheets and that. Sorry.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (41,'ham','01-01-2009','6:16:05','Proctor','Pls go ahead with watts. I just wanted to be sure. Do have a great weekend. Abiola');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (9,'spam','01-01-2009','11:28:48','Collins','WINNER!! As a valued network customer you have been selected to receivea £900 prize reward! To claim call 09061701461. Claim code KL341. Valid 12 hours only.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (3,'spam','01-01-2009','3:41:13','Thompson','Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C''s apply 08452810075over18''s');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (16,'spam','01-01-2009','20:36:55','Jones','XXXMobileMovieClub: To use your credit, click the WAP link in the next txt message or click here>> http://wap. xxxmobilemovieclub.com?n=QJKGIGHJJGCBL');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (66,'spam','01-01-2009','18:39:52','Jones','As a valued customer, I am pleased to advise you that following recent review of your Mob No. you are awarded with a £1500 Bonus Prize, call 09066364589');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (45,'ham','01-01-2009','12:17:59','Carrillo','Great! I hope you like your man well endowed. I am  &lt:#&gt:  inches...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (46,'ham','01-01-2009','13:50:24','Rocha','No calls..messages..missed calls');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (57,'spam','01-01-2009','7:09:56','Adams','Congrats! 1 year special cinema pass for 2 is yours. call 09061209465 now! C Suprman V, Matrix3, StarWars3, etc all 4 FREE! bx420-ip4-5we. 150pm. Dont miss out!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (12,'spam','01-01-2009','14:49:40','Smith','SIX chances to win CASH! From 100 to 20,000 pounds txt> CSH11 and send to 87575. Cost 150p/day, 6days, 16+ TsandCs apply Reply HL 4 info');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (122,'spam','01-01-2009','13:45:41','Thompson','URGENT! Your Mobile No. was awarded £2000 Bonus Caller Prize on 5/9/03 This is our final try to contact U! Call from Landline 09064019788 BOX42WR29C, 150PPM');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (1,'ham','01-01-2009','0:00:00','Santana','Go until jurong point, crazy.. Available only in bugis n great world la e buffet... Cine there got amore wat...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (70,'ham','01-01-2009','1:03:45','Benjamin','I plane to give on this month end.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (120,'ham','01-01-2009','12:10:57','Campbell','Hmm...my uncle just informed me that he''s paying the school directly. So pls buy food.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (95,'ham','01-01-2009','5:26:33','Sosa','Havent planning to buy later. I check already lido only got 530 show in e afternoon. U finish work already?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (59,'ham','01-01-2009','11:11:42','Dalton','Tell where you reached');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (35,'spam','01-01-2009','21:10:42','Ross','Thanks for your subscription to Ringtone UK your mobile will be charged £5/month Please confirm by replying YES or NO. If you reply NO you will not be charged');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (6,'spam','01-01-2009','8:37:40','Adams','FreeMsg Hey there darling it''s been 3 week''s now and no word back! I''d like some fun you up for it still? Tb ok! XxX std chgs to send, £1.50 to rcv');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (55,'spam','01-01-2009','2:46:32','Smith','SMS. ac Sptv: The New Jersey Devils and the Detroit Red Wings play Ice Hockey. Correct or Incorrect? End? Reply END SPTV');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (115,'spam','01-01-2009','5:35:32','Thompson','GENT! We are trying to contact you. Last weekends draw shows that you won a £1000 prize GUARANTEED. Call 09064012160. Claim Code K52. Valid 12hrs only. 150ppm');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (13,'spam','01-01-2009','17:02:31','Smith','URGENT! You have won a 1 week FREE membership in our £100,000 Prize Jackpot! Txt the word: CLAIM to No: 81010 T&C www.dbuk.net LCCLTD POBOX 4403LDNW1A7RW18');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (10,'spam','01-01-2009','11:58:27','Smith','Had your mobile 11 months or more? U R entitled to Update to the latest colour mobiles with camera for Free! Call The Mobile Update Co FREE on 08002986030');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (20,'spam','01-01-2009','3:15:22','Williams','England v Macedonia - dont miss the goals/team news. Txt ur national team to 87077 eg ENGLAND to 87077 Try:WALES, SCOTLAND 4txt/u1.20 POBOXox36504W45WQ 16+');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (121,'spam','01-01-2009','12:29:39','Thompson','PRIVATE! Your 2004 Account Statement for 07742676969 shows 786 unredeemed Bonus Points. To claim call 08719180248 Identifier Code: 45239 Expires');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (36,'ham','01-01-2009','23:13:31','Barker','Yup... Ok i go home look at the timings then i msg u again... Xuhui going to learn on 2nd may too but her lesson is at 8am');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (61,'ham','01-01-2009','13:13:05','Collins','Your gonna have to pick up a $1 burger for yourself on your way home. I can''t even move. Pain is killing me.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (14,'ham','01-01-2009','19:10:26','Benitez','I''ve been searching for the right words to thank you for this breather. I promise i wont take your help for granted and will fulfil my promise. You have been wonderful and a blessing at all times.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (84,'ham','01-01-2009','17:34:05','Jennings','You will be in the place of that man');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (42,'ham','01-01-2009','7:49:22','Rocha','Did I forget to tell you ? I want you , I need you, I crave you ... But most of all ... I love you my sweet Arabian steed ... Mmmmmm ... Yummy');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (91,'ham','01-01-2009','1:15:21','Romero','Yeah do! Don''t stand to close tho- you''ll catch something!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (49,'ham','01-01-2009','17:50:41','Carrillo','Yeah hopefully, if tyler can''t do it I could maybe ask around a bit');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (43,'spam','01-01-2009','8:43:04','Thompson','07732584351 - Rodger Burns - MSG = We tried to call you re your reply to our sms for a free nokia mobile + free camcorder. Please call now 08000930705 for delivery tomorrow');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (118,'spam','01-01-2009','11:09:14','Thompson','You are a winner U have been specially selected 2 receive £1000 or a 4* holiday (flights inc) speak to a live operator 2 claim 0871277810910p/min (18+)');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (69,'spam','01-01-2009','23:03:20','Collins','"Did you hear about the new ""Divorce Barbie""? It comes with all of Ken''s stuff!"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (96,'spam','01-01-2009','5:40:05','Thompson','"Your free ringtone is waiting to be collected. Simply text the password ""MIX"" to 85069 to verify. Get Usher and Britney. FML, PO Box 5249, MK17 92H. 450Ppw 16"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (94,'spam','01-01-2009','3:55:02','Smith','Please call our customer service representative on 0800 169 6031 between 10am-9pm as you have WON a guaranteed £1000 cash or £5000 prize!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (189,'spam','02-01-2009','0:39:30','Smith','Please call our customer service representative on FREEPHONE 0808 145 4742 between 9am-11pm as you have WON a guaranteed £1000 cash or £5000 prize!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (151,'ham','02-01-2009','0:36:25','Odonnell','Sindu got job in birla soft ..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (144,'ham','02-01-2009','15:17:24','Flynn','"A swt thought: ""Nver get tired of doing little things 4 lovable persons.."" Coz..somtimes those little things occupy d biggest part in their Hearts.. Gud ni8"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (211,'ham','02-01-2009','4:03:53','Gill','Both :) i shoot big loads so get ready!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (136,'spam','02-01-2009','7:10:29','Smith','Want 2 get laid tonight? Want real Dogging locations sent direct 2 ur mob? Join the UK''s largest Dogging Network bt Txting GRAVEL to 69888! Nt. ec2a. 31p.msg@150p');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (166,'spam','02-01-2009','21:26:37','Collins','BangBabes Ur order is on the way. U SHOULD receive a Service Msg 2 download UR content. If U do not, GoTo wap. bangb. tv on UR mobile internet/service menu');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (176,'ham','02-01-2009','7:58:07','Carrillo','Well, i''m gonna finish my bath now. Have a good...fine night.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (174,'ham','02-01-2009','5:55:18','Beltran','What time you coming down later?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (158,'ham','02-01-2009','9:20:06','Whitehead','I''m leaving my house now...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (165,'spam','02-01-2009','20:11:16','Adams','-PLS STOP bootydelious (32/F) is inviting you to be her friend. Reply YES-434 or NO-434 See her: www.SMS.ac/u/bootydelious STOP? Send STOP FRND to 62468');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (192,'spam','02-01-2009','3:56:07','Ross','Are you unique enough? Find out from 30th August. www.areyouunique.co.uk');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (134,'ham','02-01-2009','3:43:49','Kerr','First answer my question.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (141,'ham','02-01-2009','13:21:05','Romero','Got c... I lazy to type... I forgot u in lect... I saw a pouch but like not v nice...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (149,'ham','02-01-2009','20:39:49','Smith','Ummma.will call after check in.our life will begin from qatar so pls pray very hard.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (131,'ham','02-01-2009','22:39:25','Whitehead','K..k:)how much does it cost?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (148,'spam','02-01-2009','18:49:17','Adams','FreeMsg Why haven''t you replied to my text? I''m Randy, sexy, female and live local. Luv to hear from u. Netcollex Ltd 08700621170150p per msg reply Stop to end');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (135,'spam','02-01-2009','5:24:23','King','Sunshine Quiz Wkly Q! Win a top Sony DVD player if u know which country the Algarve is in? Txt ansr to 82277. £1.50 SP:Tyrone');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (178,'ham','02-01-2009','10:22:06','Mcmillan','U still going to the mall?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (175,'ham','02-01-2009','6:56:36','Barker','Bloody hell, cant believe you forgot my surname Mr . Ill give u a clue, its spanish and begins with m...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (168,'spam','02-01-2009','23:26:32','Smith','URGENT! We are trying to contact you. Last weekends draw shows that you have won a £900 prize GUARANTEED. Call 09061701939. Claim code S89. Valid 12hrs only');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (185,'ham','02-01-2009','19:12:09','Hoffman','He will, you guys close?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (212,'ham','02-01-2009','5:56:04','King','What''s up bruv, hope you had a great break. Do have a rewarding semester.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (160,'spam','02-01-2009','10:36:18','Jones','Customer service annoncement. You have a New Years delivery waiting for you. Please call 07046744435 now to arrange delivery');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (177,'ham','02-01-2009','9:18:17','York','Let me know when you''ve got the money so carlos can make the call');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (183,'ham','02-01-2009','15:49:52','Mcmillan','Lol no. U can trust me.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (187,'ham','02-01-2009','21:49:09','Santana','Hello handsome ! Are you finding that job ? Not being lazy ? Working towards getting back that net for mummy ? Where''s my boytoy now ? Does he miss me ?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (161,'spam','02-01-2009','12:33:02','Smith','You are a winner U have been specially selected 2 receive £1000 cash or a 4* holiday (flights inc) speak to a live operator 2 claim 0871277810810');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (190,'ham','02-01-2009','2:22:12','York','Have you got Xmas radio times. If not i will get it now');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (200,'ham','02-01-2009','13:40:25','Carrillo','Hi its Kate how is your evening? I hope i can see you tomorrow for a bit but i have to bloody babyjontet! Txt back if u can. :) xxx');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (205,'ham','02-01-2009','22:35:55','Smith','Goodmorning sleeping ga.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (140,'spam','02-01-2009','12:49:16','Collins','You''ll not rcv any more msgs from the chat svc. For FREE Hardcore services text GO to: 69988 If u get nothing u must Age Verify with yr network & try again');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (132,'ham','02-01-2009','0:11:23','Adams','I''m home.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (226,'spam','03-01-2009','22:33:17','Adams','500 New Mobiles from 2004, MUST GO! Txt: NOKIA to No: 89545 & collect yours today!From ONLY £1 www.4-tc.biz 2optout 087187262701.50gbp/mtmsg18');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (265,'spam','03-01-2009','20:44:00','Collins','Hey I am really horny want to chat or see me naked text hot to 69698 text charged at 150pm to unsubscribe text stop 69698');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (233,'ham','03-01-2009','5:33:43','Benson','Dear we are going to our rubber place');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (248,'ham','03-01-2009','4:27:24','Wong','I asked you to call him now ok');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (264,'ham','03-01-2009','18:39:24','Santana','MY NO. IN LUTON 0125698789 RING ME IF UR AROUND! H*');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (276,'ham','03-01-2009','13:01:33','Proctor','No objection. My bf not coming.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (260,'spam','03-01-2009','15:39:42','Collins','We tried to contact you re your reply to our offer of a Video Handset? 750 anytime networks mins? UNLIMITED TEXT? Camcorder? Reply or call 08000930705 NOW');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (293,'ham','03-01-2009','10:46:58','Giles','Haf u found him? I feel so stupid da v cam was working.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (289,'ham','03-01-2009','6:00:06','Thompson','hi baby im cruisin with my girl friend what r u up 2? give me a call in and hour at home if thats alright or fone me on this fone now love jenny xxx');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (236,'spam','03-01-2009','8:54:57','Collins','Text & meet someone sexy today. U can find a date or even flirt its up to U. Join 4 just 10p. REPLY with NAME & AGE eg Sam 25. 18 -msg recd@thirtyeight pence');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (249,'ham','03-01-2009','5:09:50','Berry','Kallis wont bat in 2nd innings.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (216,'ham','03-01-2009','11:48:35','Tate','Sounds great! Are you home now?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (229,'ham','03-01-2009','1:19:35','Benson','Hey company elama po mudyadhu.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (310,'spam','03-01-2009','2:57:31','Thompson','TheMob> Check out our newest selection of content, Games, Tones, Gossip, babes and sport, Keep your mobile fit and funky text WAP to 82468');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (261,'ham','03-01-2009','16:20:43','Beltran','I''m parked next to a MINI!!!! When are you coming in today do you think?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (298,'ham','03-01-2009','17:15:46','Collins','Unless it''s a situation where YOU GO GURL would be more appropriate');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (313,'spam','03-01-2009','6:43:32','Adams','Think ur smart ? Win £200 this week in our weekly quiz, text PLAY to 85222 now!T&Cs WinnersClub PO BOX 84, M26 3UZ. 16+. GBP1.50/week');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (295,'ham','03-01-2009','11:47:04','Dalton','Are you this much buzy');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (228,'spam','03-01-2009','23:34:38','King','Will u meet ur dream partner soon? Is ur career off 2 a flyng start? 2 find out free, txt HORO followed by ur star sign, e. g. HORO ARIES');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (235,'ham','03-01-2009','6:51:55','Love','Yes:)here tv is always available in work place..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (286,'ham','03-01-2009','2:57:07','Ballard','Yeah I think my usual guy''s still passed out from last night, if you get ahold of anybody let me know and I''ll throw down');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (320,'spam','03-01-2009','18:28:10','Williams','December only! Had your mobile 11mths+? You are entitled to update to the latest colour camera mobile for Free! Call The Mobile Update Co FREE on 08002986906');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (241,'spam','03-01-2009','17:09:45','Thompson','U 447801259231 have a secret admirer who is looking 2 make contact with U-find out who they R*reveal who thinks UR so special-call on 09058094597');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (303,'ham','03-01-2009','21:35:00','Lawson','Shit that is really shocking and scary, cant imagine for a second. Def up for night out. Do u think there is somewhere i could crash for night, save on taxi?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (278,'ham','03-01-2009','16:56:00','York','Tell rob to mack his gf in the theater');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (222,'ham','03-01-2009','17:21:41','King','Ok no prob. Take ur time.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (271,'spam','03-01-2009','7:28:21','Ross','Ringtone Club: Get the UK singles chart on your mobile each week and choose any top quality ringtone! This message is free of charge.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (238,'ham','03-01-2009','12:15:42','Thompson','Or ill be a little closer like at the bus stop on the same street');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (280,'ham','03-01-2009','18:31:29','Giles','Just sent it. So what type of food do you like?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (274,'spam','03-01-2009','10:55:17','Ross','HMV BONUS SPECIAL 500 pounds of genuine HMV vouchers to be won. Just answer 4 easy questions. Play Now! Send HMV to 86688 More info:www.100percent-real.com');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (251,'spam','03-01-2009','6:18:04','Ross','Congratulations ur awarded 500 of CD vouchers or 125gift guaranteed & Free entry 2 100 wkly draw txt MUSIC to 87066 TnCs www.Ldew.com1win150ppmx3age16');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (283,'ham','03-01-2009','22:38:48','King','Wen u miss someone, the person is definitely special for u..... But if the person is so special, why to miss them, just Keep-in-touch gdeve..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (224,'ham','03-01-2009','20:10:58','Rich','Sorry, I''ll call later');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (297,'spam','03-01-2009','15:17:25','Jones','T-Mobile customer you may now claim your FREE CAMERA PHONE upgrade & a pay & go sim card for your loyalty. Call on 0845 021 3680.Offer ends 28thFeb.T&C''s apply');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (263,'ham','03-01-2009','18:24:56','Clayton','Anyway i''m going shopping on my own now. Cos my sis not done yet. Dun disturb u liao.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (308,'ham','03-01-2009','0:35:44','Brooks','Jos ask if u wana meet up?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (306,'spam','03-01-2009','23:19:13','King','SMS. ac Blind Date 4U!: Rodds1 is 21/m from Aberdeen, United Kingdom. Check Him out http://img. sms. ac/W/icmb3cktz8r7!-4 no Blind Dates send HIDE');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (324,'ham','03-01-2009','0:52:22','King','cud u tell ppl im gona b a bit l8 cos 2 buses hav gon past cos they were full & im still waitin 4 1. Pete x');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (304,'ham','03-01-2009','21:54:14','Perry','Oh and by the way you do have more food in your fridge! Want to go out for a meal tonight?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (270,'ham','03-01-2009','6:07:33','Ballard','The evo. I just had to download flash. Jealous?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (269,'spam','03-01-2009','4:48:39','Williams','Ur ringtone service has changed! 25 Free credits! Go to club4mobiles.com to choose content now! Stop? txt CLUB STOP to 87070. 150p/wk Club4 PO Box1146 MK45 2WT');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (328,'ham','03-01-2009','5:30:47','King','Hi da:)how is the todays class?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (301,'ham','03-01-2009','18:46:45','King','Need a coffee run tomo?Can''t believe it''s that time of week already');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (290,'ham','03-01-2009','7:11:09','Clayton','My life Means a lot to me, Not because I love my life, But because I love the people in my life, The world calls them friends, I call them my World:-).. Ge:-)..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (355,'ham','04-01-2009','15:18:36','Mccarty','Yo you guys ever figure out how much we need for alcohol? Jay and I are trying to figure out how much we can safely spend on weed');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (359,'spam','04-01-2009','22:35:09','Ross','Ur cash-balance is currently 500 pounds - to maximize ur cash-in now send CASH to 86688 only 150p/msg. CC: 08708800282 HG/Suite342/2Lands Row/W1J6HL');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (395,'ham','04-01-2009','16:03:08','King','Yes i think so. I am in office but my lap is in room i think thats on for the last few days. I didnt shut that down');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (349,'ham','04-01-2009','7:08:39','Brooks','One small prestige problem now.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (363,'ham','04-01-2009','3:32:34','Adams','Oh ok no prob..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (369,'spam','04-01-2009','13:48:35','Collins','Here is your discount code RP176781. To stop further messages reply stop. www.regalportfolio.co.uk. Customer Services 08717205546');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (350,'spam','04-01-2009','8:26:50','Adams','Fancy a shag? I do.Interested? sextextuk.com txt XXUK SUZY to 69876. Txts cost 1.50 per msg. TnCs on website. X');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (380,'ham','04-01-2009','23:18:08','Whitehead','Keep my payasam there if rinu brings');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (376,'spam','04-01-2009','21:26:11','Williams','Thanks for your Ringtone Order, Reference T91. You will be charged GBP 4 per week. You can unsubscribe at anytime by calling customer services on 09057039994');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (353,'ham','04-01-2009','11:22:10','Benson','If you''re not in my car in an hour and a half I''m going apeshit');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (358,'spam','04-01-2009','20:48:48','Collins','Congratulations ur awarded 500 of CD vouchers or 125gift guaranteed & Free entry 2 100 wkly draw txt MUSIC to 87066 TnCs www.Ldew.com1win150ppmx3age16');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (397,'ham','04-01-2009','17:13:48','Smith','From here after The performance award is calculated every two month.not for current one month period..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (381,'ham','04-01-2009','23:42:15','Sosa','I taught that Ranjith sir called me. So only i sms like that. Becaus hes verifying about project. Prabu told today so only pa dont mistake me..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (396,'ham','04-01-2009','16:27:34','Rosario','Pick you up bout 7.30ish? What time are  and that going?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (400,'ham','04-01-2009','19:56:46','Rocha','Good evening Sir, Al Salam Wahleykkum.sharing a happy news.By the grace of God, i got an offer from Tayseer,TISSCO and i joined.Hope you are fine.Inshah Allah,meet you sometime.Rakhesh,visitor from India.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (357,'ham','04-01-2009','18:30:51','Smith','Thank You for calling.Forgot to say Happy Onam to you Sirji.I am fine here and remembered you when i met an insurance person.Meet You in Qatar Insha Allah.Rakhesh, ex Tata AIG who joined TISSCO,Tayseer.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (386,'spam','04-01-2009','4:58:59','Jones','Double mins and txts 4 6months FREE Bluetooth on Orange. Available on Sony, Nokia Motorola phones. Call MobileUpd8 on 08000839402 or call2optout/N9DX');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (331,'ham','04-01-2009','9:24:05','Lee','I''m reading the text i just sent you. Its meant to be a joke. So read it in that light');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (405,'ham','04-01-2009','0:10:36','Ayala','None of that''s happening til you get here though');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (371,'ham','04-01-2009','16:43:19','Mccarty','Cool, text me when you''re ready');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (343,'ham','04-01-2009','0:15:01','Rosario','I take it the post has come then! You must have 1000s of texts now! Happy reading. My one from wiv hello caroline at the end is my favourite. Bless him');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (383,'ham','04-01-2009','3:15:03','Flores','Yeah sure, give me a couple minutes to track down my wallet');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (362,'ham','04-01-2009','3:24:04','Hayden','Ha ha cool cool chikku chikku:-):-DB-)');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (394,'ham','04-01-2009','15:59:19','Williams','Morning only i can ok.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (336,'spam','04-01-2009','13:23:42','Thompson','Valentines Day Special! Win over £1000 in our quiz and take your partner on the trip of a lifetime! Send GO to 83600 now. 150p/msg rcvd. CustCare:08718720201.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (377,'ham','04-01-2009','22:05:03','Benson','Can you say what happen');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (390,'spam','04-01-2009','9:56:26','King','4mths half price Orange line rental & latest camera phones 4 FREE. Had your phone 11mths ? Call MobilesDirect free on 08000938767 to update now! or2stoptxt');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (384,'ham','04-01-2009','4:19:31','Garrison','Hey leave it. not a big deal:-) take care.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (334,'spam','04-01-2009','12:43:51','Smith','Call Germany for only 1 pence per minute! Call from a fixed line via access number 0844 861 85 85. No prepayment. Direct access!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (385,'ham','04-01-2009','4:29:14','Williams','Hey i will be late ah... Meet you at 945+');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (402,'spam','04-01-2009','20:40:31','Ross','FREE RINGTONE text FIRST to 87131 for a poly or text GET to 87131 for a true tone! Help? 0845 2814032 16 after 1st free, tones are 3x£150pw to e£nd txt stop');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (352,'ham','04-01-2009','10:01:53','Maynard','Nah can''t help you there, I''ve never had an iphone');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (348,'ham','04-01-2009','5:45:08','King','Dis is yijue. I jus saw ur mail. In case huiming havent sent u my num. Dis is my num.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (368,'spam','04-01-2009','12:13:19','Collins','Update_Now - Xmas Offer! Latest Motorola, SonyEricsson & Nokia & FREE Bluetooth! Double Mins & 1000 Txt on Orange. Call MobileUpd8 on 08000839402 or call2optout/F4Q=');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (382,'ham','04-01-2009','1:33:46','York','I guess that''s why you re worried. You must know that there''s a way the body repairs itself. And i''m quite sure you shouldn''t worry. We''ll take it slow.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (398,'ham','04-01-2009','17:26:56','Hayden','Was actually sleeping and still might when u call back. So a text is gr8. You rock sis. Will send u a text wen i wake.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (335,'ham','04-01-2009','13:15:14','Robertson','Any chance you might have had with me evaporated as soon as you violated my privacy by stealing my phone number from your employer''s paperwork. Not cool at all. Please do not contact me again or I will report you to your supervisor.');

/* SQL querys */

/*From this query we can see that in this dataset 113 messages are marked as 'spam' out of 150*/
SELECT COUNT(Message) FROM SpamHam
Where (Target='spam'); 

/*From this query we can identify that a small number of individuals (8 people) are responsible for all the spam being sent*/
SELECT Sender, Target, COUNT(Message) FROM SpamHam
WHERE (Target='spam')
GROUP BY Sender, Target
ORDER BY Sender;

/*From this query we can see that the 'ham' messages are spread out across a larger number of senders*/
SELECT Sender, Target, COUNT(Message) FROM SpamHam
WHERE (Target='ham')
GROUP BY Sender, Target
ORDER BY Sender;

/* From this query we can see that the average number of messages sent by a sender is 5.88*/
SELECT AVG(COUNT(Message)) FROM SpamHam
GROUP BY Sender;

/* From this query we can see that the average number of ham messages sent by a sender is 3.77*/
SELECT AVG(COUNT(Message)) FROM SpamHam
WHERE Target='ham'
GROUP BY Sender;

/* From this query we can see that the average number of spam messages sent by a sender is 14.125*/
SELECT AVG(COUNT(Message)) FROM SpamHam
WHERE Target='spam'
GROUP BY Sender;

/* From this query we can see the count of messages grouped by sender and target for only the people who send spams*/
SELECT Sender, Target, COUNT(Message) FROM SpamHam
WHERE (Sender IN (SELECT Sender FROM SpamHam
    			WHERE (Target='spam')))
GROUP BY Sender, Target
ORDER BY Sender;

/* From this query we can see the count of messages grouped by sender and target for only the people who do not send spams*/
SELECT Sender, Target, COUNT(Message) FROM SpamHam
WHERE (Sender NOT IN (SELECT Sender FROM SpamHam
    			WHERE (Target='spam')))
GROUP BY Sender, Target
ORDER BY Sender;


/* From the queries above we can confirm that
1) Most of the messages are spam
2) A small number of senders are responsible for all this spam
3) The people who send spam messages tend to send more messages on average than the poeple who do not*/

drop table SpamHam;
/*3D*/
/*Creating the table*/
CREATE TABLE SpamHam
(In_Ord NUMBER(5) NOT NULL, 
Target VARCHAR2(20), 
DateSent VARCHAR2(30), 
TimeSent VARCHAR2(20), 
Sender VARCHAR2(20), 
Message VARCHAR2(2000));



/*Only inserting 150 rows for testing the function*/
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (109,'ham','01-01-2009','0:30:14','Rocha','How would my ip address test that considering my computer isn''t a minecraft server');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (92,'ham','01-01-2009','1:30:08','Collins','Sorry to be a pain. Is it ok if we meet another night? I spent late afternoon in casualty and that means i haven''t done any of y stuff42moro and that includes all my time sheets and that. Sorry.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (41,'ham','01-01-2009','6:16:05','Proctor','Pls go ahead with watts. I just wanted to be sure. Do have a great weekend. Abiola');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (9,'spam','01-01-2009','11:28:48','Collins','WINNER!! As a valued network customer you have been selected to receivea £900 prize reward! To claim call 09061701461. Claim code KL341. Valid 12 hours only.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (3,'spam','01-01-2009','3:41:13','Thompson','Free entry in 2 a wkly comp to win FA Cup final tkts 21st May 2005. Text FA to 87121 to receive entry question(std txt rate)T&C''s apply 08452810075over18''s');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (16,'spam','01-01-2009','20:36:55','Jones','XXXMobileMovieClub: To use your credit, click the WAP link in the next txt message or click here>> http://wap. xxxmobilemovieclub.com?n=QJKGIGHJJGCBL');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (66,'spam','01-01-2009','18:39:52','Jones','As a valued customer, I am pleased to advise you that following recent review of your Mob No. you are awarded with a £1500 Bonus Prize, call 09066364589');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (45,'ham','01-01-2009','12:17:59','Carrillo','Great! I hope you like your man well endowed. I am  &lt:#&gt:  inches...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (46,'ham','01-01-2009','13:50:24','Rocha','No calls..messages..missed calls');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (57,'spam','01-01-2009','7:09:56','Adams','Congrats! 1 year special cinema pass for 2 is yours. call 09061209465 now! C Suprman V, Matrix3, StarWars3, etc all 4 FREE! bx420-ip4-5we. 150pm. Dont miss out!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (12,'spam','01-01-2009','14:49:40','Smith','SIX chances to win CASH! From 100 to 20,000 pounds txt> CSH11 and send to 87575. Cost 150p/day, 6days, 16+ TsandCs apply Reply HL 4 info');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (122,'spam','01-01-2009','13:45:41','Thompson','URGENT! Your Mobile No. was awarded £2000 Bonus Caller Prize on 5/9/03 This is our final try to contact U! Call from Landline 09064019788 BOX42WR29C, 150PPM');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (1,'ham','01-01-2009','0:00:00','Santana','Go until jurong point, crazy.. Available only in bugis n great world la e buffet... Cine there got amore wat...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (70,'ham','01-01-2009','1:03:45','Benjamin','I plane to give on this month end.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (120,'ham','01-01-2009','12:10:57','Campbell','Hmm...my uncle just informed me that he''s paying the school directly. So pls buy food.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (95,'ham','01-01-2009','5:26:33','Sosa','Havent planning to buy later. I check already lido only got 530 show in e afternoon. U finish work already?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (59,'ham','01-01-2009','11:11:42','Dalton','Tell where you reached');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (35,'spam','01-01-2009','21:10:42','Ross','Thanks for your subscription to Ringtone UK your mobile will be charged £5/month Please confirm by replying YES or NO. If you reply NO you will not be charged');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (6,'spam','01-01-2009','8:37:40','Adams','FreeMsg Hey there darling it''s been 3 week''s now and no word back! I''d like some fun you up for it still? Tb ok! XxX std chgs to send, £1.50 to rcv');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (55,'spam','01-01-2009','2:46:32','Smith','SMS. ac Sptv: The New Jersey Devils and the Detroit Red Wings play Ice Hockey. Correct or Incorrect? End? Reply END SPTV');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (115,'spam','01-01-2009','5:35:32','Thompson','GENT! We are trying to contact you. Last weekends draw shows that you won a £1000 prize GUARANTEED. Call 09064012160. Claim Code K52. Valid 12hrs only. 150ppm');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (13,'spam','01-01-2009','17:02:31','Smith','URGENT! You have won a 1 week FREE membership in our £100,000 Prize Jackpot! Txt the word: CLAIM to No: 81010 T&C www.dbuk.net LCCLTD POBOX 4403LDNW1A7RW18');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (10,'spam','01-01-2009','11:58:27','Smith','Had your mobile 11 months or more? U R entitled to Update to the latest colour mobiles with camera for Free! Call The Mobile Update Co FREE on 08002986030');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (20,'spam','01-01-2009','3:15:22','Williams','England v Macedonia - dont miss the goals/team news. Txt ur national team to 87077 eg ENGLAND to 87077 Try:WALES, SCOTLAND 4txt/u1.20 POBOXox36504W45WQ 16+');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (121,'spam','01-01-2009','12:29:39','Thompson','PRIVATE! Your 2004 Account Statement for 07742676969 shows 786 unredeemed Bonus Points. To claim call 08719180248 Identifier Code: 45239 Expires');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (36,'ham','01-01-2009','23:13:31','Barker','Yup... Ok i go home look at the timings then i msg u again... Xuhui going to learn on 2nd may too but her lesson is at 8am');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (61,'ham','01-01-2009','13:13:05','Collins','Your gonna have to pick up a $1 burger for yourself on your way home. I can''t even move. Pain is killing me.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (14,'ham','01-01-2009','19:10:26','Benitez','I''ve been searching for the right words to thank you for this breather. I promise i wont take your help for granted and will fulfil my promise. You have been wonderful and a blessing at all times.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (84,'ham','01-01-2009','17:34:05','Jennings','You will be in the place of that man');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (42,'ham','01-01-2009','7:49:22','Rocha','Did I forget to tell you ? I want you , I need you, I crave you ... But most of all ... I love you my sweet Arabian steed ... Mmmmmm ... Yummy');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (91,'ham','01-01-2009','1:15:21','Romero','Yeah do! Don''t stand to close tho- you''ll catch something!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (49,'ham','01-01-2009','17:50:41','Carrillo','Yeah hopefully, if tyler can''t do it I could maybe ask around a bit');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (43,'spam','01-01-2009','8:43:04','Thompson','07732584351 - Rodger Burns - MSG = We tried to call you re your reply to our sms for a free nokia mobile + free camcorder. Please call now 08000930705 for delivery tomorrow');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (118,'spam','01-01-2009','11:09:14','Thompson','You are a winner U have been specially selected 2 receive £1000 or a 4* holiday (flights inc) speak to a live operator 2 claim 0871277810910p/min (18+)');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (69,'spam','01-01-2009','23:03:20','Collins','"Did you hear about the new ""Divorce Barbie""? It comes with all of Ken''s stuff!"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (96,'spam','01-01-2009','5:40:05','Thompson','"Your free ringtone is waiting to be collected. Simply text the password ""MIX"" to 85069 to verify. Get Usher and Britney. FML, PO Box 5249, MK17 92H. 450Ppw 16"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (94,'spam','01-01-2009','3:55:02','Smith','Please call our customer service representative on 0800 169 6031 between 10am-9pm as you have WON a guaranteed £1000 cash or £5000 prize!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (189,'spam','02-01-2009','0:39:30','Smith','Please call our customer service representative on FREEPHONE 0808 145 4742 between 9am-11pm as you have WON a guaranteed £1000 cash or £5000 prize!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (151,'ham','02-01-2009','0:36:25','Odonnell','Sindu got job in birla soft ..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (144,'ham','02-01-2009','15:17:24','Flynn','"A swt thought: ""Nver get tired of doing little things 4 lovable persons.."" Coz..somtimes those little things occupy d biggest part in their Hearts.. Gud ni8"');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (211,'ham','02-01-2009','4:03:53','Gill','Both :) i shoot big loads so get ready!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (136,'spam','02-01-2009','7:10:29','Smith','Want 2 get laid tonight? Want real Dogging locations sent direct 2 ur mob? Join the UK''s largest Dogging Network bt Txting GRAVEL to 69888! Nt. ec2a. 31p.msg@150p');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (166,'spam','02-01-2009','21:26:37','Collins','BangBabes Ur order is on the way. U SHOULD receive a Service Msg 2 download UR content. If U do not, GoTo wap. bangb. tv on UR mobile internet/service menu');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (176,'ham','02-01-2009','7:58:07','Carrillo','Well, i''m gonna finish my bath now. Have a good...fine night.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (174,'ham','02-01-2009','5:55:18','Beltran','What time you coming down later?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (158,'ham','02-01-2009','9:20:06','Whitehead','I''m leaving my house now...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (165,'spam','02-01-2009','20:11:16','Adams','-PLS STOP bootydelious (32/F) is inviting you to be her friend. Reply YES-434 or NO-434 See her: www.SMS.ac/u/bootydelious STOP? Send STOP FRND to 62468');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (192,'spam','02-01-2009','3:56:07','Ross','Are you unique enough? Find out from 30th August. www.areyouunique.co.uk');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (134,'ham','02-01-2009','3:43:49','Kerr','First answer my question.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (141,'ham','02-01-2009','13:21:05','Romero','Got c... I lazy to type... I forgot u in lect... I saw a pouch but like not v nice...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (149,'ham','02-01-2009','20:39:49','Smith','Ummma.will call after check in.our life will begin from qatar so pls pray very hard.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (131,'ham','02-01-2009','22:39:25','Whitehead','K..k:)how much does it cost?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (148,'spam','02-01-2009','18:49:17','Adams','FreeMsg Why haven''t you replied to my text? I''m Randy, sexy, female and live local. Luv to hear from u. Netcollex Ltd 08700621170150p per msg reply Stop to end');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (135,'spam','02-01-2009','5:24:23','King','Sunshine Quiz Wkly Q! Win a top Sony DVD player if u know which country the Algarve is in? Txt ansr to 82277. £1.50 SP:Tyrone');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (178,'ham','02-01-2009','10:22:06','Mcmillan','U still going to the mall?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (175,'ham','02-01-2009','6:56:36','Barker','Bloody hell, cant believe you forgot my surname Mr . Ill give u a clue, its spanish and begins with m...');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (168,'spam','02-01-2009','23:26:32','Smith','URGENT! We are trying to contact you. Last weekends draw shows that you have won a £900 prize GUARANTEED. Call 09061701939. Claim code S89. Valid 12hrs only');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (185,'ham','02-01-2009','19:12:09','Hoffman','He will, you guys close?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (212,'ham','02-01-2009','5:56:04','King','What''s up bruv, hope you had a great break. Do have a rewarding semester.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (160,'spam','02-01-2009','10:36:18','Jones','Customer service annoncement. You have a New Years delivery waiting for you. Please call 07046744435 now to arrange delivery');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (177,'ham','02-01-2009','9:18:17','York','Let me know when you''ve got the money so carlos can make the call');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (183,'ham','02-01-2009','15:49:52','Mcmillan','Lol no. U can trust me.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (187,'ham','02-01-2009','21:49:09','Santana','Hello handsome ! Are you finding that job ? Not being lazy ? Working towards getting back that net for mummy ? Where''s my boytoy now ? Does he miss me ?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (161,'spam','02-01-2009','12:33:02','Smith','You are a winner U have been specially selected 2 receive £1000 cash or a 4* holiday (flights inc) speak to a live operator 2 claim 0871277810810');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (190,'ham','02-01-2009','2:22:12','York','Have you got Xmas radio times. If not i will get it now');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (200,'ham','02-01-2009','13:40:25','Carrillo','Hi its Kate how is your evening? I hope i can see you tomorrow for a bit but i have to bloody babyjontet! Txt back if u can. :) xxx');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (205,'ham','02-01-2009','22:35:55','Smith','Goodmorning sleeping ga.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (140,'spam','02-01-2009','12:49:16','Collins','You''ll not rcv any more msgs from the chat svc. For FREE Hardcore services text GO to: 69988 If u get nothing u must Age Verify with yr network & try again');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (132,'ham','02-01-2009','0:11:23','Adams','I''m home.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (226,'spam','03-01-2009','22:33:17','Adams','500 New Mobiles from 2004, MUST GO! Txt: NOKIA to No: 89545 & collect yours today!From ONLY £1 www.4-tc.biz 2optout 087187262701.50gbp/mtmsg18');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (265,'spam','03-01-2009','20:44:00','Collins','Hey I am really horny want to chat or see me naked text hot to 69698 text charged at 150pm to unsubscribe text stop 69698');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (233,'ham','03-01-2009','5:33:43','Benson','Dear we are going to our rubber place');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (248,'ham','03-01-2009','4:27:24','Wong','I asked you to call him now ok');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (264,'ham','03-01-2009','18:39:24','Santana','MY NO. IN LUTON 0125698789 RING ME IF UR AROUND! H*');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (276,'ham','03-01-2009','13:01:33','Proctor','No objection. My bf not coming.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (260,'spam','03-01-2009','15:39:42','Collins','We tried to contact you re your reply to our offer of a Video Handset? 750 anytime networks mins? UNLIMITED TEXT? Camcorder? Reply or call 08000930705 NOW');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (293,'ham','03-01-2009','10:46:58','Giles','Haf u found him? I feel so stupid da v cam was working.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (289,'ham','03-01-2009','6:00:06','Thompson','hi baby im cruisin with my girl friend what r u up 2? give me a call in and hour at home if thats alright or fone me on this fone now love jenny xxx');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (236,'spam','03-01-2009','8:54:57','Collins','Text & meet someone sexy today. U can find a date or even flirt its up to U. Join 4 just 10p. REPLY with NAME & AGE eg Sam 25. 18 -msg recd@thirtyeight pence');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (249,'ham','03-01-2009','5:09:50','Berry','Kallis wont bat in 2nd innings.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (216,'ham','03-01-2009','11:48:35','Tate','Sounds great! Are you home now?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (229,'ham','03-01-2009','1:19:35','Benson','Hey company elama po mudyadhu.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (310,'spam','03-01-2009','2:57:31','Thompson','TheMob> Check out our newest selection of content, Games, Tones, Gossip, babes and sport, Keep your mobile fit and funky text WAP to 82468');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (261,'ham','03-01-2009','16:20:43','Beltran','I''m parked next to a MINI!!!! When are you coming in today do you think?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (298,'ham','03-01-2009','17:15:46','Collins','Unless it''s a situation where YOU GO GURL would be more appropriate');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (313,'spam','03-01-2009','6:43:32','Adams','Think ur smart ? Win £200 this week in our weekly quiz, text PLAY to 85222 now!T&Cs WinnersClub PO BOX 84, M26 3UZ. 16+. GBP1.50/week');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (295,'ham','03-01-2009','11:47:04','Dalton','Are you this much buzy');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (228,'spam','03-01-2009','23:34:38','King','Will u meet ur dream partner soon? Is ur career off 2 a flyng start? 2 find out free, txt HORO followed by ur star sign, e. g. HORO ARIES');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (235,'ham','03-01-2009','6:51:55','Love','Yes:)here tv is always available in work place..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (286,'ham','03-01-2009','2:57:07','Ballard','Yeah I think my usual guy''s still passed out from last night, if you get ahold of anybody let me know and I''ll throw down');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (320,'spam','03-01-2009','18:28:10','Williams','December only! Had your mobile 11mths+? You are entitled to update to the latest colour camera mobile for Free! Call The Mobile Update Co FREE on 08002986906');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (241,'spam','03-01-2009','17:09:45','Thompson','U 447801259231 have a secret admirer who is looking 2 make contact with U-find out who they R*reveal who thinks UR so special-call on 09058094597');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (303,'ham','03-01-2009','21:35:00','Lawson','Shit that is really shocking and scary, cant imagine for a second. Def up for night out. Do u think there is somewhere i could crash for night, save on taxi?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (278,'ham','03-01-2009','16:56:00','York','Tell rob to mack his gf in the theater');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (222,'ham','03-01-2009','17:21:41','King','Ok no prob. Take ur time.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (271,'spam','03-01-2009','7:28:21','Ross','Ringtone Club: Get the UK singles chart on your mobile each week and choose any top quality ringtone! This message is free of charge.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (238,'ham','03-01-2009','12:15:42','Thompson','Or ill be a little closer like at the bus stop on the same street');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (280,'ham','03-01-2009','18:31:29','Giles','Just sent it. So what type of food do you like?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (274,'spam','03-01-2009','10:55:17','Ross','HMV BONUS SPECIAL 500 pounds of genuine HMV vouchers to be won. Just answer 4 easy questions. Play Now! Send HMV to 86688 More info:www.100percent-real.com');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (251,'spam','03-01-2009','6:18:04','Ross','Congratulations ur awarded 500 of CD vouchers or 125gift guaranteed & Free entry 2 100 wkly draw txt MUSIC to 87066 TnCs www.Ldew.com1win150ppmx3age16');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (283,'ham','03-01-2009','22:38:48','King','Wen u miss someone, the person is definitely special for u..... But if the person is so special, why to miss them, just Keep-in-touch gdeve..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (224,'ham','03-01-2009','20:10:58','Rich','Sorry, I''ll call later');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (297,'spam','03-01-2009','15:17:25','Jones','T-Mobile customer you may now claim your FREE CAMERA PHONE upgrade & a pay & go sim card for your loyalty. Call on 0845 021 3680.Offer ends 28thFeb.T&C''s apply');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (263,'ham','03-01-2009','18:24:56','Clayton','Anyway i''m going shopping on my own now. Cos my sis not done yet. Dun disturb u liao.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (308,'ham','03-01-2009','0:35:44','Brooks','Jos ask if u wana meet up?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (306,'spam','03-01-2009','23:19:13','King','SMS. ac Blind Date 4U!: Rodds1 is 21/m from Aberdeen, United Kingdom. Check Him out http://img. sms. ac/W/icmb3cktz8r7!-4 no Blind Dates send HIDE');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (324,'ham','03-01-2009','0:52:22','King','cud u tell ppl im gona b a bit l8 cos 2 buses hav gon past cos they were full & im still waitin 4 1. Pete x');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (304,'ham','03-01-2009','21:54:14','Perry','Oh and by the way you do have more food in your fridge! Want to go out for a meal tonight?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (270,'ham','03-01-2009','6:07:33','Ballard','The evo. I just had to download flash. Jealous?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (269,'spam','03-01-2009','4:48:39','Williams','Ur ringtone service has changed! 25 Free credits! Go to club4mobiles.com to choose content now! Stop? txt CLUB STOP to 87070. 150p/wk Club4 PO Box1146 MK45 2WT');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (328,'ham','03-01-2009','5:30:47','King','Hi da:)how is the todays class?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (301,'ham','03-01-2009','18:46:45','King','Need a coffee run tomo?Can''t believe it''s that time of week already');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (290,'ham','03-01-2009','7:11:09','Clayton','My life Means a lot to me, Not because I love my life, But because I love the people in my life, The world calls them friends, I call them my World:-).. Ge:-)..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (355,'ham','04-01-2009','15:18:36','Mccarty','Yo you guys ever figure out how much we need for alcohol? Jay and I are trying to figure out how much we can safely spend on weed');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (359,'spam','04-01-2009','22:35:09','Ross','Ur cash-balance is currently 500 pounds - to maximize ur cash-in now send CASH to 86688 only 150p/msg. CC: 08708800282 HG/Suite342/2Lands Row/W1J6HL');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (395,'ham','04-01-2009','16:03:08','King','Yes i think so. I am in office but my lap is in room i think thats on for the last few days. I didnt shut that down');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (349,'ham','04-01-2009','7:08:39','Brooks','One small prestige problem now.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (363,'ham','04-01-2009','3:32:34','Adams','Oh ok no prob..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (369,'spam','04-01-2009','13:48:35','Collins','Here is your discount code RP176781. To stop further messages reply stop. www.regalportfolio.co.uk. Customer Services 08717205546');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (350,'spam','04-01-2009','8:26:50','Adams','Fancy a shag? I do.Interested? sextextuk.com txt XXUK SUZY to 69876. Txts cost 1.50 per msg. TnCs on website. X');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (380,'ham','04-01-2009','23:18:08','Whitehead','Keep my payasam there if rinu brings');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (376,'spam','04-01-2009','21:26:11','Williams','Thanks for your Ringtone Order, Reference T91. You will be charged GBP 4 per week. You can unsubscribe at anytime by calling customer services on 09057039994');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (353,'ham','04-01-2009','11:22:10','Benson','If you''re not in my car in an hour and a half I''m going apeshit');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (358,'spam','04-01-2009','20:48:48','Collins','Congratulations ur awarded 500 of CD vouchers or 125gift guaranteed & Free entry 2 100 wkly draw txt MUSIC to 87066 TnCs www.Ldew.com1win150ppmx3age16');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (397,'ham','04-01-2009','17:13:48','Smith','From here after The performance award is calculated every two month.not for current one month period..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (381,'ham','04-01-2009','23:42:15','Sosa','I taught that Ranjith sir called me. So only i sms like that. Becaus hes verifying about project. Prabu told today so only pa dont mistake me..');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (396,'ham','04-01-2009','16:27:34','Rosario','Pick you up bout 7.30ish? What time are  and that going?');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (400,'ham','04-01-2009','19:56:46','Rocha','Good evening Sir, Al Salam Wahleykkum.sharing a happy news.By the grace of God, i got an offer from Tayseer,TISSCO and i joined.Hope you are fine.Inshah Allah,meet you sometime.Rakhesh,visitor from India.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (357,'ham','04-01-2009','18:30:51','Smith','Thank You for calling.Forgot to say Happy Onam to you Sirji.I am fine here and remembered you when i met an insurance person.Meet You in Qatar Insha Allah.Rakhesh, ex Tata AIG who joined TISSCO,Tayseer.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (386,'spam','04-01-2009','4:58:59','Jones','Double mins and txts 4 6months FREE Bluetooth on Orange. Available on Sony, Nokia Motorola phones. Call MobileUpd8 on 08000839402 or call2optout/N9DX');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (331,'ham','04-01-2009','9:24:05','Lee','I''m reading the text i just sent you. Its meant to be a joke. So read it in that light');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (405,'ham','04-01-2009','0:10:36','Ayala','None of that''s happening til you get here though');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (371,'ham','04-01-2009','16:43:19','Mccarty','Cool, text me when you''re ready');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (343,'ham','04-01-2009','0:15:01','Rosario','I take it the post has come then! You must have 1000s of texts now! Happy reading. My one from wiv hello caroline at the end is my favourite. Bless him');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (383,'ham','04-01-2009','3:15:03','Flores','Yeah sure, give me a couple minutes to track down my wallet');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (362,'ham','04-01-2009','3:24:04','Hayden','Ha ha cool cool chikku chikku:-):-DB-)');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (394,'ham','04-01-2009','15:59:19','Williams','Morning only i can ok.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (336,'spam','04-01-2009','13:23:42','Thompson','Valentines Day Special! Win over £1000 in our quiz and take your partner on the trip of a lifetime! Send GO to 83600 now. 150p/msg rcvd. CustCare:08718720201.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (377,'ham','04-01-2009','22:05:03','Benson','Can you say what happen');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (390,'spam','04-01-2009','9:56:26','King','4mths half price Orange line rental & latest camera phones 4 FREE. Had your phone 11mths ? Call MobilesDirect free on 08000938767 to update now! or2stoptxt');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (384,'ham','04-01-2009','4:19:31','Garrison','Hey leave it. not a big deal:-) take care.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (334,'spam','04-01-2009','12:43:51','Smith','Call Germany for only 1 pence per minute! Call from a fixed line via access number 0844 861 85 85. No prepayment. Direct access!');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (385,'ham','04-01-2009','4:29:14','Williams','Hey i will be late ah... Meet you at 945+');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (402,'spam','04-01-2009','20:40:31','Ross','FREE RINGTONE text FIRST to 87131 for a poly or text GET to 87131 for a true tone! Help? 0845 2814032 16 after 1st free, tones are 3x£150pw to e£nd txt stop');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (352,'ham','04-01-2009','10:01:53','Maynard','Nah can''t help you there, I''ve never had an iphone');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (348,'ham','04-01-2009','5:45:08','King','Dis is yijue. I jus saw ur mail. In case huiming havent sent u my num. Dis is my num.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (368,'spam','04-01-2009','12:13:19','Collins','Update_Now - Xmas Offer! Latest Motorola, SonyEricsson & Nokia & FREE Bluetooth! Double Mins & 1000 Txt on Orange. Call MobileUpd8 on 08000839402 or call2optout/F4Q=');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (382,'ham','04-01-2009','1:33:46','York','I guess that''s why you re worried. You must know that there''s a way the body repairs itself. And i''m quite sure you shouldn''t worry. We''ll take it slow.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (398,'ham','04-01-2009','17:26:56','Hayden','Was actually sleeping and still might when u call back. So a text is gr8. You rock sis. Will send u a text wen i wake.');
INSERT INTO SpamHam(In_Ord,Target,DateSent,TimeSent,Sender,Message) VALUES (335,'ham','04-01-2009','13:15:14','Robertson','Any chance you might have had with me evaporated as soon as you violated my privacy by stealing my phone number from your employer''s paperwork. Not cool at all. Please do not contact me again or I will report you to your supervisor.');

/*Create table for stop words*/
CREATE TABLE stopwords(
   stop_word VARCHAR(10) NOT NULL PRIMARY KEY
);

/*Inserting rows into the table stop words*/
INSERT INTO stopwords(stop_word) VALUES ('a');
INSERT INTO stopwords(stop_word) VALUES ('all');
INSERT INTO stopwords(stop_word) VALUES ('also');
INSERT INTO stopwords(stop_word) VALUES ('am');
INSERT INTO stopwords(stop_word) VALUES ('an');
INSERT INTO stopwords(stop_word) VALUES ('and');
INSERT INTO stopwords(stop_word) VALUES ('any');
INSERT INTO stopwords(stop_word) VALUES ('are');
INSERT INTO stopwords(stop_word) VALUES ('as');
INSERT INTO stopwords(stop_word) VALUES ('at');
INSERT INTO stopwords(stop_word) VALUES ('be');
INSERT INTO stopwords(stop_word) VALUES ('because');
INSERT INTO stopwords(stop_word) VALUES ('but');
INSERT INTO stopwords(stop_word) VALUES ('by');
INSERT INTO stopwords(stop_word) VALUES ('can');
INSERT INTO stopwords(stop_word) VALUES ('cannot');
INSERT INTO stopwords(stop_word) VALUES ('could');
INSERT INTO stopwords(stop_word) VALUES ('did');
INSERT INTO stopwords(stop_word) VALUES ('do');
INSERT INTO stopwords(stop_word) VALUES ('does');
INSERT INTO stopwords(stop_word) VALUES ('else');
INSERT INTO stopwords(stop_word) VALUES ('ever');
INSERT INTO stopwords(stop_word) VALUES ('every');
INSERT INTO stopwords(stop_word) VALUES ('for');
INSERT INTO stopwords(stop_word) VALUES ('from');
INSERT INTO stopwords(stop_word) VALUES ('get');
INSERT INTO stopwords(stop_word) VALUES ('got');
INSERT INTO stopwords(stop_word) VALUES ('had');
INSERT INTO stopwords(stop_word) VALUES ('has');
INSERT INTO stopwords(stop_word) VALUES ('have');
INSERT INTO stopwords(stop_word) VALUES ('he');
INSERT INTO stopwords(stop_word) VALUES ('her');
INSERT INTO stopwords(stop_word) VALUES ('him');
INSERT INTO stopwords(stop_word) VALUES ('his');
INSERT INTO stopwords(stop_word) VALUES ('how');
INSERT INTO stopwords(stop_word) VALUES ('i');
INSERT INTO stopwords(stop_word) VALUES ('if');
INSERT INTO stopwords(stop_word) VALUES ('in');
INSERT INTO stopwords(stop_word) VALUES ('into');
INSERT INTO stopwords(stop_word) VALUES ('is');
INSERT INTO stopwords(stop_word) VALUES ('it');
INSERT INTO stopwords(stop_word) VALUES ('let');
INSERT INTO stopwords(stop_word) VALUES ('like');
INSERT INTO stopwords(stop_word) VALUES ('may');
INSERT INTO stopwords(stop_word) VALUES ('me');
INSERT INTO stopwords(stop_word) VALUES ('my');
INSERT INTO stopwords(stop_word) VALUES ('no');
INSERT INTO stopwords(stop_word) VALUES ('of');
INSERT INTO stopwords(stop_word) VALUES ('on');
INSERT INTO stopwords(stop_word) VALUES ('only');
INSERT INTO stopwords(stop_word) VALUES ('or');
INSERT INTO stopwords(stop_word) VALUES ('our');
INSERT INTO stopwords(stop_word) VALUES ('own');
INSERT INTO stopwords(stop_word) VALUES ('she');
INSERT INTO stopwords(stop_word) VALUES ('should');
INSERT INTO stopwords(stop_word) VALUES ('so');
INSERT INTO stopwords(stop_word) VALUES ('some');
INSERT INTO stopwords(stop_word) VALUES ('than');
INSERT INTO stopwords(stop_word) VALUES ('that');
INSERT INTO stopwords(stop_word) VALUES ('the');
INSERT INTO stopwords(stop_word) VALUES ('then');
INSERT INTO stopwords(stop_word) VALUES ('there');
INSERT INTO stopwords(stop_word) VALUES ('these');
INSERT INTO stopwords(stop_word) VALUES ('they');
INSERT INTO stopwords(stop_word) VALUES ('this');
INSERT INTO stopwords(stop_word) VALUES ('to');
INSERT INTO stopwords(stop_word) VALUES ('too');
INSERT INTO stopwords(stop_word) VALUES ('us');
INSERT INTO stopwords(stop_word) VALUES ('was');
INSERT INTO stopwords(stop_word) VALUES ('we');
INSERT INTO stopwords(stop_word) VALUES ('were');
INSERT INTO stopwords(stop_word) VALUES ('what');
INSERT INTO stopwords(stop_word) VALUES ('when');
INSERT INTO stopwords(stop_word) VALUES ('where');
INSERT INTO stopwords(stop_word) VALUES ('which');
INSERT INTO stopwords(stop_word) VALUES ('while');
INSERT INTO stopwords(stop_word) VALUES ('who');
INSERT INTO stopwords(stop_word) VALUES ('why');
INSERT INTO stopwords(stop_word) VALUES ('will');
INSERT INTO stopwords(stop_word) VALUES ('with');
INSERT INTO stopwords(stop_word) VALUES ('would');
INSERT INTO stopwords(stop_word) VALUES ('yet');
INSERT INTO stopwords(stop_word) VALUES ('you');
INSERT INTO stopwords(stop_word) VALUES ('your');

/*Counts most frequently occurring words in the Messages column in the spam collection*/
select 
/*Uses a regular expression to tokenise words selecting every character that is not in the square brackets then selects 2 columns one for displaying the word itself the other for counting its occurences*/
   trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))  MESSAGES, Count(trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))) as COUNTS
   --NB.: In this scenario numbers are also counted as words  
from  
  SpamHam,
  /*Erases everything that is not a delimiter to count how many elements are there then uses a hierarchical query to create a column with an increasing number of matches found.
  This is then cast onto a single collection of numbers and finally into a collection of a resultset*/
  table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(lower(SpamHam.Message), '[^ .,?!-&£$]+'))  + 1) as sys.OdciNumberList)) levels 
/*Selects only the tokens/words not in the stopwords table and only in the spam collection*/
where  trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value)) NOT IN (SELECT stop_word FROM stopwords)
    and (SpamHam.Target = 'spam')
/*Groups by the tokenised words so that they can be counted*/
group by trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))
order by COUNTS desc --descending order of frequency
fetch first 10 rows only -- displaying only the top 10 results

/*Counts most frequently occurring words in the Messages column in the ham collection*/
select 
/*Uses a regular expression to tokenise words selecting every character that is not in the square brackets then selects 2 columns one for displaying the word itself the other for counting its occurences*/
   trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))  MESSAGES, Count(trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))) as COUNTS
   --NB.: In this scenario numbers are also counted as words  
from  
  SpamHam,
  /*Erases everything that is not a delimiter to count how many elements are there then uses a hierarchical query to create a column with an increasing number of matches found.
  This is then cast onto a single collection of numbers and finally into a collection of a resultset*/
  table(cast(multiset(select level from dual connect by  level <= length (regexp_replace(lower(SpamHam.Message), '[^ .,?!-&£$]+'))  + 1) as sys.OdciNumberList)) levels 
/*Selects only the tokens/words not in the stopwords table and only in the ham collection*/
where  trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value)) NOT IN (SELECT stop_word FROM stopwords)
    and (SpamHam.Target = 'ham')
/*Groups by the tokenised words so that they can be counted*/
group by trim(regexp_substr(lower(Spamham.Message), '[^ .,?!-&£$]+', 1, levels.column_value))
order by COUNTS desc --descending order of frequency
fetch first 10 rows only -- displaying only the top 10 results

drop table stopwords;
drop table SpamHam;