/*==============================================================*/
/* DBMS name:      Microsoft SQL Server 2008                    */
/* Created on:     10/28/2024 7:19:31 PM                        */
/*==============================================================*/


use master;
DROP DATABASE IF EXISTS iLovePets;
create database iLovePets;
go

use iLovePets;
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BOOKING') and o.name = 'FK_BOOKING_PETBOOKSA_PET')
alter table BOOKING
   drop constraint FK_BOOKING_PETBOOKSA_PET
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BOOKING') and o.name = 'FK_BOOKING_SLOTBOOKE_SESSION')
alter table BOOKING
   drop constraint FK_BOOKING_SLOTBOOKE_SESSION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('BREED') and o.name = 'FK_BREED_BREEDSPEC_SPECIES')
alter table BREED
   drop constraint FK_BREED_BREEDSPEC_SPECIES
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MESSAGES') and o.name = 'FK_MESSAGES_RECIEVER_USER')
alter table MESSAGES
   drop constraint FK_MESSAGES_RECIEVER_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('MESSAGES') and o.name = 'FK_MESSAGES_SENDER_USER')
alter table MESSAGES
   drop constraint FK_MESSAGES_SENDER_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PET') and o.name = 'FK_PET_PETBREED_BREED')
alter table PET
   drop constraint FK_PET_PETBREED_BREED
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PET') and o.name = 'FK_PET_PETOWNERS_USER')
alter table PET
   drop constraint FK_PET_PETOWNERS_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PREFERREDBREEDS') and o.name = 'FK_PREFERRE_PREFERRED_BREED')
alter table PREFERREDBREEDS
   drop constraint FK_PREFERRE_PREFERRED_BREED
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('PREFERREDBREEDS') and o.name = 'FK_PREFERRE_PREFERRED_USER')
alter table PREFERREDBREEDS
   drop constraint FK_PREFERRE_PREFERRED_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SESSION') and o.name = 'FK_SESSION_RECURRENT_SLOTSREC')
alter table SESSION
   drop constraint FK_SESSION_RECURRENT_SLOTSREC
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SITTEREXPERTISE') and o.name = 'FK_SITTEREX_SITTEREXP_AREASOFE')
alter table SITTEREXPERTISE
   drop constraint FK_SITTEREX_SITTEREXP_AREASOFE
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SITTEREXPERTISE') and o.name = 'FK_SITTEREX_SITTEREXP_USER')
alter table SITTEREXPERTISE
   drop constraint FK_SITTEREX_SITTEREXP_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SLOTSRECURRENCECONFIGURATION') and o.name = 'FK_SLOTSREC_SERVICERE_USER')
alter table SLOTSRECURRENCECONFIGURATION
   drop constraint FK_SLOTSREC_SERVICERE_USER
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SLOTTARGETBREEDS') and o.name = 'FK_SLOTTARG_SLOTTARGE_BREED')
alter table SLOTTARGETBREEDS
   drop constraint FK_SLOTTARG_SLOTTARGE_BREED
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('SLOTTARGETBREEDS') and o.name = 'FK_SLOTTARG_SLOTTARGE_SESSION')
alter table SLOTTARGETBREEDS
   drop constraint FK_SLOTTARG_SLOTTARGE_SESSION
go

if exists (select 1
   from sys.sysreferences r join sys.sysobjects o on (o.id = r.constid and o.type = 'F')
   where r.fkeyid = object_id('VACINATIONCERTIFICATES') and o.name = 'FK_VACINATI_PETVACCIN_PET')
alter table VACINATIONCERTIFICATES
   drop constraint FK_VACINATI_PETVACCIN_PET
go

