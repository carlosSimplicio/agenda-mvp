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

create table Employee (
    Id integer primary key
    Name varchar(255) not null
    HasAccess boolean default false
    UserId integer references User (Id)
    CompanyId integer references Company (Id)
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
    CategoryId integer references ServiceCategory (Id)
    ComissionTypeId integer references ComissionType (Id)
)

create table ServiceEmployeeRole (
    Id integer primary key
    EmployeeRoleId integer references EmployeeRole (Id)
    ServiceId integer references Service (Id)
)

create table EmployeeService (
    Id integer primary key
    EmployeeId integer references Employee (Id)
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
    CreatedAt datetime default current_timestamp
    UpdatedAt datetime default current_timestamp on update current_timestamp
    StatusId integer references ServiceRecordStatus (Id)
)

create table ServiceRecordStatus (
    Id integer primary key
    Name varchar(255) not null
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

create table ServiceCategory (
    Id integer primary key
    Name varchar(255) not null
)

create table ComissionType (
    Id integer primary key
    Name varchar(255) not null
)

create table ServiceComission (
    Id integer primary key
    Value integer not null
)

create table EmployeeServiceComission (
    Id integer primary key
    ServiceId integer references Service (Id)
    EmployeeId integer references Employee (Id) 
    Value integer not null
)

create table ServiceCombo (
    Id integer primary key
    Name varchar(255) not null
    Active boolean
)

create table ServiceComboList (
    Id integer primary key
    ServiceId integer references Service (Id)
)

create table WeekDay (
    Id integer primary key
    Name varchar(255) not null
)

create table EmployeeSchedule (
    Id integer primary key
    EmployeeId integer references Employee (Id) 
    WeekDayId integer references WeekDay (Id)
    StartTime time not null
    EndTime time not null
    HasLunch boolean default false
    LunchStartTime time
    LunchEndTIme time
)

create table EmployeeDayOff (
    Id integer primary key
    EmployeeId integer references Employee (Id) 
    StartDate date not null
    EndDate date not null
    StartTime time not null
    EndTime time not null
    CategoryId integer references DayOffCategory (Id)
)

create table DayOffCategory (
    Id integer primary key
    Name varchar(255) not null
)

create table Expenses (
    Id integer primary key
    Name varchar(255) not null
    Value integer not null
    ExpenseCategoryId integer references ExpenseCategory (Id)
    StatusId integer references ExpenseStatus (Id)
    PaymentTypeId integer references PaymentType (Id)
)

create table ExpenseCategory (
    Id integer primary key
    Name varchar(255) not null
)

create table ExpenseStatus (
    Id integer primary key
    Name varchar(255) not null
)

--mod


    

