#define ClassTest Pile_test

#include "pile.h"

#include "test.h"

class ClassTest : public CppUnit::TestFixture {
    CPPUNIT_TEST_SUITE(ClassTest);
    CPPUNIT_TEST(push);
    CPPUNIT_TEST(size);
    CPPUNIT_TEST(isEmpty);
    CPPUNIT_TEST(constructor_of_copy);
    CPPUNIT_TEST_SUITE_END();

 public:
    void setUp(void) {
        number_of_iterations = 1000;
        p = new Pile<unsigned int>;
    }

    void tearDown(void) { delete p; }

 protected:
    void isEmpty() {
        unsigned int a = 5;
        p->push(a);
        CPPUNIT_ASSERT(p->isEmpty() == false);

        unsigned int b = p->pop();
        CPPUNIT_ASSERT(b == a);
    }

    void size() {
        for (unsigned int i = 0; i < number_of_iterations; i++) p->push(i);

        CPPUNIT_ASSERT(p->size() == number_of_iterations);

        for (unsigned int i = number_of_iterations; 0 < i; i--)
            CPPUNIT_ASSERT(p->pop() == (i - 1));

        CPPUNIT_ASSERT(p->isEmpty() == true);
    }

    void push() {
        Pile<unsigned int> p1;
        Pile<unsigned int> p2;

        for (unsigned int i = 0; i < number_of_iterations; i++) p1.push(i);

        p2 = p1;
        CPPUNIT_ASSERT(p2 == p1);
        CPPUNIT_ASSERT(not(p2 != p1));
        for (unsigned int i = number_of_iterations; 0 < i; i--)
            CPPUNIT_ASSERT(p1.pop() == p2.pop());
    }

    void constructor_of_copy() {
        Pile<unsigned int> p1;

        for (unsigned int i = 0; i < number_of_iterations; i++) p1.push(i);

        Pile<unsigned int> p2(p1);
        CPPUNIT_ASSERT(p2 == p1);
        for (unsigned int i = number_of_iterations; 0 < i; i--)
            CPPUNIT_ASSERT(p1.pop() == p2.pop());
    }

 private:
    Pile<unsigned int>* p;
    unsigned int number_of_iterations;
};

CPPUNIT_TEST_SUITE_REGISTRATION(ClassTest);