if exists (select 1
            from  sysobjects
           where  id = object_id('AREASOFEXPERTISE')
            and   type = 'U')
   drop table AREASOFEXPERTISE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BOOKING')
            and   name  = 'PETBOOKSASLOT_FK'
            and   indid > 0
            and   indid < 255)
   drop index BOOKING.PETBOOKSASLOT_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BOOKING')
            and   name  = 'SLOTBOOKEDBYAPET_FK'
            and   indid > 0
            and   indid < 255)
   drop index BOOKING.SLOTBOOKEDBYAPET_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BOOKING')
            and   type = 'U')
   drop table BOOKING
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('BREED')
            and   name  = 'BREEDSPECIES_FK'
            and   indid > 0
            and   indid < 255)
   drop index BREED.BREEDSPECIES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('BREED')
            and   type = 'U')
   drop table BREED
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MESSAGES')
            and   name  = 'RECIEVER_FK'
            and   indid > 0
            and   indid < 255)
   drop index MESSAGES.RECIEVER_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('MESSAGES')
            and   name  = 'SENDER_FK'
            and   indid > 0
            and   indid < 255)
   drop index MESSAGES.SENDER_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('MESSAGES')
            and   type = 'U')
   drop table MESSAGES
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PET')
            and   name  = 'PETOWNERSHIP_FK'
            and   indid > 0
            and   indid < 255)
   drop index PET.PETOWNERSHIP_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PET')
            and   name  = 'PETBREED_FK'
            and   indid > 0
            and   indid < 255)
   drop index PET.PETBREED_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PET')
            and   type = 'U')
   drop table PET
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PREFERREDBREEDS')
            and   name  = 'PREFERREDBREEDS_FK'
            and   indid > 0
            and   indid < 255)
   drop index PREFERREDBREEDS.PREFERREDBREEDS_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('PREFERREDBREEDS')
            and   name  = 'PREFERREDBREEDS2_FK'
            and   indid > 0
            and   indid < 255)
   drop index PREFERREDBREEDS.PREFERREDBREEDS2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('PREFERREDBREEDS')
            and   type = 'U')
   drop table PREFERREDBREEDS
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SESSION')
            and   name  = 'RECURRENTSLOT_FK'
            and   indid > 0
            and   indid < 255)
   drop index SESSION.RECURRENTSLOT_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SESSION')
            and   type = 'U')
   drop table SESSION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SITTEREXPERTISE')
            and   name  = 'SITTEREXPERTISE_FK'
            and   indid > 0
            and   indid < 255)
   drop index SITTEREXPERTISE.SITTEREXPERTISE_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SITTEREXPERTISE')
            and   name  = 'SITTEREXPERTISE2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SITTEREXPERTISE.SITTEREXPERTISE2_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SITTEREXPERTISE')
            and   type = 'U')
   drop table SITTEREXPERTISE
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SLOTSRECURRENCECONFIGURATION')
            and   name  = 'SERVICERECURRENCE_FK'
            and   indid > 0
            and   indid < 255)
   drop index SLOTSRECURRENCECONFIGURATION.SERVICERECURRENCE_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SLOTSRECURRENCECONFIGURATION')
            and   type = 'U')
   drop table SLOTSRECURRENCECONFIGURATION
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SLOTTARGETBREEDS')
            and   name  = 'SLOTTARGETBREEDS2_FK'
            and   indid > 0
            and   indid < 255)
   drop index SLOTTARGETBREEDS.SLOTTARGETBREEDS2_FK
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('SLOTTARGETBREEDS')
            and   name  = 'SLOTTARGETBREEDS_FK'
            and   indid > 0
            and   indid < 255)
   drop index SLOTTARGETBREEDS.SLOTTARGETBREEDS_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SLOTTARGETBREEDS')
            and   type = 'U')
   drop table SLOTTARGETBREEDS
go

if exists (select 1
            from  sysobjects
           where  id = object_id('SPECIES')
            and   type = 'U')
   drop table SPECIES
go

if exists (select 1
            from  sysobjects
           where  id = object_id('"USER"')
            and   type = 'U')
   drop table "USER"
go

if exists (select 1
            from  sysindexes
           where  id    = object_id('VACINATIONCERTIFICATES')
            and   name  = 'PETVACCINES_FK'
            and   indid > 0
            and   indid < 255)
   drop index VACINATIONCERTIFICATES.PETVACCINES_FK
go

if exists (select 1
            from  sysobjects
           where  id = object_id('VACINATIONCERTIFICATES')
            and   type = 'U')
   drop table VACINATIONCERTIFICATES
go

