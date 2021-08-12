#include <cassert>
#include <cstdlib>
#include <iostream>

template <class TYPE>
class Pile {
 public:
    Pile();

    virtual ~Pile();

    Pile(Pile const& p);

    Pile& operator=(const Pile& p);

    bool operator==(const Pile& p) const;

    bool operator!=(const Pile& p) const;
    void push(TYPE element);

    TYPE pop();

    bool isEmpty() const;

    unsigned int size() const;

 protected:
    unsigned int nbElementMax;
    unsigned int nbElement;
    unsigned int delta;
    TYPE* data;
};
