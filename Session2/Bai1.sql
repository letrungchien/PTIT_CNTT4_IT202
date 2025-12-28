create database db_session2;
use db_session2;



CREATE TABLE lop (
    MaLop INT PRIMARY KEY,
    TenLop VARCHAR(50),
    NamHoc INT
);

CREATE TABLE sinh_vien (
    MaSv INT PRIMARY KEY,
    TenSv VARCHAR(50),  
    NgaySinh DATE,
    MaLop INT,
    FOREIGN KEY (MaLop) REFERENCES lop(MaLop)
);