/*==============================================================*/
/* Table: AREASOFEXPERTISE                                      */
/*==============================================================*/
create table AREASOFEXPERTISE (
   AREA_ID              numeric              identity,
   AREA_NAME            varchar(32)          not null
      constraint CKC_AREA_NAME_AREASOFE check (AREA_NAME in ('Animal behavior','Basic animal first aid','Pet fitness')),
   constraint PK_AREASOFEXPERTISE primary key nonclustered (AREA_ID)
)
go

/*==============================================================*/
/* Table: BOOKING                                               */
/*==============================================================*/
create table BOOKING (
   SESSION_ID           numeric              not null,
   PET_ID               numeric              not null,
   PET_REVIEW           varchar(max)         null,
   PET_RATING           smallint             null
      constraint CKC_PET_RATING_BOOKING check (PET_RATING is null or (PET_RATING between 1 and 5)),
   SITTER_REVIEW        varchar(max)         null,
   SITTER_RATING        smallint             null
      constraint CKC_SITTER_RATING_BOOKING check (SITTER_RATING is null or (SITTER_RATING between 1 and 5)),
   constraint PK_BOOKING primary key (SESSION_ID, PET_ID)
)
go

/*==============================================================*/
/* Index: SLOTBOOKEDBYAPET_FK                                   */
/*==============================================================*/
create index SLOTBOOKEDBYAPET_FK on BOOKING (
SESSION_ID ASC
)
go

/*==============================================================*/
/* Index: PETBOOKSASLOT_FK                                      */
/*==============================================================*/
create index PETBOOKSASLOT_FK on BOOKING (
PET_ID ASC
)
go

/*==============================================================*/
/* Table: BREED                                                 */
/*==============================================================*/
create table BREED (
   BREED_ID             numeric              identity,
   SPECIES_ID           numeric              not null,
   BREED_NAME           varchar(64)          not null,
   constraint PK_BREED primary key nonclustered (BREED_ID)
)
go

/*==============================================================*/
/* Index: BREEDSPECIES_FK                                       */
/*==============================================================*/
create index BREEDSPECIES_FK on BREED (
SPECIES_ID ASC
)
go

/*==============================================================*/
/* Table: MESSAGES                                              */
/*==============================================================*/
create table MESSAGES (
   MESSAGE_ID           numeric              identity,
   SENDER_ID            numeric              not null,
   RECEIVER_ID          numeric              not null,
   BODY                 varchar(max)         not null,
   SUBJECT              varchar(64)          null,
   TIME                 datetime             not null,
   constraint PK_MESSAGES primary key nonclustered (MESSAGE_ID)
)
go

/*==============================================================*/
/* Index: SENDER_FK                                             */
/*==============================================================*/
create index SENDER_FK on MESSAGES (
SENDER_ID ASC
)
go

/*==============================================================*/
/* Index: RECIEVER_FK                                           */
/*==============================================================*/
create index RECIEVER_FK on MESSAGES (
RECEIVER_ID ASC
)
go

/*==============================================================*/
/* Table: PET                                                   */
/*==============================================================*/
create table PET (
   PET_ID               numeric              identity,
   USER_ID              numeric              not null,
   BREED_ID             numeric              not null,
   NAME                 varchar(32)          null,
   YEAR_OF_BIRTH        smallint             null,
   TEMPERAMENT          varchar(32)          not null
      constraint CKC_TEMPERAMENT_PET check (TEMPERAMENT in ('Aggressive','Anxious','Calm','Friendly','Independent','Playful')),
   COMMENTS             varchar(max)         null,
   constraint PK_PET primary key nonclustered (PET_ID)
)
go

/*==============================================================*/
/* Index: PETBREED_FK                                           */
/*==============================================================*/
create index PETBREED_FK on PET (
BREED_ID ASC
)
go

/*==============================================================*/
/* Index: PETOWNERSHIP_FK                                       */
/*==============================================================*/
create index PETOWNERSHIP_FK on PET (
USER_ID ASC
)
go

/*==============================================================*/
/* Table: PREFERREDBREEDS                                       */
/*==============================================================*/
create table PREFERREDBREEDS (
   USER_ID              numeric              not null,
   BREED_ID             numeric              not null,
   constraint PK_PREFERREDBREEDS primary key (USER_ID, BREED_ID)
)
go

