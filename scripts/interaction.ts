import { ethers } from "hardhat";

async function interaction() {
    const [signer] = await ethers.getSigners();

    const studentRecordContractAddress = "0x85dE0882112F798058a6819e0D51a863Ac80563A";

    const StudentRecordContract = await ethers.getContractAt("IStudentRecord", studentRecordContractAddress);

    const name = "em@rc was here";
    const age = 99;
    const course = "Zero-Knowledge";

    const tx = await StudentRecordContract.connect(signer).addStudent(name, age, course);

    tx.wait();

    console.log(tx);


}

interaction();
