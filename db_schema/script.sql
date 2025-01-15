create table Company (
    Id integer primary key
    Name varchar(255) not null
);

create table User (
    Id integer primary key
    Name varchar(255) not null
    Password varchar(255) not null
    Email varchar(255) not null
    PhoneNumber varchar(15)
    CompanyId integer references Company (Id)
);

create table Customer (
    Id integer primary key
    Name varchar(255) not null
    PhoneNumber varchar(15) not null
    CompanyId integer references Company (Id)
);

create table Product (
    Id integer primary key
    Name varchar(255) not null
    Price integer not null
);

create table CompanyProduct (
    Id integer primary key
    CompanyId integer references Company (Id)
    ProductId integer references Product (Id)
)

create table PaymentMethod (
    Id integer primary key
    Name varchar(255) not null
)

create table AccessRole (
    Id integer primary key
    Name varchar(255) not null
)

create table EmployeeRole (
    Id integer primary key
    UserId integer primary key
)

create table UserAccessRole (
    Id integer primary key
    UserId integer references User (Id)
    RoleId integer references Role (Id)
)

create table Service (
    Id integer primary key
    Name varchar(255) not null
    Price integer not null
    CompanyId integer references Company (Id)
    Duration integer not null
)

create table ServiceEmployeeRole (
    Id integer primary key
    EmployeeRoleId integer references EmployeeRole (Id)
    ServiceId integer references Service (Id)
)

create table Schedule (
    Id integer primary key
    ServiceId integer references Service (Id)
    CustomerId integer references Customer (Id)
    EmployeeId integer references Employee (Id)
    Day datetime not null -- should probably be indexed
)

create table ServiceRecord (
    Id integer primary key
    CustomerId integer references Customer (Id)
    EmployeeId integer references Employee (Id)
    Day datetime not null
)

create table ServiceRecordServiceList (
    Id integer primary key
    ServiceId integer references Service (Id)
    ServiceRecordId integer references ServiceRecord (Id)
)

create table ServiceRecordProductList (
    Id integer primary key
    ServiceRecordId integer references ServiceRecord (Id)
    ProductId integer references Product (Id)
)

create table ServiceRecordComments (
    Id integer primary key
    ServiceRecordId integer references ServiceRecord (Id)
    EmployeeComment text
)