/*==============================================================*/
/* Index: PREFERREDBREEDS2_FK                                   */
/*==============================================================*/
create index PREFERREDBREEDS2_FK on PREFERREDBREEDS (
USER_ID ASC
)
go

/*==============================================================*/
/* Index: PREFERREDBREEDS_FK                                    */
/*==============================================================*/
create index PREFERREDBREEDS_FK on PREFERREDBREEDS (
BREED_ID ASC
)
go

/*==============================================================*/
/* Table: SESSION                                               */
/*==============================================================*/
create table SESSION (
   SESSION_ID           numeric              identity,
   RECURRENCE_ID        numeric              not null,
   SESSION_START        datetime             not null,
   SESSION_END          datetime             not null,
   SESSION_MAX_ATTENDANCE smallint             null,
   LAT                  float                null,
   LONG                 float                null,
   constraint PK_SESSION primary key nonclustered (SESSION_ID)
)
go

/*==============================================================*/
/* Index: RECURRENTSLOT_FK                                      */
/*==============================================================*/
create index RECURRENTSLOT_FK on SESSION (
RECURRENCE_ID ASC
)
go

/*==============================================================*/
/* Table: SITTEREXPERTISE                                       */
/*==============================================================*/
create table SITTEREXPERTISE (
   USER_ID              numeric              not null,
   AREA_ID              numeric              not null,
   constraint PK_SITTEREXPERTISE primary key (USER_ID, AREA_ID)
)
go

/*==============================================================*/
/* Index: SITTEREXPERTISE2_FK                                   */
/*==============================================================*/
create index SITTEREXPERTISE2_FK on SITTEREXPERTISE (
USER_ID ASC
)
go

/*==============================================================*/
/* Index: SITTEREXPERTISE_FK                                    */
/*==============================================================*/
create index SITTEREXPERTISE_FK on SITTEREXPERTISE (
AREA_ID ASC
)
go

/*==============================================================*/
/* Table: SLOTSRECURRENCECONFIGURATION                          */
/*==============================================================*/
create table SLOTSRECURRENCECONFIGURATION (
   RECURRENCE_ID        numeric              identity,
   USER_ID              numeric              not null,
   RECURRENCE_END_DATE  datetime             null,
   RECURRENCE           varchar(16)          null
      constraint CKC_RECURRENCE_SLOTSREC check (RECURRENCE is null or (RECURRENCE in ('daily','weekly','monthly','not recurrent'))),
   SESSION_END          datetime             not null,
   SESSION_START        datetime             not null,
   LAT                  float                null,
   LONG                 float                null,
   constraint PK_SLOTSRECURRENCECONFIGURATIO primary key nonclustered (RECURRENCE_ID)
)
go

/*==============================================================*/
/* Index: SERVICERECURRENCE_FK                                  */
/*==============================================================*/
create index SERVICERECURRENCE_FK on SLOTSRECURRENCECONFIGURATION (
USER_ID ASC
)
go

/*==============================================================*/
/* Table: SLOTTARGETBREEDS                                      */
/*==============================================================*/
create table SLOTTARGETBREEDS (
   BREED_ID             numeric              not null,
   SESSION_ID           numeric              not null,
   constraint PK_SLOTTARGETBREEDS primary key (BREED_ID, SESSION_ID)
)
go

/*==============================================================*/
/* Index: SLOTTARGETBREEDS_FK                                   */
/*==============================================================*/
create index SLOTTARGETBREEDS_FK on SLOTTARGETBREEDS (
BREED_ID ASC
)
go

/*==============================================================*/
/* Index: SLOTTARGETBREEDS2_FK                                  */
/*==============================================================*/
create index SLOTTARGETBREEDS2_FK on SLOTTARGETBREEDS (
SESSION_ID ASC
)
go

/*==============================================================*/
/* Table: SPECIES                                               */
/*==============================================================*/
create table SPECIES (
   SPECIES_ID           numeric              identity,
   NAME                 varchar(32)          not null,
   constraint PK_SPECIES primary key nonclustered (SPECIES_ID)
)
go

