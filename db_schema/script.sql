create table if not exists Company (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists Users (
    Id integer primary key,
    Name varchar(255) not null,
    Password varchar(255) not null,
    Email varchar(255) not null,
    PhoneNumber varchar(15),
    CompanyId integer references Company(Id)
);

create table if not exists Customer (
    Id integer primary key,
    Name varchar(255) not null,
    PhoneNumber varchar(15) not null,
    CompanyId integer references Company (Id)
);

create table if not exists Product (
    Id integer primary key,
    Name varchar(255) not null,
    Price integer not null,
    CompanyId integer references Company (Id)
);

create table if not exists PaymentMethod (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists AccessRole (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists Employee (
    Id integer primary key,
    Name varchar(255) not null,
    HasAccess boolean default false,
    UserId integer references Users (Id),
    CompanyId integer references Company (Id)
);

create table if not exists UserAccessRole (
    Id integer primary key,
    UserId integer references Users (Id),
    RoleId integer references AccessRole (Id)
);

create table if not exists ServiceCategory (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists ComissionType (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists Service (
    Id integer primary key,
    Name varchar(255) not null,
    Price integer not null,
    CompanyId integer references Company (Id),
    Duration integer not null,
    CategoryId integer references ServiceCategory (Id),
    ComissionTypeId integer references ComissionType (Id)
);


create table if not exists EmployeeService (
    Id integer primary key,
    EmployeeId integer references Employee (Id),
    ServiceId integer references Service (Id),
    CompanyId integer references Company (Id)
);

create table if not exists Schedule (
    Id integer primary key,
    ServiceId integer references Service (Id),
    CustomerId integer references Customer (Id),
    EmployeeId integer references Employee (Id),
    Day timestamp not null, -- should probably be indexed,
    CompanyId integer references Company (Id)
);

create table if not exists ServiceRecordStatus (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists ServiceRecord (
    Id integer primary key,
    CustomerId integer references Customer (Id),
    EmployeeId integer references Employee (Id),
    CreatedAt timestamp default current_timestamp,
    UpdatedAt timestamp default current_timestamp,
    StatusId integer references ServiceRecordStatus (Id),
    CompanyId integer references Company (Id)
);

create table if not exists ServiceRecordServiceList (
    Id integer primary key,
    ServiceId integer references Service (Id),
    ServiceRecordId integer references ServiceRecord (Id)
);

create table if not exists ServiceRecordProductList (
    Id integer primary key,
    ServiceRecordId integer references ServiceRecord (Id),
    ProductId integer references Product (Id)
);

create table if not exists ServiceRecordComments (
    Id integer primary key,
    ServiceRecordId integer references ServiceRecord (Id),
    EmployeeComment text
);



create table if not exists ServiceComission (
    Id integer primary key,
    Value integer not null
);

create table if not exists EmployeeServiceComission (
    Id integer primary key,
    ServiceId integer references Service (Id),
    EmployeeId integer references Employee (Id),
    Value integer not null
);

create table if not exists ServiceCombo (
    Id integer primary key,
    Name varchar(255) not null,
    Active boolean,
    CompanyId integer references Company (Id)
);

create table if not exists ServiceComboList (
    Id integer primary key,
    ServiceId integer references Service (Id),
    ServiceComboId integer references ServiceCombo (Id)
);

create table if not exists WeekDay (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists EmployeeSchedule (
    Id integer primary key,
    EmployeeId integer references Employee (Id),
    WeekDayId integer references WeekDay (Id),
    StartTime time not null,
    EndTime time not null,
    HasLunch boolean default false,
    LunchStartTime time,
    LunchEndTIme time
);

create table if not exists DayOffCategory (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists EmployeeDayOff (
    Id integer primary key,
    EmployeeId integer references Employee (Id),
    StartDate date not null,
    EndDate date not null,
    StartTime time not null,
    EndTime time not null,
    CategoryId integer references DayOffCategory (Id)
);

create table if not exists ExpenseCategory (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists ExpenseStatus (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists PaymentType (
    Id integer primary key,
    Name varchar(255) not null
);

create table if not exists Expenses (
    Id integer primary key,
    Name varchar(255) not null,
    Value integer not null,
    ExpenseCategoryId integer references ExpenseCategory (Id),
    StatusId integer references ExpenseStatus (Id),
    PaymentTypeId integer references PaymentType (Id),
    CompanyId integer references Company (Id)
);
    

