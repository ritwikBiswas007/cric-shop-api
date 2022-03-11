class A {
    static testA() {
        console.log("In A.TestA");
        this.testB();
    }
    static testB() {
        console.log("In A.TestB");
        this.testA();
    }
}
class B {
    static testA() {
        console.log("In B.TestA");
        this.testB();
    }
    static testB() {
        console.log("In B.TestB");
        this.testA();
    }
}
module.exports = { A, B }