/*==============================================================*/
/* Table: "USER"                                                */
/*==============================================================*/
create table "USER" (
   USER_ID              numeric              identity,
   FIRST_NAME           varchar(128)         not null,
   LAST_NAME            varchar(128)         not null,
   E_MAIL               varchar(128)         not null,
   IS_PET_SITTER        bit                  not null,
   HOURLY_RATE          float                null,
   MAX_ATTENDANCE       smallint             null,
   constraint PK_USER primary key nonclustered (USER_ID)
)
go

/*==============================================================*/
/* Table: VACINATIONCERTIFICATES                                */
/*==============================================================*/
create table VACINATIONCERTIFICATES (
   CERTIDICATE_ID       varchar(64)          not null,
   PET_ID               numeric              not null,
   CERTIFICATE_DATE     datetime             not null,
   CERTIFICATE_VALIDITY datetime             not null,
   CERTIFICATE_TYPE     varchar(32)          not null
      constraint CKC_CERTIFICATE_TYPE_VACINATI check (CERTIFICATE_TYPE in ('Parvovirus','Canine distemper','Feline distemper','FeLV')),
   constraint PK_VACINATIONCERTIFICATES primary key nonclustered (CERTIDICATE_ID)
)
go

/*==============================================================*/
/* Index: PETVACCINES_FK                                        */
/*==============================================================*/
create index PETVACCINES_FK on VACINATIONCERTIFICATES (
PET_ID ASC
)
go

alter table BOOKING
   add constraint FK_BOOKING_PETBOOKSA_PET foreign key (PET_ID)
      references PET (PET_ID)
go

alter table BOOKING
   add constraint FK_BOOKING_SLOTBOOKE_SESSION foreign key (SESSION_ID)
      references SESSION (SESSION_ID)
go

alter table BREED
   add constraint FK_BREED_BREEDSPEC_SPECIES foreign key (SPECIES_ID)
      references SPECIES (SPECIES_ID)
go

alter table MESSAGES
   add constraint FK_MESSAGES_RECIEVER_USER foreign key (RECEIVER_ID)
      references "USER" (USER_ID)
go

alter table MESSAGES
   add constraint FK_MESSAGES_SENDER_USER foreign key (SENDER_ID)
      references "USER" (USER_ID)
go

alter table PET
   add constraint FK_PET_PETBREED_BREED foreign key (BREED_ID)
      references BREED (BREED_ID)
go

alter table PET
   add constraint FK_PET_PETOWNERS_USER foreign key (USER_ID)
      references "USER" (USER_ID)
go

alter table PREFERREDBREEDS
   add constraint FK_PREFERRE_PREFERRED_BREED foreign key (BREED_ID)
      references BREED (BREED_ID)
go

alter table PREFERREDBREEDS
   add constraint FK_PREFERRE_PREFERRED_USER foreign key (USER_ID)
      references "USER" (USER_ID)
go

alter table SESSION
   add constraint FK_SESSION_RECURRENT_SLOTSREC foreign key (RECURRENCE_ID)
      references SLOTSRECURRENCECONFIGURATION (RECURRENCE_ID)
go

alter table SITTEREXPERTISE
   add constraint FK_SITTEREX_SITTEREXP_AREASOFE foreign key (AREA_ID)
      references AREASOFEXPERTISE (AREA_ID)
go

alter table SITTEREXPERTISE
   add constraint FK_SITTEREX_SITTEREXP_USER foreign key (USER_ID)
      references "USER" (USER_ID)
go

alter table SLOTSRECURRENCECONFIGURATION
   add constraint FK_SLOTSREC_SERVICERE_USER foreign key (USER_ID)
      references "USER" (USER_ID)
go

alter table SLOTTARGETBREEDS
   add constraint FK_SLOTTARG_SLOTTARGE_BREED foreign key (BREED_ID)
      references BREED (BREED_ID)
go

alter table SLOTTARGETBREEDS
   add constraint FK_SLOTTARG_SLOTTARGE_SESSION foreign key (SESSION_ID)
      references SESSION (SESSION_ID)
go

alter table VACINATIONCERTIFICATES
   add constraint FK_VACINATI_PETVACCIN_PET foreign key (PET_ID)
      references PET (PET_ID)
go

