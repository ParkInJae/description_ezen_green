drop database ezengreen;
create database ezengreen;
use ezengreen;

CREATE TABLE user
(
	uno int PRIMARY KEY NOT NULL AUTO_INCREMENT comment '회원번호',
	uid varchar(100) comment '아이디',
	upw varchar(100) comment '비밀번호',
	uname varchar(100) comment '이름',
	uemail varchar(100) comment '이메일',
	ujoindate datetime DEFAULT now() comment '가입일자',
	admin boolean DEFAULT 0 NOT NULL comment '관리자확인'
);

CREATE TABLE board
(
	bno int PRIMARY KEY NOT NULL AUTO_INCREMENT comment '게시물번호',
	uno int NOT NULL comment '회원번호',
	btitle varchar(100) comment '제목',
	bkind varchar(4) comment '구분',
	bcontent text comment '내용',
	bwdate datetime DEFAULT now() comment '작성일자',
	bhit int default 0 comment '조회수',
	foreign key (uno) references user(uno)
);


CREATE TABLE file
(
	fno int PRIMARY KEY NOT NULL AUTO_INCREMENT comment '첨부번호' ,
	bno int NOT NULL comment '게시물번호',
	pname varchar(255) comment '물리파일명',
	fname varchar(255) comment '논리파일명',
	foreign key (bno) references board(bno)
);


CREATE TABLE reply
(
	rno int PRIMARY KEY NOT NULL AUTO_INCREMENT comment '댓글번호',
	bno int NOT NULL comment '게시물번호',
	uno int comment '작성회원번호',
	rcontent text comment '댓글내용',
	rwdate datetime DEFAULT now() comment  '작성일자',
	foreign key (bno) references board(bno),
	foreign key (uno) references user(uno)
	
);
