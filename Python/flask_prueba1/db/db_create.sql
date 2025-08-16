create database if not exists users_flask;
use users_flask;

create table if not exists user(
    id int not null auto_increment,
    username varchar(50) not null,
    password varchar(200) not null,
    primary key(id),
    unique key uk_username(username)
);