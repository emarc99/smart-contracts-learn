// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentPortal {
    
    struct Student {
        uint256 id;
        string name;
        string course;
        bool exists;
    }

    mapping(uint256 => Student) private students; // Maps student ID to their information
    uint256 public studentCount; // Tracks total number of students
    address public owner;

    event StudentAdded(uint256 id, string name, string course);
    event StudentUpdated(uint256 id, string name, string course);

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    constructor() {
        owner = msg.sender; // Sets the contract deployer as the owner
        studentCount = 0;
    }

    // Add a new student to the portal
    function addStudent(uint256 _id, string memory _name, string memory _course) public onlyOwner {
        require(!students[_id].exists, "Student already exists with this ID");

        students[_id] = Student({
            id: _id,
            name: _name,
            course: _course,
            exists: true
        });

        studentCount += 1;
        emit StudentAdded(_id, _name, _course);
    }

    // Read student details by ID
    function getStudent(uint256 _id) public view returns (string memory name, string memory course) {
        require(students[_id].exists, "Student not found");

        Student memory student = students[_id];
        return (student.name, student.course);
    }

    // Update student details by ID
    function updateStudent(uint256 _id, string memory _name, string memory _course) public onlyOwner {
        require(students[_id].exists, "Student not found");

        students[_id].name = _name;
        students[_id].course = _course;

        emit StudentUpdated(_id, _name, _course);
    }

    // Get the total number of students in the portal
    function getTotalStudents() public view returns (uint256) {
        return studentCount;
    }

    // Function to check if a student exists
    function studentExists(uint256 _id) public view returns (bool) {
        return students[_id].exists;
    }
}
