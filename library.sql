CREATE TABLE Books (
    BookID INT PRIMARY KEY AUTO_INCREMENT,
    Title VARCHAR(255),
    Author VARCHAR(255),
    PublishedYear INT,
    Genre VARCHAR(50),
    Available INT DEFAULT 1  -- 1 means available, 0 means borrowed
);

CREATE TABLE Members (
    MemberID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(255),
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Email VARCHAR(100)
);

CREATE TABLE Loans (
    LoanID INT PRIMARY KEY AUTO_INCREMENT,
    BookID INT,
    MemberID INT,
    LoanDate DATE,
    ReturnDate DATE,
    DueDate DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
);

CREATE TABLE Fines (
    FineID INT PRIMARY KEY AUTO_INCREMENT,
    LoanID INT,
    FineAmount DECIMAL(5,2),
    Paid BOOLEAN DEFAULT 0,  -- 0 means not paid, 1 means paid
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);

INSERT INTO Books (Title, Author, PublishedYear, Genre) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction'),
('To Kill a Mockingbird', 'Harper Lee', 1960, 'Fiction'),
('1984', 'George Orwell', 1949, 'Dystopian');

INSERT INTO Members (Name, Address, PhoneNumber, Email) VALUES
('John Doe', '123 Elm St', '123-456-7890', 'john@example.com'),
('Jane Smith', '456 Oak St', '987-654-3210', 'jane@example.com');

INSERT INTO Loans (BookID, MemberID, LoanDate, DueDate) VALUES
(1, 1, '2024-10-01', '2024-10-15'),
(2, 2, '2024-10-05', '2024-10-20');

INSERT INTO Fines (LoanID, FineAmount) VALUES
(1, 5.00);  -- Fine for the first loan

SELECT * FROM Books;

SELECT * FROM Books WHERE Available = 1;

SELECT M.Name, B.Title, L.LoanDate, L.DueDate 
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
JOIN Books B ON L.BookID = B.BookID;

SELECT M.Name, F.FineAmount 
FROM Members M
JOIN Loans L ON M.MemberID = L.MemberID
JOIN Fines F ON L.LoanID = F.LoanID
WHERE F.Paid = 0;
